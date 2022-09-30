"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.initDeviceView = exports.currentDevice = void 0;
const dgram = require("dgram");
const fs = require("fs");
const os = require("os");
const path = require("path");
const vscode = require("vscode");
const broadcastAddress = require("broadcast-address");
const api_1 = require("../lib/api");
const fileView_1 = require("./fileView");
const infoView_1 = require("./infoView");
const statusBar_1 = require("./statusBar");
class Device extends vscode.TreeItem {
    constructor(ip, name) {
        super(name || ip);
        this.tooltip = ip;
        this.ip = ip;
        this.name = name;
        this.iconPath = {
            dark: path.join(__filename, '..', '..', '..', 'assets', 'dark', 'device.png'),
            light: path.join(__filename, '..', '..', '..', 'assets', 'light', 'device.png'),
        };
        this.command = {
            command: 'xxtouch.device.select',
            title: '选择',
            arguments: [this],
        };
    }
}
class DeviceDataProvider {
    constructor() {
        this.refresh = new vscode.EventEmitter();
        this.onDidChangeTreeData = this.refresh.event;
        this.devices = [];
    }
    getTreeItem(element) {
        return element;
    }
    getChildren(element) {
        if (!element) {
            return this.devices;
        }
    }
    addDevice(ip, name) {
        this.devices.find((item) => item.ip === ip) || this.devices.push(new Device(ip, name));
        this.devices.sort((a, b) => {
            if (a.name && b.name) {
                return a.name.localeCompare(b.name, undefined, {
                    numeric: true,
                    sensitivity: 'base'
                });
            }
            const ip = (device) => Number(device.ip
                .split('.')
                .map((num) => `000${num}`.slice(-3))
                .join(''));
            return ip(a) - ip(b);
        });
        this.refresh.fire();
    }
    scan() {
        const client = dgram.createSocket({ type: 'udp4', reuseAddr: true });
        client.on('listening', () => {
            client.setBroadcast(true);
            client.on('message', (data, info) => {
                if (data.toString().startsWith('touchelf') &&
                    !this.devices.filter((item) => item.ip === info.address).length) 
                {
                    if (data.length <= 9) {
                        this.addDevice(info.address);
                    } else {
                        this.addDevice(info.address, data.toString().substring(9));
                    }
                }
            });
            client.send('touchelf', 14099, '255.255.255.255');
            for (const [ifname, addresses] of Object.entries(os.networkInterfaces())) {
                if (ifname.startsWith("en")) {
                    addresses.forEach((address) => {
                        if (address.family === "IPv4" && !address.address.startsWith("169.254.")) {
                            client.send('touchelf', 14099, broadcastAddress(ifname));
                        }
                    });
                }
            }
        });
        client.bind();
    }
    add(ip) {
        const api = new api_1.API(ip);
        const getDeviceName = () => __awaiter(this, void 0, void 0, function* () { 
            const state = yield api.appState();
            if (!state) {
                return;
            }
            return state.system.name;
        });
        getDeviceName().then((name) => {
            this.addDevice(ip, name);
        });
    }
    trash() {
        this.devices = [];
        this.refresh.fire();
    }
}
exports.currentDevice = '';
const outputChannel = vscode.window.createOutputChannel('xxtouch');
let lastLog = '';
let interval = undefined;
function initDeviceView(context) {
    const deviceDataProvider = new DeviceDataProvider();
    vscode.window.registerTreeDataProvider('xxtouch-device-view', deviceDataProvider);
    vscode.commands.registerCommand('xxtouch.device.scan', () => {
        deviceDataProvider.scan();
    });
    vscode.commands.registerCommand('xxtouch.device.trash', () => {
        deviceDataProvider.trash();
    });
    vscode.commands.registerCommand('xxtouch.device.add', () => {
        vscode.window
            .showInputBox({
                prompt: '设备IP地址',
            })
            .then((ip) => {
                if (ip) {
                    if (/^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/.test(ip)) {
                        deviceDataProvider.add(ip);
                    }
                    else {
                        vscode.window.showErrorMessage('错误的IP格式');
                    }
                }
            });
    });
    vscode.commands.registerCommand('xxtouch.device.select', (device) => __awaiter(this, void 0, void 0, function* () {
        exports.currentDevice = device.ip;
        statusBar_1.setDeviceStatus(device.ip);
        yield infoView_1.infoDataProvider.update(device.ip);
        yield fileView_1.fileDataprovider.update(device.ip);
        vscode.window.setStatusBarMessage(`切换设备至: ${device.ip}`, 5000);
        lastLog = '';
        outputChannel.clear();
        outputChannel.show(true);
        if (interval) {
            clearInterval(interval);
        }
        const api = new api_1.API(device.ip);
        interval = setInterval(() => __awaiter(this, void 0, void 0, function* () {
            const timestampRegex = /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2} \[(TRACE|DEBUG|INFO|NOTICE|WARNING|ERROR|FATAL|ALERT|EMERG)\]/;
            const log = (yield api.getSystemLog()).trim().split('\n');
            let append = false;
            for (const line of log) {
                if (append) {
                    outputChannel.appendLine(line);
                }
                else {
                    const match = line.match(timestampRegex);
                    if (match) {
                        if (match[0] > lastLog) {
                            append = true;
                            outputChannel.appendLine(line);
                        }
                    }
                }
            }
            for (const line of log.reverse()) {
                const match = line.match(timestampRegex);
                if (match) {
                    lastLog = match[0];
                    break;
                }
            }
        }), 2000);
        vscode.commands.executeCommand('xxtouch.device.nlog', device);
    }));
    vscode.commands.registerCommand('xxtouch.device.ui', (device) => {
        vscode.env.openExternal(vscode.Uri.parse(`http://${device.ip}:46952/index.html`));
    });
    vscode.commands.registerCommand('xxtouch.device.nlog', (device) => {
        const terminalName = "网络日志 - " + (device.name || device.ip);
        let terminal = vscode.window.terminals.find((terminal) => terminal.name === terminalName);
        if (!terminal) {
            const highlightBinaryPath = context.asAbsolutePath(path.join('node_modules', '.bin', 'highlight'));
            terminal = vscode.window.createTerminal({
                name: terminalName,
                hideFromUser: false,
                shellPath: 'zsh',
                shellArgs: ['-c', `echo '日志服务已启动：${device.name}（${device.ip}）'; websocat --ping-interval 1 --ping-timeout 15 -E -0 ws://${device.ip}:46957 | ${highlightBinaryPath} -l lua`],
            });
        }
        if (terminal) {
            terminal.show();
        }
    });
    function getWebviewContent(context, templatePath) {
        const template = path.join(context.extensionPath, templatePath);
        const staticPath = path.join(context.extensionPath, "assets/webview/static");
        const html = fs.readFileSync(template, 'utf-8').replace(/(<link.+?href="|<script.+?src=")(.+?)"/g, (m, $1, $2) => {
            return $1 + vscode.Uri.file(path.join(staticPath, $2)).with({ scheme: 'vscode-resource' }).toString() + '"';
        });
        return html;
    }
    vscode.commands.registerCommand('xxtouch.fetch.screen', (device) => __awaiter(this, void 0, void 0, function* () {
        const webviewPanel = vscode.window.createWebviewPanel('xxtouch-fetch-screen', device ? `屏幕抓抓 - ${device.ip}` : '屏幕抓抓', vscode.ViewColumn.One, {
            enableScripts: true,
            retainContextWhenHidden: true,
        });
        webviewPanel.webview.html = getWebviewContent(context, 'assets/webview/screen/index.html');
        webviewPanel.webview.onDidReceiveMessage((message) => __awaiter(this, void 0, void 0, function* () {
            switch (message.command) {
                case 'init':
                case 'fetch':
                    {
                        const ip = device ? device.ip : exports.currentDevice;
                        if (!ip) {
                            if (message.command !== 'init') {
                                vscode.window.showErrorMessage('请先选择设备');
                            }
                            return;
                        }
                        const api = new api_1.API(ip);
                        const screen = yield api.getScreenSnapshot();
                        if (screen) {
                            webviewPanel.webview.postMessage({
                                command: 'init',
                                payload: screen.toString('base64'),
                            });
                        }
                    }
                    break;
                case 'openLocal':
                    vscode.window
                        .showOpenDialog({
                            filters: { 图片: ['png'] },
                        })
                        .then((info) => __awaiter(this, void 0, void 0, function* () {
                            if (info && info.length) {
                                webviewPanel.webview.postMessage({
                                    command: 'init',
                                    payload: Buffer.from(fs.readFileSync(info[0].fsPath)).toString('base64'),
                                });
                            }
                        }));
                    break;
                case 'copy':
                    vscode.env.clipboard.writeText(message.payload);
                    break;
                case 'saveImage':
                    {
                        let lastSave = context.globalState.get('lastSave');
                        if (!lastSave) {
                            lastSave = os.homedir();
                        }
                        vscode.window
                            .showSaveDialog({
                                defaultUri: vscode.Uri.file(path.join(lastSave, `截图${Date.now()}.png`)),
                            })
                            .then((info) => {
                                if (info) {
                                    context.globalState.update('lastSave', path.dirname(info.fsPath));
                                    fs.writeFileSync(info.fsPath, Buffer.from(message.payload, 'base64'));
                                    vscode.window.setStatusBarMessage(`图片保存成功`, 5000);
                                }
                            });
                    }
                    break;
                case 'loadTemplate':
                    webviewPanel.webview.postMessage({
                        command: 'loadTemplate',
                        payload: context.globalState.get('templates'),
                    });
                    break;
                case 'saveTemplate':
                    context.globalState.update('templates', message.payload);
                    vscode.window.setStatusBarMessage(`代码模板保存成功`, 5000);
                    break;
                default:
                    console.log(`unknown ${message.command}`);
                    break;
            }
        }));
    }));
}
exports.initDeviceView = initDeviceView;
//# sourceMappingURL=deviceView.js.map