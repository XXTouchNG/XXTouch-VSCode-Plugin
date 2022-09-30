"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deactivate = exports.initAssist = void 0;
const fs = require("fs");
const os = require("os");
const path = require("path");
const vscode = require("vscode");
const node_1 = require("vscode-languageclient/node");
let defaultClient;
const clients = new Map();
function registerCustomCommands(context) {
    context.subscriptions.push(vscode.commands.registerCommand('xxtouch.lua.config', (data) => {
        const config = vscode.workspace.getConfiguration(undefined, vscode.Uri.parse(data.uri));
        if (data.action == 'add') {
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            const value = config.get(data.key);
            if (value) {
                value.push(data.value);
                config.update(data.key, value);
            }
            return;
        }
        if (data.action == 'set') {
            config.update(data.key, data.value);
            return;
        }
    }));
}
let _sortedWorkspaceFolders;
function sortedWorkspaceFolders() {
    if (_sortedWorkspaceFolders === void 0) {
        _sortedWorkspaceFolders = vscode.workspace.workspaceFolders
            ? vscode.workspace.workspaceFolders
                .map((folder) => {
                let result = folder.uri.toString();
                if (result.charAt(result.length - 1) !== '/') {
                    result = result + '/';
                }
                return result;
            })
                .sort((a, b) => {
                return a.length - b.length;
            })
            : [];
    }
    return _sortedWorkspaceFolders;
}
vscode.workspace.onDidChangeWorkspaceFolders(() => (_sortedWorkspaceFolders = undefined));
function getOuterMostWorkspaceFolder(folder) {
    const sorted = sortedWorkspaceFolders();
    for (const element of sorted) {
        let uri = folder.uri.toString();
        if (uri.charAt(uri.length - 1) !== '/') {
            uri = uri + '/';
        }
        if (uri.startsWith(element)) {
            // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
            return vscode.workspace.getWorkspaceFolder(vscode.Uri.parse(element));
        }
    }
    return folder;
}
function start(context, documentSelector, folder) {
    // Options to control the language client
    const clientOptions = {
        // Register the server for plain text documents
        documentSelector: documentSelector,
        workspaceFolder: folder,
        progressOnInitialization: true,
        markdown: {
            isTrusted: true,
        },
    };
    let command = '';
    const platform = os.platform();
    switch (platform) {
        case 'win32':
            command = context.asAbsolutePath(path.join('server', 'bin', 'Windows', 'lua-language-server.exe'));
            break;
        case 'linux':
            command = context.asAbsolutePath(path.join('server', 'bin', 'Linux', 'lua-language-server'));
            fs.chmodSync(command, '777');
            break;
        case 'darwin':
            command = context.asAbsolutePath(path.join('server', 'bin', 'macOS', 'lua-language-server'));
            fs.chmodSync(command, '777');
            break;
    }
    const serverOptions = {
        command: command,
        args: [
            '-E',
            '-e',
            `DEVELOP=false;DBGPORT=11412;DBGWAIT=false`,
            context.asAbsolutePath(path.join('server', 'main.lua')),
        ],
    };
    const client = new node_1.LanguageClient('Lua', 'Lua', serverOptions, clientOptions);
    client.registerProposedFeatures();
    client.start();
    return client;
}
function initAssist(context) {
    registerCustomCommands(context);
    function didOpenTextDocument(document) {
        // We are only interested in language mode text
        if (document.languageId !== 'lua' ||
            (document.uri.scheme !== 'file' && document.uri.scheme !== 'untitled')) {
            return;
        }
        const uri = document.uri;
        let folder = vscode.workspace.getWorkspaceFolder(uri);
        // Untitled files go to a default client.
        if (folder == null &&
            vscode.workspace.workspaceFolders == null &&
            !defaultClient) {
            defaultClient = start(context, [{ scheme: 'file', language: 'lua' }], undefined);
            return;
        }
        // Files outside a folder can't be handled. This might depend on the language.
        // Single file languages like JSON might handle files outside the workspace folders.
        if (!folder) {
            return;
        }
        // If we have nested workspace folders we only start a server on the outer most workspace folder.
        folder = getOuterMostWorkspaceFolder(folder);
        if (!clients.has(folder.uri.toString())) {
            const client = start(context, [
                {
                    scheme: 'file',
                    language: 'lua',
                    pattern: `${folder.uri.fsPath}/**/*`,
                },
            ], folder);
            clients.set(folder.uri.toString(), client);
        }
    }
    vscode.workspace.onDidOpenTextDocument(didOpenTextDocument);
    //vscode.workspace.onDidCloseTextDocument(didCloseTextDocument);
    vscode.workspace.textDocuments.forEach(didOpenTextDocument);
    vscode.workspace.onDidChangeWorkspaceFolders((event) => {
        for (const folder of event.removed) {
            const client = clients.get(folder.uri.toString());
            if (client) {
                clients.delete(folder.uri.toString());
                client.stop();
            }
        }
    });
}
exports.initAssist = initAssist;
function deactivate() {
    const promises = [];
    if (defaultClient) {
        promises.push(defaultClient.stop());
    }
    for (const client of clients.values()) {
        promises.push(client.stop());
    }
    return Promise.all(promises).then(() => undefined);
}
exports.deactivate = deactivate;
//# sourceMappingURL=client.js.map