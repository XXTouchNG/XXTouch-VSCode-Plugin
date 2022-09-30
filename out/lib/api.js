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
exports.API = void 0;
const axios_1 = require("axios");
const fs = require("fs");
const path = require("path");
const vscode = require("vscode");
class API {
    constructor(ip) {
        this.axios = axios_1.default.create({
            baseURL: `http://${ip}:46952/api`,
            timeout: 30 * 1000,
            maxContentLength: Infinity,
            maxBodyLength: Infinity,
        });
        this.xxtouch = axios_1.default.create({
            baseURL: `http://${ip}:46952`,
            timeout: 30 * 1000,
            maxContentLength: Infinity,
            maxBodyLength: Infinity,
        });
    }
    error(res) {
        if (res instanceof Error) {
            vscode.window.showErrorMessage(`错误: ${res.toString()}`);
        }
        else {
            vscode.window.showErrorMessage(`错误: ${res.status} ${res.statusText}`);
        }
    }
    stopScript() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield this.axios.post(`script/stop`);
                if (res.status !== 204) {
                    this.error(res);
                    return false;
                }
                return true;
            }
            catch (e) {
                this.error(e);
                return false;
            }
        });
    }
    runLocalScript(file) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const name = path.basename(file);
                let res = yield this.axios.put(encodeURI(`script/${name}`), fs.readFileSync(file));
                if (res.status !== 204) {
                    this.error(res);
                    return false;
                }
                res = yield this.axios.post(encodeURI(`script/${name}/run`));
                if (res.status !== 204) {
                    this.error(res);
                    return false;
                }
                return true;
            }
            catch (e) {
                this.error(e);
                return false;
            }
        });
    }
    runRemoteScript(remote) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield this.axios.post(encodeURI(`script/${remote}/run`));
                if (res.status !== 204) {
                    this.error(res);
                    return false;
                }
                return true;
            }
            catch (e) {
                this.error(e);
                return false;
            }
        });
    }
    debugLocalScript(file) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const name = path.basename(file);
                let res = yield this.axios.put(encodeURI(`script/${name}`), fs.readFileSync(file));
                if (res.status !== 204) {
                    this.error(res);
                    return false;
                }
                res = yield this.axios.post(encodeURI(`script/${name}/debug`));
                if (res.status !== 204) {
                    this.error(res);
                    return false;
                }
                return true;
            }
            catch (e) {
                this.error(e);
                return false;
            }
        });
    }
    debugRemoteScript(remote) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield this.axios.post(encodeURI(`script/${remote}/debug`));
                if (res.status !== 204) {
                    this.error(res);
                    return false;
                }
                return true;
            }
            catch (e) {
                this.error(e);
                return false;
            }
        });
    }
    appState() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield this.axios.get('app/state');
                if (res.status !== 200) {
                    this.error(res);
                    return null;
                }
                return res.data;
            }
            catch (e) {
                this.error(e);
                return null;
            }
        });
    }
    getSystemLog() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield this.axios.get('system/log?last=30');
                if (res.status === 200 || res.status === 204 || res.status === 206) {
                    return res.data;
                }
                return '';
            }
            catch (e) {
                return '';
            }
        });
    }
    getScreenSnapshot(scale = 100) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield this.axios.get(`screen/snapshot?format=png&scale=${scale}`, {
                    responseType: 'arraybuffer',
                });
                if (res.status !== 200) {
                    this.error(res);
                    return null;
                }
                return Buffer.from(res.data, res.data.byteLength);
            }
            catch (e) {
                this.error(e);
                return null;
            }
        });
    }
    readDir(root) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield this.axios.get(encodeURI(`file?path=${root}`));
                if (res.status !== 200) {
                    this.error(res);
                    return [];
                }
                return res.data || [];
            }
            catch (e) {
                this.error(e);
                return [];
            }
        });
    }
    getFile(path) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield this.axios.get(encodeURI(`file?path=${path}`), {
                    responseType: 'arraybuffer',
                });
                if (res.status !== 200) {
                    this.error(res);
                    return null;
                }
                return Buffer.from(res.data);
            }
            catch (e) {
                this.error(e);
                return null;
            }
        });
    }
    deleteFile(path) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield this.axios.delete(encodeURI(`file?path=${path}`));
                if (res.status !== 204) {
                    this.error(res);
                    return false;
                }
                return true;
            }
            catch (e) {
                this.error(e);
                return false;
            }
        });
    }
    putFile(remote, local) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield this.axios.put(encodeURI(`file?path=${remote}/${path.basename(local)}`), fs.readFileSync(local));
                if (res.status !== 204) {
                    this.error(res);
                    return false;
                }
                return true;
            }
            catch (e) {
                this.error(e);
                return false;
            }
        });
    }
    commandSpawn(cmd) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield this.xxtouch.post(`command_spawn`, cmd);
                if (res.status !== 200) {
                    this.error(res);
                    return false;
                }
                return true;
            }
            catch (e) {
                this.error(e);
                return false;
            }
        });
    }
    extractFile(remote, local, cwd) {
        return this.commandSpawn(`tar -xf ${remote}/${path.basename(local)} -C ${cwd}`)
    }
}
exports.API = API;
//# sourceMappingURL=api.js.map