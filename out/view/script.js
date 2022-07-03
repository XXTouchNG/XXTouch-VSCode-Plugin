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
exports.initScript = void 0;

const fs = require("fs");
const path = require("path");
const tar = require("tar");
const vscode = require("vscode");
const api_1 = require("../lib/api");
const deviceView_1 = require("./deviceView");

function getDevice() {
    if (deviceView_1.currentDevice) {
        return [true, deviceView_1.currentDevice];
    } else {
        vscode.window.showErrorMessage('请先选择设备');
        return [false, deviceView_1.currentDevice];
    }
}

function runScript(shouldDebug) {
    var _a;
    return __awaiter(this, void 0, void 0, function* () {
        const [success, device] = getDevice();
        if (!success) {
            return;
        }

        const currentDocument = (_a = vscode.window.activeTextEditor) === null || _a === void 0 ? void 0 : _a.document;
        if (!currentDocument) {
            return;
        }

        const activeFolder = vscode.workspace.workspaceFolders !== undefined ? vscode.workspace.workspaceFolders[0] : undefined;
        const activeFolderPath = activeFolder !== undefined ? activeFolder.uri.fsPath : undefined;
        
        const api = new api_1.API(device);

        const doLocalRunOrDebug = shouldDebug
            ? (f) => __awaiter(this, void 0, void 0, function* () { return api.debugLocalScript(f); })
            : (f) => __awaiter(this, void 0, void 0, function* () { return api.runLocalScript(f); });
        const doRemoteRunOrDebug = shouldDebug
            ? (f) => __awaiter(this, void 0, void 0, function* () { return api.debugRemoteScript(f); })
            : (f) => __awaiter(this, void 0, void 0, function* () { return api.runRemoteScript(f); });

        const uploadTar = (f) => __awaiter(this, void 0, void 0, function* () { return api.putFile('caches', f); });
        const extractTar = (f) => __awaiter(this, void 0, void 0, function* () { return api.extractFile('caches', f, 'lua/scripts'); });

        if (activeFolder !== undefined)
        {   // lua project
            const currentDocumentRelativePath = path.relative(activeFolderPath, currentDocument.uri.fsPath);
            if (currentDocumentRelativePath.startsWith('../')) {
                vscode.window.showErrorMessage('请在工作区内调试脚本');
                return;
            }
            
            yield currentDocument.save();
            const tarball = `${activeFolderPath}.tar`;
            vscode.window.setStatusBarMessage('正在打包项目…');
            yield tar.create({ file: tarball, cwd: activeFolderPath }, fs.readdirSync(activeFolderPath));  // create tarball

            vscode.window.setStatusBarMessage('正在上传项目…');
            if (yield uploadTar(tarball)) {  // upload tarball to device

                vscode.window.setStatusBarMessage('正在解压项目…');
                if (yield extractTar(tarball)) {  // extract tarball to device
                    
                    if (yield doRemoteRunOrDebug(currentDocumentRelativePath)) {
                        vscode.window.setStatusBarMessage(`运行 ${currentDocumentRelativePath} 成功`);
                    } else {
                        vscode.window.setStatusBarMessage(`运行 ${currentDocumentRelativePath} 失败`);
                    }
                } else {
                    vscode.window.showErrorMessage('解压项目失败');
                }
            } else {
                vscode.window.showErrorMessage('上传项目失败');
            }
        } 
        else
        {   // single lua file
            if (currentDocument.uri.scheme === 'output') {
                vscode.window.showWarningMessage('请先将焦点切换至 lua 文件');
                return;
            }

            yield currentDocument.save();
            if (yield doLocalRunOrDebug(currentDocument.uri.fsPath)) {
                vscode.window.setStatusBarMessage(`运行 ${path.basename(currentDocument.uri.fsPath)} 成功`);
            } else {
                vscode.window.setStatusBarMessage(`运行 ${path.basename(currentDocument.uri.fsPath)} 失败`);
            }
        }
    });
}

var isRunTaskBusy = false;
var isDebugTaskBusy = false;

function initScript() {
    var _a;
    vscode.commands.registerCommand('touchelf.script.run', () => __awaiter(this, void 0, void 0, function* () {
        if (isRunTaskBusy || vscode.debug.activeDebugSession !== undefined) {
            return;
        }

        isRunTaskBusy = true;
        yield runScript(false);
        isRunTaskBusy = false;
    }));
    vscode.commands.registerCommand('touchelf.script.debug', () => __awaiter(this, void 0, void 0, function* () {
        if (isDebugTaskBusy || vscode.debug.activeDebugSession !== undefined) {
            return;
        }

        isDebugTaskBusy = true;

        const [success, device] = getDevice();
        if (!success) {
            isDebugTaskBusy = false;
            return;
        }

        const currentDocument = (_a = vscode.window.activeTextEditor) === null || _a === void 0 ? void 0 : _a.document;
        if (!currentDocument) {
            isDebugTaskBusy = false;
            return;
        }

        const activeFolder = vscode.workspace.workspaceFolders !== undefined ? vscode.workspace.workspaceFolders[0] : undefined;
        const activeFolderPath = activeFolder !== undefined ? activeFolder.uri.fsPath : undefined;
        
        if (activeFolder !== undefined)
        {   // lua project
            const currentDocumentRelativePath = path.relative(activeFolderPath, currentDocument.uri.fsPath);
            if (currentDocumentRelativePath.startsWith('../')) {
                vscode.window.showErrorMessage('请在工作区内调试脚本');
                isDebugTaskBusy = false;
                return;
            }
        } else {
            vscode.window.showErrorMessage('请在工作区内调试脚本');
            isDebugTaskBusy = false;
            return;
        }

        const api = new api_1.API(device);
        const isDeviceBusy = () => __awaiter(this, void 0, void 0, function* () { 
            const state = yield api.appState();
            if (!state) {
                return false;
            }
            return state.script.running;
        });

        if (yield isDeviceBusy()) {
            vscode.window.showWarningMessage('设备正在进行其他任务, 请稍后再试');
            isDebugTaskBusy = false
            return;
        }
        
        vscode.debug.startDebugging(activeFolder, 'LuaPanda')
        .then(() => {
            runScript(true);
            isDebugTaskBusy = false;
        });
    }));
    vscode.commands.registerCommand('touchelf.script.stop', () => __awaiter(this, void 0, void 0, function* () {
        const [success, device] = getDevice();
        if (!success) {
            return;
        }

        const api = new api_1.API(device);
        if (yield api.stopScript()) {
            vscode.window.setStatusBarMessage('停止成功', 5000);
        }
    }));
}

exports.initScript = initScript;
//# sourceMappingURL=script.js.map