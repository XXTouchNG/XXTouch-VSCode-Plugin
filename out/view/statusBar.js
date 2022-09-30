"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.initStatusBar = exports.setDeviceStatus = void 0;
const vscode = require("vscode");
let statusBarItem;
function setDeviceStatus(ip) {
    statusBarItem.text = `设备: ${ip || '未选择'}`;
}
exports.setDeviceStatus = setDeviceStatus;
function initStatusBar(context) {
    statusBarItem = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Right, 10000);
    statusBarItem.show();
    context.subscriptions.push(statusBarItem);
    setDeviceStatus('');
}
exports.initStatusBar = initStatusBar;
//# sourceMappingURL=statusBar.js.map