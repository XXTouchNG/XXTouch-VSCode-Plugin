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

const path = require("path");
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

var isRunTaskBusy = false;
var isDebugTaskBusy = false;

function initScript() {
    var _a;
    vscode.commands.registerCommand('xxtouch.script.run', () => __awaiter(this, void 0, void 0, function* () {
        if (isRunTaskBusy || isDebugTaskBusy || vscode.debug.activeDebugSession !== undefined) {
            return;
        }

        isRunTaskBusy = true;

        const [success, device] = getDevice();
        if (!success) {
            isRunTaskBusy = false;
            return;
        }

        const api = new api_1.API(device);
        const isDeviceBusy = () => __awaiter(this, void 0, void 0, function* () {
            const state = yield api.appState();
            if (!state) return false;
            return state.script.running;
        });

        if (yield isDeviceBusy()) {
            vscode.window.showWarningMessage('设备正在进行其他任务, 请稍后再试');
            isRunTaskBusy = false
            return;
        }

        yield deviceView_1.runScript(device, false);
        isRunTaskBusy = false;
    }));
    vscode.commands.registerCommand('xxtouch.script.debug', () => __awaiter(this, void 0, void 0, function* () {
        if (isDebugTaskBusy || isRunTaskBusy || vscode.debug.activeDebugSession !== undefined) {
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
            deviceView_1.runScript(device, true);
            isDebugTaskBusy = false;
        });
    }));
    vscode.commands.registerCommand('xxtouch.script.stop', () => __awaiter(this, void 0, void 0, function* () {
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