--------------------------------------------------------------------------------
-- 触摸模块
--------------------------------------------------------------------------------

---@class touch*
touch = {}

--- 手指按下
---@param finger number 手指ID
---@param x      number 坐标x
---@param y      number 坐标y
function touch.down(finger, x, y)
end

--- 手指移动
---@param finger number 手指ID
---@param x      number 坐标x
---@param y      number 坐标y
function touch.move(finger, x, y)
end

--- 手指抬起
---@param finger number 手指ID
function touch.up(finger)
end

--- 点击
---@param x       number 坐标x
---@param y       number 坐标y
---@param ms?     number 延时
---@param finger? number 手指ID
function touch.tap(x, y, ms, finger)
end

--- 随机点击
---@param x       number 坐标x
---@param y       number 坐标y
---@param r?      number 随机范围
---@param ms?     number 延时
---@param finger? number 手指ID
function touch.tapRandom(x, y, r, ms, finger)
end

--- 生成滑动对象
---@param finger? number 手指ID
---@return Slide* 滑动对象
function touch.slide(finger)
end

---@class Slide*
Slide = {}

--- 设置滑动步进
---@param step number 步进
---@return Slide* 滑动对象
function Slide:step(step)
end

--- 设置滑动延迟
---@param delay number 延迟
---@return Slide* 滑动对象
function Slide:delay(delay)
end

--- 按下
---@param x number 坐标x
---@param y number 坐标y
---@return Slide* 滑动对象
function Slide:on(x, y)
end

--- 滑动至指定坐标
---@param x number 坐标x
---@param y number 坐标y
---@return Slide* 滑动对象
function Slide:move(x, y)
end

--- 抬起
---@return Slide* 滑动对象
function Slide:up()
end

--------------------------------------------------------------------------------
-- 按键模块
--------------------------------------------------------------------------------

---@class key*
key = {}

--- 按键按下
---@param code string 按键名
function key.down(code)
end

--- 按键抬起
---@param code string 按键名
function key.up(code)
end

--------------------------------------------------------------------------------
-- 屏幕模块
--------------------------------------------------------------------------------

---@class screen*
screen = {}

--- 屏幕分辨率
---@return number 宽
---@return number 高
function screen.resolution()
end

--- 屏幕取色
---@param x number 坐标x
---@param y number 坐标y
---@return number 颜色
function screen.getColor(x, y)
end

--- 屏幕取色RGB
---@param x number 坐标x
---@param y number 坐标y
---@return number R
---@return number G
---@return number B
function screen.getColorRGB(x, y)
end

--- 屏幕找色
---@param colors table   颜色数组
---@param fuzzy? number  精度
---@param ltx?   number  左上角坐标x
---@param lty?   number  左上角坐标y
---@param rbx?   number  右下角坐标x
---@param rby?   number  右下角坐标y
---@param all?   boolean 是否返回所有符合条件的坐标
---@return number|table 坐标x或坐标数组(all为true时)
---@return number       坐标y
function screen.findColor(colors, fuzzy, ltx, lty, rbx, rby, all)
end

--- 屏幕找图
---@param path   string 图像路径
---@param fuzzy? number 精度
---@param ltx?   number 左上角坐标x
---@param lty?   number 左上角坐标y
---@param rbx?   number 右下角坐标x
---@param rby?   number 右下角坐标y
---@param trans? number 透明色
---@return number 坐标x
---@return number 坐标y
function screen.findImage(path, fuzzy, ltx, lty, rbx, rby, trans)
end

--- 屏幕截图
---@param path   string 图像路径
---@param ltx?   number 左上角坐标x
---@param lty?   number 左上角坐标y
---@param rbx?   number 右下角坐标x
---@param rby?   number 右下角坐标y
---@param scale? number 缩放比例
function screen.snapshot(path, ltx, lty, rbx, rby, scale)
end

--- 屏幕颜色位数
---@return number 颜色位数
function screen.colorBits()
end

--- 屏幕缓存
---@param on      boolean      是否保持
---@param colors? number|table 二值化颜色数组
---@param fuzzy?  number       二值化精度
function screen.keep(on, colors, fuzzy)
end

---屏幕旋转
---@param deg number 旋转角度
function screen.rotate(deg)
end

--------------------------------------------------------------------------------
-- 图像模块
--------------------------------------------------------------------------------

---@class image*
image = {}

--- 图像分辨率
---@param path string 图像路径
---@return number 宽
---@return number 高
function image.resolution(path)
end

--- 图像取色
---@param path string 图像路径
---@param x    number 坐标x
---@param y    number 坐标y
---@return number 颜色
function image.getColor(path, x, y)
end

--- 图像取色RGB
---@param path string 图像路径
---@param x    number 坐标x
---@param y    number 坐标y
---@return number R
---@return number G
---@return number B
function image.getColorRGB(path, x, y)
end

--- 图像找色
---@param path   string  图像路径
---@param colors table   颜色数组
---@param fuzzy? number  精度
---@param ltx?   number  左上角坐标x
---@param lty?   number  左上角坐标y
---@param rbx?   number  右下角坐标x
---@param rby?   number  右下角坐标y
---@param all?   boolean 是否返回所有符合条件的坐标
---@return number|table 坐标x或坐标数组(all为true时)
---@return number       坐标y
function image.findColor(path, colors, fuzzy, ltx, lty, rbx, rby, all)
end

--- 图像找图
---@param path   string 图像路径
---@param find   string 子图像路径
---@param fuzzy? number 精度
---@param ltx?   number 左上角坐标x
---@param lty?   number 左上角坐标y
---@param rbx?   number 右下角坐标x
---@param rby?   number 右下角坐标y
---@param trans? number 透明色
---@return number 坐标x
---@return number 坐标y
function image.findImage(path, find, fuzzy, ltx, lty, rbx, rby, trans)
end

--- 图像缓存
---@param on boolean 是否保持
function image.keep(on)
end

--- 图像旋转
---@param path   string 图像路径
---@param deg number 旋转角度
function image.rotate(path, deg)
end

--- 图像颜色过滤
---@param path    string       图像路径
---@param colors  number|table 颜色数组
---@param fuzzy?  number 精度
function image.filter(path, colors, fuzzy)
end

--- 图像二值化
---@param path      string 图像路径
---@param threshold number 阈值
function image.binarization(path, threshold)
end

--- 图像缩放
---@param path   string 图像路径
---@param width  number 宽
---@param height number 高
function image.resize(path, width, height)
end

---@class qr*
image.qr = {}

--- 二维码编码
---@param path string 图像路径
---@param text string 文字
---@param size number 尺寸
function image.qr.encode(path, text, size)
end

--- 二维码解码
---@param path string 图像路径
---@return string 文字
function image.qr.decode(path)
end

--------------------------------------------------------------------------------
-- 识别模块
--------------------------------------------------------------------------------

---@class ocr*
ocr = {}

---@class tess*
ocr.tess = {}

--- 本地图像识别
---@param tess       string tessdata路径
---@param lang?      string 语言
---@param ltx?       number 左上角坐标x
---@param lty?       number 左上角坐标y
---@param rbx?       number 右下角坐标x
---@param rby?       number 右下角坐标y
---@param whitelist? string 白名单
---@return string 文字
---@return table  坐标数组
function ocr.tess.ocr(tess, lang, ltx, lty, rbx, rby, whitelist)
end

--- 本地图像识别扩展
---@param tess      string tessdata路径
---@param lang      string 语言
---@param whitelist string 白名单
---@param vararg    string 图像路径
---@return string 文字
---@return table  坐标数组
function ocr.tess.ocrEx(tess, lang, whitelist, ...)
end

---@class cloud*
ocr.cloud = {}

--- 远程图像识别初始化
---@param platform number 打码平台编号
function ocr.cloud.init(platform)
end

--- 远程图像识别
---@param sign    string 密码串
---@param type    string 题目类型
---@param ltx     number 左上角坐标x
---@param lty     number 左上角坐标y
---@param rbx     number 右下角坐标x
---@param rby     number 右下角坐标y
---@param timeout number 超时
---@return string 文字
function ocr.cloud.ocr(sign, type, ltx, lty, rbx, rby, timeout)
end

--- 远程图像识别扩展
---@param sign    string 密码串
---@param type    string 题目类型
---@param timeout number 超时
---@param vararg  string 图像路径
---@return string 文字
function ocr.cloud.ocrEx(sign, type, timeout, ...)
end

---@class font*
ocr.font = {}

--- 字库初始化
---@param lib table 字库
function ocr.font.init(lib)
end

--- 字库找字
---@param text   string 字
---@param ltx?   number 左上角坐标x
---@param lty?   number 左上角坐标y
---@param rbx?   number 右下角坐标x
---@param rby?   number 右下角坐标y
---@param fuzzy? number 精度
---@param all?   boolean 是否返回所有符合条件的坐标
---@return number|table 坐标x或坐标数组(all为true时)
---@return number       坐标y
function ocr.font.find(text, ltx, lty, rbx, rby, fuzzy, all)
end

--- 字库识字
---@param ltx?   number 左上角坐标x
---@param lty?   number 左上角坐标y
---@param rbx?   number 右下角坐标x
---@param rby?   number 右下角坐标y
---@param fuzzy? number 精度
---@return string 文字
---@return table  坐标数组
function ocr.font.ocr(ltx, lty, rbx, rby, fuzzy)
end

--------------------------------------------------------------------------------
-- 应用模块
--------------------------------------------------------------------------------

---@class app*
app = {}

--- 前台包名
---@return string 包名
function app.frontBid()
end

--- 应用启动
---@param app string 包名
function app.run(app)
end

--- 应用关闭
---@param app string 包名
function app.kill(app)
end

--- 应用是否运行
---@param app string 包名
---@return boolean 是否运行
function app.running(app)
end

--- 应用包目录
---@param app string 包名
---@return string 包目录路径
function app.bundlePath(app)
end

--- 应用数据目录
---@param app string 包名
---@return string 数据目录路径
function app.dataPath(app)
end

--- 应用安装
---@param path string 安装包路径
function app.install(path)
end

--- 应用卸载
---@param app string 包名
function app.uninstall(app)
end

--------------------------------------------------------------------------------
-- 系统模块
--------------------------------------------------------------------------------

---@class sys*
sys = {}

--- 弹出UI
---@param html string html文件路径
---@param ltx? number 左上角坐标x
---@param lty? number 左上角坐标y
---@param rbx? number 右下角坐标x
---@param rby? number 右下角坐标y
---@return string 交互数据
function sys.ui.show(html, ltx, lty, rbx, rby)
end

--- 对话框提示
---@param any any    值
---@param ms? number 显示时间
function sys.dialog(any, ms)
end

--- 吐司提示
---@param any any    值
---@param ms? number 显示时间
function sys.toast(any, ms)
end

--- 震动提示
---@param ms number 震动时间
function sys.vibrate(ms)
end

--- 声音提示
---@param path string 音频路径
function sys.voice(path)
end

--- 日志
---@param any any 值
function sys.log(any)
end

--- 文字输入
---@param text string 文字
function sys.input(text)
end

--- 打开页面
---@param url string 地址
function sys.openUrl(url)
end

--- 设备号
---@return string 设备号
function sys.deviceID()
end

--- 注销
function sys.respring()
end

--- 运行系统命令
---@param cmd string 命令
---@return string 运行结果
function sys.exec(cmd)
end

--- 延时
---@param ms number 时间
function sys.sleep(ms)
end

---@class clip*
sys.clip = {}

--- 文字复制
---@param text string 文字
function sys.clip.copy(text)
end

--- 剪贴板文字
---@return string 文字
function sys.clip.text()
end

---@class album*
sys.album = {}

--- 保存图片至相册
---@param path string 路径
function sys.album.addImage(path)
end

--- 保存视频至相册
---@param path string 路径
function sys.album.addVideo(path)
end

---@class contact*
sys.contact = {}

--- 通讯录添加
---@param last  string 姓
---@param first string 名
---@param phone string 电话号码
function sys.contact.add(last, first, phone)
end

--- 通讯录清空
function sys.contact.clear()
end

---@class vpn*
sys.vpn = {}

--- VPN状态
---@return boolean 是否开启
function sys.vpn.status()
end

--- VPN状态设置
---@param on boolean 是否开启
function sys.vpn.setStatus(on)
end

---@class wifi*
sys.wifi = {}

--- WIFI状态
---@return boolean 是否开启
function sys.wifi.status()
end

--- WIFI状态设置
---@param on boolean 是否开启
function sys.wifi.setStatus(on)
end

---@class airplane*
sys.airplane = {}

--- 飞行模式状态
---@return boolean 是否开启
function sys.airplane.status()
end

--- 飞行模式状态设置
---@param on boolean 是否开启
function sys.airplane.setStatus(on)
end

---@class lock*
sys.lock = {}

--- 锁屏状态
---@return boolean 是否锁屏
function sys.lock.status()
end

--- 解锁设备
---@param pass string 密码
function sys.lock.unlock(pass)
end

--- 获取屏幕亮度
---@return number 亮度
function sys.brightness.get()
end

--- 设置屏幕亮度
---@param brightness number 亮度
function sys.brightness.set(brightness)
end

--------------------------------------------------------------------------------
-- 脚本模块
--------------------------------------------------------------------------------

---@class script*
script = {}

--- 触摸精灵版本号
---@return string 版本号
function script.teVersion()
end

--- TEP运行时目录
---@return string 路径
function script.workingDir()
end

--- 脚本停止
function script.stop()
end

--- 脚本重启
function script.restart()
end

--------------------------------------------------------------------------------
-- 网络模块
--------------------------------------------------------------------------------

---@class net*
net = {}

--- 网络时间
---@return number 时间
function net.time()
end

---@class http*
net.http = {}

--- HTTP Get请求
---@param url      string 远程地址
---@param timeout? number 超时
---@return string 数据
---@return number 状态码
function net.http.get(url, timeout)
end

--- HTTP Post请求
---@param url       string       远程地址
---@param header?   table        请求头部
---@param body?     string|table 请求数据
---@param timeout?  number       超时
---@return string 数据
---@return number 状态码
function net.http.post(url, header, body, timeout)
end

---@class ftp*
net.ftp = {}

--- 目录创建
---@param url      string 远程地址
---@param user     string 用户
---@param pass     string 密码
---@param timeout? number 超时
---@return boolean 是否成功
---@return string  错误信息
function net.ftp.newDir(url, user, pass, timeout)
end

--- 文件下载
---@param url      string 远程地址
---@param path     string 本地路径
---@param user     string 用户
---@param pass     string 密码
---@param timeout? number 超时
---@return boolean 是否成功
---@return string  错误信息
function net.ftp.get(url, path, user, pass, timeout)
end

--- 文件上传
---@param url      string 远程地址
---@param path     string 本地路径
---@param user     string 用户
---@param pass     string 密码
---@param timeout? number 超时
---@return boolean 是否成功
---@return string  错误信息
function net.ftp.put(url, path, user, pass, timeout)
end

--- 文件删除
---@param url      string 远程地址
---@param user     string 用户
---@param pass     string 密码
---@param timeout? number 超时
---@return boolean 是否成功
---@return string  错误信息
function net.ftp.remove(url, user, pass, timeout)
end

--- 文件是否存在
---@param url      string 远程地址
---@param user     string 用户
---@param pass     string 密码
---@param timeout? number 超时
---@return boolean 是否存在
---@return string  类型
function net.ftp.exists(url, user, pass, timeout)
end

--- 文件列表
---@param url      string 远程地址
---@param user     string 用户
---@param pass     string 密码
---@param timeout? number 超时
---@return table 文件列表
function net.ftp.list(url, user, pass, timeout)
end

--------------------------------------------------------------------------------
-- 编码模块
--------------------------------------------------------------------------------

---@class codec*
codec = {}

---@class md5*
codec.md5 = {}

--- 字符串MD5计算
---@param s string 字符串
---@return string 摘要
function codec.md5.string(s)
end

--- 文件MD5计算
---@param path string 路径
---@return string 摘要
function codec.md5.file(path)
end

---@class aes*
codec.aes = {}

--- AES加密
---@param s   string 明文
---@param key string 密钥
---@return string 密文
function codec.aes.encrypt(s, key)
end

--- AES解密
---@param s   string 密文
---@param key string 密钥
---@return string 明文
function codec.aes.decrypt(s, key)
end

---@class json*
codec.json = {}

--- JSON编码
---@param t table 表
---@return string 字符串
function codec.json.encode(t)
end

--- JSON解码
---@param s string 字符串
---@return table 表
function codec.json.decode(s)
end

--- JSON校验
---@param any any 值
---@return boolean 是否成功
function codec.json.valid(any)
end

---@class base64*
codec.base64 = {}

--- Base64编码
---@param s string 明文
---@return string 密文
function codec.base64.encode(t)
end

--- Base64解码
---@param s string 密文
---@return string 明文
function codec.base64.decode(s)
end

---@class url*
codec.url = {}

--- URL编码
---@param s string 明文
---@return string 密文
function codec.url.encode(s)
end

--- URL解码
---@param s string 密文
---@return string 明文
function codec.url.decode(s)
end

--------------------------------------------------------------------------------
-- 字符串扩展模块
--------------------------------------------------------------------------------

--- 字符串分割
---@param s      string  字符串
---@param sep?   string  分割符
---@param empty? boolean 是否允许空值
---@return table 字符串数组
function string.split(s, sep, empty)
end

--------------------------------------------------------------------------------
-- 文件模块
--------------------------------------------------------------------------------

---@class file*
file = {}

--- 目录创建
---@param path string 路径
---@return boolean 是否成功
---@return string? 错误信息
function file.newDir(path)
end

--- 文件创建
---@param path string 路径
---@return boolean 是否成功
---@return string? 错误信息
function file.newFile(path)
end

--- 文件读取
---@param path string 路径
---@return string 数据
function file.read(path)
end

--- 文件读取至table
---@param path string 路径
---@return table 数据
function file.readTable(path)
end

--- 文件写入
---@param path  string 路径
---@param data  string 数据
---@param mode? string 写入模式
---@return boolean 是否成功
---@return string? 错误信息
function file.write(path, data, mode)
end

--- 文件写入table
---@param path  string 路径
---@param data  table  数据
---@param mode? string 写入模式
---@return boolean 是否成功
---@return string? 错误信息
function file.writeTable(path, data, mode)
end

--- 文件删除
---@param path  string 路径
---@return boolean 是否成功
---@return string? 错误信息
function file.remove(path)
end

--- 文件复制
---@param from string 源路径
---@param to   string 目标路径
---@return boolean 是否成功
---@return string? 错误信息
function file.copy(from, to)
end

--- 文件移动
---@param from string 源路径
---@param to   string 目标路径
---@return boolean 是否成功
---@return string? 错误信息
function file.move(from, to)
end

--- 文件是否存在
---@param path string 路径
---@return boolean 是否存在
---@return string  类型
function file.exists(path)
end

--- 文件大小
---@param path string 路径
---@return number 大小
function file.size(path)
end

--- 文件列表
---@param path string 路径
---@return table 文件列表
function file.list(path)
end

--- 文件查找
---@param path string 路径
---@return table 文件列表
function file.find(path)
end

---@class plist*
file.plist = {}

--- Plist读取
---@param path string 路径
---@return table 表
function file.plist.read(path)
end

--- Plist写入
---@param t    table  表
---@param path string 路径
function file.plist.write(t, path)
end

--------------------------------------------------------------------------------
-- 任务模块
--------------------------------------------------------------------------------

--- 添加任务
---@param f function 任务函数
---@return thread 任务ID
function task.add(f)
end

--- 执行任务队列
---@param co thread 任务ID
function task.loop(co)
end

--- 切换任务
function task.yield()
end

--- 切换任务并延时
---@param ms number 时间
function task.sleep(ms)
end

--------------------------------------------------------------------------------
-- 控件模块
--------------------------------------------------------------------------------

---@class widget*
widget = {}

--- 控件查找
---@param condition table 条件
---@return Widget* 控件对象
function widget.find(condition)
end

---@class Region*
---@field top     number 上
---@field bottom  number 下
---@field left    number 左
---@field right   number 右
Region = {}

---@class Widget*
---@field id            string  ID
---@field text          string  文本
---@field type          string  类型
---@field desc          string  描述
---@field path          string  路径
---@field packageName   string  包名
---@field regex         boolean 匹配字符串类型时是否使用正则表达式
---@field children      number  子控件数量
---@field zIndex        number  层级
---@field region        Region* 位置
---@field clickable     boolean 是否可按下
---@field longClickable boolean 是否可长按
---@field editable      boolean 是否可编辑
---@field checkable     boolean 是否可选中
---@field scrollable    boolean 是否可滚动
---@field focusable     boolean 是否可聚焦
---@field visible       boolean 是否可见
---@field checked       boolean 是否已选中
---@field enabled       boolean 是否已启用
---@field focused       boolean 是否已聚焦
---@field selected      boolean 是否已选择
Widget = {}

--- 更新信息
---@return Widget* 控件对象
function Widget:update()
end

--- 按下
---@return Widget* 控件对象
function Widget:click()
end

--- 长按
---@return Widget* 控件对象
function Widget:longClick()
end

--- 输入文字
---@param text string 文字
---@return Widget* 控件对象
function Widget:input(text)
end

--- 向前滚动
---@return Widget* 控件对象
function Widget:forward()
end

--- 向后滚动
---@return Widget* 控件对象
function Widget:backward()
end
