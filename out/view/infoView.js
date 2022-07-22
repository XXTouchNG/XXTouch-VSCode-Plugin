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
exports.initInfoView = exports.infoDataProvider = exports.currentRoot = void 0;
const vscode = require("vscode");
const api_1 = require("../lib/api");
exports.currentRoot = '';
class InfoDataProvider {
    constructor() {
        this.refresh = new vscode.EventEmitter();
        this.onDidChangeTreeData = this.refresh.event;
        this.infos = [];
    }
    getTreeItem(element) {
        return element;
    }
    getChildren(element) {
        if (!element) {
            return this.infos;
        }
    }
    update(ip) {
        return __awaiter(this, void 0, void 0, function* () {
            const api = new api_1.API(ip);
            const state = yield api.appState();
            if (!state) {
                return;
            }
            exports.currentRoot =
                state.system.os === 'ios' ? '/' : '/mnt/sdcard/touchelf';
            this.infos = [
                new vscode.TreeItem(`触摸精灵: ${state.app.version}`),
                new vscode.TreeItem(`激活到期: ${state.app.license}`),
                new vscode.TreeItem(`当前选择: ${state.script.select}`),
                new vscode.TreeItem(`是否运行: ${state.script.running ? '是' : '否'}`),
                new vscode.TreeItem(`设备系统: ${state.system.os == 'ios' ? 'iOS' : 'Android'}`),
                new vscode.TreeItem(`设备名称: ${state.system.name}`),
                new vscode.TreeItem(`设备串号: ${state.system.sn}`),
                new vscode.TreeItem(`设备地址: ${state.system.ip}`),
                new vscode.TreeItem(`设备电量: ${state.system.battery}`),
            ];
            this.refresh.fire();
        });
    }
}
exports.infoDataProvider = new InfoDataProvider();
function initInfoView() {
    vscode.window.registerTreeDataProvider('touchelf-info-view', exports.infoDataProvider);
}
exports.initInfoView = initInfoView;
//# sourceMappingURL=infoView.js.map