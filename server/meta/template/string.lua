---@meta

---#DES 'string'
---@class string*
string = {}

---#DES 'string.byte'
---@param s  string
---@param i? integer
---@param j? integer
---@return integer
---@return ...
function string.byte(s, i, j) end

---#DES 'string.char'
---@param byte integer
---@vararg integer
---@return string
---@return ...
function string.char(byte, ...) end

---#DES 'string.dump'
---@param f      function
---@param strip? boolean
---@return string
function string.dump(f, strip) end

---#DES 'string.find'
---@param s       string
---@param pattern string
---@param init?   integer
---@param plain?  boolean
---@return integer start
---@return integer end
---@return ... captured
function string.find(s, pattern, init, plain) end

---#DES 'string.format'
---@param s string
---@vararg string
---@return string
function string.format(s, ...) end

---#DES 'string.gmatch'
---#if VERSION <= 5.3 then
---@param s       string
---@param pattern string
---@return fun():string, ...
function string.gmatch(s, pattern) end
---#else
---@param s       string
---@param pattern string
---@param init?   integer
---@return fun():string, ...
function string.gmatch(s, pattern, init) end
---#end

---#DES 'string.gsub'
---@param s       string
---@param pattern string
---@param repl    string|table|function
---@param n       integer
---@return string
---@return integer count
function string.gsub(s, pattern, repl, n) end

---#DES 'string.len'
---@param s string
---@return integer
function string.len(s) end

---#DES 'string.lower'
---@param s string
---@return string
function string.lower(s) end

---#DES 'string.match'
---@param s       string
---@param pattern string
---@param init?   integer
---@return string captured
function string.match(s, pattern, init) end

---@version >5.3
---#DES 'string.pack'
---@param fmt string
---@param v1  string
---@param v2? string
---@vararg string
---@return string binary
function string.pack(fmt, v1, v2, ...) end

---@version >5.3
---#DES 'string.packsize'
---@param fmt string
---@return integer
function string.packsize(fmt) end

---#if VERSION <= 5.1 then
---#DES 'string.rep<5.1'
---@param s    string
---@param n    integer
---@return string
function string.rep(s, n) end
---#else
---#DES 'string.rep>5.2'
---@param s    string
---@param n    integer
---@param sep? string
---@return string
function string.rep(s, n, sep) end
---#end

---#DES 'string.reverse'
---@param s string
---@return string
function string.reverse(s) end

---#DES 'string.sub'
---@param s  string
---@param i  integer
---@param j? integer
---@return string
function string.sub(s, i, j) end

---@version >5.3
---#DES 'string.unpack'
---@param fmt  string
---@param s    string
---@param pos? integer
---@return ...
---@return integer offset
function string.unpack(fmt, s, pos) end

---#DES 'string.upper'
---@param s string
---@return string
function string.upper(s) end

---#DES 'string.to_hex'
---@param s string
---@return string
function string.to_hex(s) end

---#DES 'string.from_hex'
---@param s string
---@return string
function string.from_hex(s) end

---#DES 'string.from_gbk'
---@param s string
---@return string
function string.from_gbk(s) end

---#DES 'string.md5'
---@param s string
---@return string
function string.md5(s) end

---#DES 'string.sha1'
---@param s string
---@return string
function string.sha1(s) end

---#DES 'string.base64_encode'
---@param s string
---@return string
function string.base64_encode(s) end

---#DES 'string.base64_decode'
---@param s string
---@return string
function string.base64_decode(s) end

---#DES 'string.aes128_encrypt'
---@param s string
---@param key string
---@return string
function string.aes128_encrypt(s, key) end

---#DES 'string.aes128_decrypt'
---@param s string
---@param key string
---@return string
function string.aes128_decrypt(s, key) end

---#DES 'string.split'
---@param s string
---@param sep string
---@return table
function string.split(s, sep) end

---#DES 'string.ltrim'
---@param s string
---@return string
function string.ltrim(s) end

---#DES 'string.rtrim'
---@param s string
---@return string
function string.rtrim(s) end

---#DES 'string.trim'
---@param s string
---@return string
function string.trim(s) end

---#DES 'string.atrim'
---@param s string
---@return string
function string.atrim(s) end

---#DES 'string.strip_utf8_bom'
---@param s string
---@return string
function string.strip_utf8_bom(s) end

---#DES 'string.random'
---@param pool string
---@param length integer
---@return string
function string.random(pool, length) end

---#DES 'string.compare_version'
---@param v1 string
---@param v2 string
---@return integer
function string.compare_version(v1, v2) end

return string
