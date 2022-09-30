"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.initColor = void 0;
const vscode = require("vscode");
class LuaColor {
    rgbToHex(rgb) {
        let hex = Number(rgb).toString(16);
        if (hex.length < 2) {
            hex = '0' + hex;
        }
        return hex;
    }
    hexToRgbNew(hex) {
        hex = hex.replace('0x', '');
        const arrBuff = new ArrayBuffer(4);
        const vw = new DataView(arrBuff);
        vw.setUint32(0, parseInt(hex, 16), false);
        const arrByte = new Uint8Array(arrBuff);
        if (hex.length === 6) {
            return { r: arrByte[1], g: arrByte[2], b: arrByte[3], o: 255 };
        }
        return { r: arrByte[0], g: arrByte[1], b: arrByte[2], o: arrByte[3] };
    }
    provideDocumentColors(document) {
        const colorArr = [];
        const sourceCode = document.getText();
        const sourceCodeArr = sourceCode.split('\n');
        const regex = /(0x[a-f0-9A-F]{6,8})/;
        for (let line = 0; line < sourceCodeArr.length; line++) {
            let match = sourceCodeArr[line].match(regex);
            while (match !== null && match.index !== undefined) {
                const range = new vscode.Range(new vscode.Position(line, match.index), new vscode.Position(line, match.index + match[1].length));
                const rgbColor = this.hexToRgbNew(match[1]);
                sourceCodeArr[line] = sourceCodeArr[line].replace(match[1], new Array(match[1].length).fill('*').join(''));
                const colorCode = new vscode.ColorInformation(range, new vscode.Color(rgbColor.r / 255, rgbColor.g / 255, rgbColor.b / 255, rgbColor.o / 255));
                colorArr.push(colorCode);
                match = sourceCodeArr[line].match(regex);
            }
        }
        return colorArr;
    }
    provideColorPresentations(color) {
        const colorObj = {
            red: 0,
            green: 0,
            blue: 0,
            alpha: 0,
        };
        colorObj.red = color.red * 255;
        colorObj.green = color.green * 255;
        colorObj.blue = color.blue * 255;
        colorObj.alpha = Math.round(color.alpha * 255);
        let colorLabel;
        if (colorObj.alpha === 255) {
            colorLabel = String(String(this.rgbToHex(colorObj.red)) +
                String(this.rgbToHex(colorObj.green)) +
                String(this.rgbToHex(colorObj.blue)));
        }
        else {
            colorLabel = String(String(this.rgbToHex(colorObj.red)) +
                String(this.rgbToHex(colorObj.green)) +
                String(this.rgbToHex(colorObj.blue) + this.rgbToHex(colorObj.alpha)));
        }
        return [new vscode.ColorPresentation('0x' + colorLabel.toLocaleUpperCase())];
    }
}
function initColor(context) {
    const configuration = vscode.workspace.getConfiguration();
    const enabled = configuration.get('xxtouch.lua.colorDecorators.enabled');
    if (!enabled) {
        return;
    }
    context.subscriptions.push(vscode.languages.registerColorProvider({
        pattern: '**/*.lua',
    }, new LuaColor()));
}
exports.initColor = initColor;
//# sourceMappingURL=color.js.map