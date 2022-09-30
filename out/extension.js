"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.activate = void 0;
const client_1 = require("./assist/client");
const color_1 = require("./assist/color");
const format_1 = require("./assist/format");
const deviceView_1 = require("./view/deviceView");
const fileView_1 = require("./view/fileView");
const infoView_1 = require("./view/infoView");
const script_1 = require("./view/script");
const statusBar_1 = require("./view/statusBar");
function activate(context) {
    deviceView_1.initDeviceView(context);
    fileView_1.initFileView();
    infoView_1.initInfoView();
    statusBar_1.initStatusBar(context);
    script_1.initScript();
    format_1.initFormatter();
    color_1.initColor(context);
    client_1.initAssist(context);
}
exports.activate = activate;
//# sourceMappingURL=extension.js.map