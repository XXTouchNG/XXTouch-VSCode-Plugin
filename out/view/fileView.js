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
exports.initFileView = exports.fileDataprovider = void 0;
const fs = require("fs");
const os = require("os");
const path = require("path");
const vscode = require("vscode");
const api_1 = require("../lib/api");
const deviceView_1 = require("./deviceView");
const infoView_1 = require("./infoView");
class Entry extends vscode.TreeItem {
    constructor(absolutePath, type) {
        super(absolutePath === '/' ? infoView_1.currentRoot : path.basename(absolutePath), type === 'file'
            ? vscode.TreeItemCollapsibleState.None
            : absolutePath === '/'
                ? vscode.TreeItemCollapsibleState.Expanded
                : vscode.TreeItemCollapsibleState.Collapsed);
        this.absolutePath = absolutePath;
        this.type = type;
        this.contextValue = type;
        const icon = type === 'file' ? 'file.png' : 'folder.png';
        this.iconPath = {
            dark: path.join(__filename, '..', '..', '..', 'assets', 'dark', icon),
            light: path.join(__filename, '..', '..', '..', 'assets', 'light', icon),
        };
        this.command = {
            command: 'xxtouch.file.preview',
            title: '预览',
            arguments: [this],
        };
    }
    compare(entry) {
        return this.type !== entry.type
            ? this.type.localeCompare(entry.type)
            : this.absolutePath.localeCompare(entry.absolutePath);
    }
}
class FileDataProvider {
    constructor() {
        this.refresh = new vscode.EventEmitter();
        this.onDidChangeTreeData = this.refresh.event;
        this.api = undefined;
    }
    getTreeItem(element) {
        return element;
    }
    getChildren(element) {
        return __awaiter(this, void 0, void 0, function* () {
            if (element) {
                if (this.api) {
                    const files = yield this.api.readDir(element.absolutePath);
                    return files
                        .map((item) => new Entry(`${element.absolutePath}/${item.name}`, item.type))
                        .sort((a, b) => a.compare(b));
                }
                else {
                    return [];
                }
            }
            else {
                return deviceView_1.currentDevice ? [new Entry('/', 'dir')] : [];
            }
        });
    }
    update(ip) {
        return __awaiter(this, void 0, void 0, function* () {
            this.api = new api_1.API(ip);
            this.refresh.fire();
        });
    }
    reload() {
        this.refresh.fire();
    }
}
exports.fileDataprovider = new FileDataProvider();
function initFileView() {
    vscode.window.registerTreeDataProvider('xxtouch-file-view', exports.fileDataprovider);
    vscode.commands.registerCommand('xxtouch.file.refresh', () => {
        exports.fileDataprovider.reload();
    });
    vscode.commands.registerCommand('xxtouch.file.download', (entry) => __awaiter(this, void 0, void 0, function* () {
        const api = new api_1.API(deviceView_1.currentDevice);
        const data = yield api.getFile(entry.absolutePath);
        if (data) {
            vscode.window
                .showSaveDialog({
                defaultUri: vscode.Uri.file(path.join(os.homedir(), path.basename(entry.absolutePath))),
            })
                .then((info) => {
                if (info) {
                    fs.writeFileSync(info.fsPath, data);
                    vscode.window.setStatusBarMessage(`${entry.label} 下载成功`, 5000);
                }
            });
        }
    }));
    vscode.commands.registerCommand('xxtouch.file.upload', (entry) => {
        vscode.window.showOpenDialog({}).then((info) => __awaiter(this, void 0, void 0, function* () {
            if (info && info.length) {
                const api = new api_1.API(deviceView_1.currentDevice);
                const success = yield api.putFile(entry.absolutePath, info[0].fsPath);
                if (success) {
                    exports.fileDataprovider.update(deviceView_1.currentDevice);
                    vscode.window.setStatusBarMessage(`${path.basename(info[0].path)} 上传成功`, 5000);
                }
            }
        }));
    });
    vscode.commands.registerCommand('xxtouch.file.delete', (entry) => __awaiter(this, void 0, void 0, function* () {
        const api = new api_1.API(deviceView_1.currentDevice);
        const success = yield api.deleteFile(entry.absolutePath);
        if (success) {
            exports.fileDataprovider.update(deviceView_1.currentDevice);
            vscode.window.setStatusBarMessage(`${entry.label} 删除成功`, 5000);
        }
    }));
    vscode.commands.registerCommand('xxtouch.file.preview', (entry) => __awaiter(this, void 0, void 0, function* () {
        if (!entry.absolutePath.match(/\.(jpg|jpeg|png|bmp|txt|lua)$/i)) {
            return;
        }
        const api = new api_1.API(deviceView_1.currentDevice);
        const data = yield api.getFile(entry.absolutePath);
        if (data && entry.label) {
            try {
                const tmp = path.join(os.tmpdir(), path.basename(entry.absolutePath));
                fs.writeFileSync(tmp, data);
                yield vscode.commands.executeCommand('vscode.open', vscode.Uri.file(tmp));
                vscode.window.setStatusBarMessage(`${entry.label} 预览成功`, 5000);
            }
            catch (e) {
                console.log(e);
            }
        }
    }));
}
exports.initFileView = initFileView;
//# sourceMappingURL=fileView.js.map