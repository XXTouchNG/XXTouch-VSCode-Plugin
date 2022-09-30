"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.initFormatter = void 0;
const diff_1 = require("diff");
const lua_fmt_ext_1 = require("lua-fmt-ext");
const vscode = require("vscode");
var EditAction;
(function (EditAction) {
    EditAction[EditAction["Replace"] = 0] = "Replace";
    EditAction[EditAction["Insert"] = 1] = "Insert";
    EditAction[EditAction["Delete"] = 2] = "Delete";
})(EditAction || (EditAction = {}));
class Edit {
    constructor(action, start) {
        this.text = '';
        this.action = action;
        this.start = start;
        this.end = new vscode.Position(0, 0);
    }
}
function toTextEdit(document, text, formattedText) {
    const patch = lua_fmt_ext_1.producePatch(document.uri.fsPath, text, formattedText);
    const edits = [];
    let currrent = null;
    for (const diff of diff_1.parsePatch(patch)) {
        for (const hunk of diff.hunks) {
            let startLine = hunk.oldStart;
            for (const line of hunk.lines) {
                switch (line[0]) {
                    case '-':
                        if (!currrent) {
                            currrent = new Edit(EditAction.Delete, new vscode.Position(startLine - 1, 0));
                        }
                        currrent.end = new vscode.Position(startLine, 0);
                        startLine++;
                        break;
                    case '+':
                        if (!currrent) {
                            currrent = new Edit(EditAction.Insert, new vscode.Position(startLine - 1, 0));
                        }
                        else if (currrent.action === EditAction.Delete) {
                            currrent.action = EditAction.Replace;
                        }
                        currrent.text += line.substr(1) + '\n';
                        break;
                    case ' ':
                        startLine++;
                        if (currrent) {
                            edits.push(currrent);
                        }
                        currrent = null;
                        break;
                }
            }
        }
        if (currrent) {
            edits.push(currrent);
        }
    }
    return edits.map((edit) => {
        switch (edit.action) {
            case EditAction.Replace:
                return vscode.TextEdit.replace(new vscode.Range(edit.start, edit.end), edit.text);
            case EditAction.Insert:
                return vscode.TextEdit.insert(edit.start, edit.text);
            case EditAction.Delete:
                return vscode.TextEdit.delete(new vscode.Range(edit.start, edit.end));
        }
    });
}
function initFormatter() {
    vscode.languages.registerDocumentFormattingEditProvider('lua', {
        provideDocumentFormattingEdits(document) {
            const configuration = vscode.workspace.getConfiguration();
            const enabled = configuration.get('xxtouch.lua.format.enabled');
            if (!enabled) {
                return [];
            }
            const text = document.getText();
            let formattedText;
            try {
                formattedText = lua_fmt_ext_1.formatText(text, {
                    lineWidth: configuration.get('xxtouch.lua.format.lineWidth'),
                    indentCount: configuration.get('editor.tabSize') || 4,
                    useTabs: false,
                    linebreakMultipleAssignments: false,
                    quotemark: configuration.get('xxtouch.lua.format.singleQuote')
                        ? 'single'
                        : 'double',
                    writeMode: lua_fmt_ext_1.WriteMode.Diff,
                });
            }
            catch (_a) {
                return [];
            }
            return toTextEdit(document, text, formattedText);
        },
    });
}
exports.initFormatter = initFormatter;
//# sourceMappingURL=format.js.map