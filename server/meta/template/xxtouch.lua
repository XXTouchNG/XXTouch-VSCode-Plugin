--------------------------------------------------------------------------------
-- 开发辅助函数
--------------------------------------------------------------------------------

--- 网络日志
function nLog(...)
end


--------------------------------------------------------------------------------
-- 屏幕模块
--------------------------------------------------------------------------------

---@class screen*
screen = {}

--- 初始化旋转坐标系
---@param orientation integer 坐标系，0 表示竖屏 home 在下；1 表示横屏 home 在右；2 表示横屏 home 在左；3 表示竖屏 home 在上
---@return integer previousOrientation 原坐标系，返回这个函数调用之前使用的坐标系
function screen.init(orientation)
end

--- 初始化旋转坐标系（Home 在下）
---@return integer previousOrientation 原坐标系，返回这个函数调用之前使用的坐标系
function screen.init_home_on_bottom()
end

--- 初始化旋转坐标系（Home 在右）
---@return integer previousOrientation 原坐标系，返回这个函数调用之前使用的坐标系
function screen.init_home_on_right()
end

--- 初始化旋转坐标系（Home 在左）
---@return integer previousOrientation 原坐标系，返回这个函数调用之前使用的坐标系
function screen.init_home_on_left()
end

--- 初始化旋转坐标系（Home 在上）
---@return integer previousOrientation 原坐标系，返回这个函数调用之前使用的坐标系
function screen.init_home_on_top()
end

--- 坐标旋转转换
---@param x integer 横坐标
---@param y integer 纵坐标
---@param direction integer 旋转方向，0 表示不旋转；1 表示往左 90 度旋转；2 表示往右 90 度旋转；3 表示 180 度旋转
---@return integer x 旋转后的横坐标
---@return integer y 旋转后的纵坐标
function screen.rotate_xy(x, y, direction)
end

--- 获取屏幕尺寸
---@return integer width 屏幕宽度
---@return integer height 屏幕高度
function screen.size()
end

--- 保持屏幕
function screen.keep()
end

--- 取消保持屏幕
function screen.unkeep()
end

--- 获取屏幕上某点颜色
---@param x integer 横坐标
---@param y integer 纵坐标
---@return integer color 颜色值，十六进制，如 0xffffff 表示白色
function screen.get_color(x, y)
end

--- 获取屏幕上某点颜色 RGB
---@param x integer 横坐标
---@param y integer 纵坐标
---@return integer r 红色值，0-255
---@return integer g 绿色值，0-255
---@return integer b 蓝色值，0-255
function screen.get_color_rgb(x, y)
end

--- 屏幕多点颜色匹配
---@param colors table 颜色匹配表，详见文档
---@param similarity? integer 颜色相似度，0-100，默认为 100
---@return boolean 是否完全匹配
function screen.is_colors(colors, similarity)
end

--- 多点相似度模式找色
---@param colors table 颜色匹配表，详见文档
---@param similarity? integer 颜色相似度，-100-100，默认为 100，负相似度意味着匹配小于该绝对值的相似度
---@param left? integer 横坐标左边界
---@param top? integer 纵坐标上边界
---@param right? integer 横坐标右边界
---@param bottom? integer 纵坐标下边界
---@return integer x 横坐标，失败返回 -1
---@return integer y 纵坐标，失败返回 -1
function screen.find_color(colors, similarity, left, top, right, bottom)
end

--- 多点色偏模式找色
---@param colors table 颜色匹配表，详见文档
---@param left? integer 横坐标左边界
---@param top? integer 纵坐标上边界
---@param right? integer 横坐标右边界
---@param bottom? integer 纵坐标下边界
---@return integer x 横坐标，失败返回 -1
---@return integer y 纵坐标，失败返回 -1
function screen.find_color(colors, left, top, right, bottom)
end

--- 获取屏幕图像
---@param left? integer 横坐标左边界
---@param top? integer 纵坐标上边界
---@param right? integer 横坐标右边界
---@param bottom? integer 纵坐标下边界
---@return Image* 图像对象
function screen.image(left, top, right, bottom)
end

--- 屏幕区域光学字符识别
---@param options? table 识别选项
-- ```lua
-- screen.ocr_text {
--     left = 0,
--     top = 0,
--     right = 300,
--     bottom = 300,
--     level = 'ACCURATE',  -- ACCURATE 精确 FAST 快速
--     languages = { 'en-US', 'zh-Hans' },  -- 支持的语言代码
--     words = { 'Chrome', 'Firefox', 'Edge', 'Opera' },  -- 备选词汇表
--     confidence = 0.8,  -- 最小可信度，低于此数值的结果将被丢弃
--     timeout = 3000,  -- 超时时间，单位毫秒
-- }
-- ```
---@return table 识别结果字符串列表
---@return table 识别结果详情，包括识别到的区域坐标
function screen.ocr_text(options)
end

--- 屏幕区域光学字符识别
---@param left? integer 横坐标左边界
---@param top? integer 纵坐标上边界
---@param right? integer 横坐标右边界
---@param bottom? integer 纵坐标下边界
---@param level? integer 识别类型，0 表示精确；1 表示快速，默认为 0
---@return table 识别结果字符串列表
---@return table 识别结果详情，包括识别到的区域坐标
function screen.ocr_text(left, top, right, bottom, level)
end

--- 屏幕全屏光学字符搜索（不区分大小写）
---@param text string 字符串
---@param level? integer 识别类型，0 表示精确；1 表示快速，默认为 0
---@return x integer 横坐标，失败返回 -1
---@return y integer 纵坐标，失败返回 -1
function screen.ocr_search(text, level)
end

--- 屏幕全屏光学字符匹配
---@param pattern string 匹配样式
---@param level? integer 识别类型，0 表示精确；1 表示快速，默认为 0
---@return x integer 横坐标，失败返回 -1
---@return y integer 纵坐标，失败返回 -1
function screen.ocr_match(pattern, level)
end

--- 在屏幕上寻找条形码或二维码
---@param left? integer 横坐标左边界
---@param top? integer 纵坐标上边界
---@param right? integer 横坐标右边界
---@param bottom? integer 纵坐标下边界
---@return table 条码内容列表
---@return table 条码位置详情
function screen.detect_barcodes(left, top, right, bottom)
end

--- 屏幕找图
---@param image Image* 图像对象
---@param similarity? integer 图像相似度，0-100，默认为 95
---@param left? integer 横坐标左边界
---@param top? integer 纵坐标上边界
---@param right? integer 横坐标右边界
---@param bottom? integer 纵坐标下边界
---@return integer x 横坐标，失败返回 -1
---@return integer y 纵坐标，失败返回 -1
function screen.find_image(image, similarity, left, top, right, bottom)
end


--------------------------------------------------------------------------------
-- 触摸模块
--------------------------------------------------------------------------------

---@class touch*
touch = {}

--- 模拟手指轻触一次屏幕
---@param x integer 横坐标
---@param y integer 纵坐标
---@param delayBetweenDownAndUp integer 按下和抬起之间的延迟，单位毫秒，默认为 30
---@param delayAfterUp integer 抬起之后的延迟，单位毫秒，默认为 0
function touch.tap(x, y, delayBetweenDownAndUp, delayAfterUp)
end

--- 模拟手指接触屏幕
---@param x integer 横坐标
---@param y integer 纵坐标
---@param extraFlags? integer 全屏手势标志，默认为 0
---@return finger* 手指对象
function touch.on(x, y, extraFlags)
end

--- 模拟手指接触屏幕
---@param fingerID integer 手指ID
---@param x integer 横坐标
---@param y integer 纵坐标
function touch.on(fingerID, x, y)
end

--- 模拟手指在屏幕上移动
---@param fingerID integer 手指ID
---@param x integer 横坐标
---@param y integer 纵坐标
---@param pressure? integer 压力，1-10000，默认为 1000
---@param twist? integer 旋转角，-100-100，默认为 50
function touch.move(fingerID, x, y, pressure, twist)
end

--- 模拟手指离开屏幕
---@param fingerID integer 手指ID
---@param x? integer 横坐标
---@param y? integer 纵坐标
function touch.off(fingerID, x, y)
end

--- 设置触摸圆点显示
---@param should_show boolean 是否显示触摸圆点
function touch.show_pose(should_show)
end

---@class finger*
finger = {}

--- 模拟手指在屏幕上移动
---@param x integer 横坐标
---@param y integer 纵坐标
---@param pressure? integer 压力，1-10000，默认为 1000
---@param twist? integer 旋转角，-100-100，默认为 50
---@return finger* 手指对象
function finger:move(x, y, pressure, twist)
end

--- 模拟手指在屏幕上施加压力
---@param pressure? integer 压力，1-10000，默认为 1000
---@param twist? integer 旋转角，-100-100，默认为 50
---@return finger* 手指对象
function finger:press(pressure, twist)
end

--- 模拟手指离开屏幕
---@param x? integer 横坐标
---@param y? integer 纵坐标
---@return finger* 手指对象
function finger:off(x, y)
end

--- 设置手指对象移动步长
---@param step integer 步长，单位像素，默认为 2
---@return finger* 手指对象
function finger:step_len(step)
end

--- 设置手指对象移动每步延迟
---@param delay integer 延迟，单位毫秒，默认为 0.1
---@return finger* 手指对象
function finger:step_delay(delay)
end

--- 毫秒级延迟
---@param delay integer 延迟，单位毫秒，默认为 0。1
---@return finger* 手指对象
function finger:msleep(delay)
end

--------------------------------------------------------------------------------
-- 按键模块
--------------------------------------------------------------------------------

---@class key*
key = {}

--- 模拟按一下物理按键
---@param key_code string 按键名，详见文档
function key.press(key_code)
end

--- 模拟按下物理按键
---@param key_code string 按键名，详见文档
function key.down(key_code)
end

--- 松开按下的物理按键
---@param key_code string 按键名，详见文档
function key.up(key_code)
end

--- 模拟键入文本
---@param text string 文本，待输入的文字，只能是英文数字和半角字符还有 "\b" "\r" "\t"
---@param delayBetweenCharacters? integer 单个字符间的延迟，单位毫秒，默认为 0
function key.send_text(text, delayBetweenCharacters)
end


--------------------------------------------------------------------------------
-- 重力加速计模块
--------------------------------------------------------------------------------

---@class accelerometer*
accelerometer = {}

--- 模拟摇一摇
function accelerometer.shake()
end

--- 改变当前重力方向为 home 在左
function accelerometer.rotate_home_on_left()
end

--- 改变当前重力方向为 home 在右
function accelerometer.rotate_home_on_right()
end

--- 改变当前重力方向为 home 在上
function accelerometer.rotate_home_on_top()
end

--- 改变当前重力方向为 home 在下
function accelerometer.rotate_home_on_bottom()
end


--------------------------------------------------------------------------------
-- 系统模块
--------------------------------------------------------------------------------

---@class sys*
sys = {}

--- 获取系统当前语言
---@return string 当前语言（BCP 47）
function sys.language()
end

--- 设置系统当前语言
---@param language string 当前语言（BCP 47）
function sys.set_language(language)
end

--- 获取系统当前区域
---@return string 当前区域标识符
function sys.locale()
end

--- 设置系统当前区域
---@param locale string 当前区域标识符
function sys.set_locale(locale)
end

--- 获取系统当前时区
---@return string 当前时区标识符
function sys.timezone()
end

--- 设置系统当前时区
---@param timezone string 当前时区标识符
function sys.set_timezone(timezone)
end

--- 显示提示文字
---@param text string 文字内容
---@param orientation? integer 文字方向，默认为最后一次调用 screen.init 所设的那个方向
function sys.toast(text, orientation)
end

--- 弹出系统提示
---@param content string 文字内容
---@param delayBeforeAutoDismissal? integer 自动消失延迟，单位毫秒，设置为 0 不自动消失，默认为 0
---@param title? string 标题，默认为 "脚本提示"
---@param button1? string 第一个按钮文字，默认为 "好"
---@param button2? string 第二个按钮文字，默认不显示这个按钮
---@param button3? string 第三个按钮文字，默认不显示这个按钮
---@return integer 按钮索引，0 表示第一个按钮，1 表示第二个按钮，2 表示第三个按钮，3 表示超时没有按钮被点击
function sys.alert(content, delayBeforeAutoDismissal, title, button1, button2, button3)
end

--- 弹出输入提示
---@param content string 提示内容
---@return string 输入的文字
function sys.input_box(content)
end

--- 弹出输入提示
---@param title string 标题，默认为 "脚本提示"
---@param content string 提示内容
---@param delayBeforeAutoDismissal? integer 自动消失延迟，单位毫秒，设置为 0 不自动消失，默认为 0
---@return string 输入的文字
function sys.input_box(title, content, delayBeforeAutoDismissal)
end

--- 弹出输入提示
---@param title string 标题，默认为 "脚本提示"
---@param content string 提示内容
---@param placeholder1 string 第一个输入框内提示文字
---@param delayBeforeAutoDismissal? integer 自动消失延迟，单位毫秒，设置为 0 不自动消失，默认为 0
---@return string 输入的文字
function sys.input_box(title, content, placeholder1, delayBeforeAutoDismissal)
end

--- 弹出输入提示
---@param title string 标题，默认为 "脚本提示"
---@param content string 提示内容
---@param placeholder1 string 第一个输入框内提示文字
---@param text1 string 第一个输入框默认文字
---@param delayBeforeAutoDismissal? integer 自动消失延迟，单位毫秒，设置为 0 不自动消失，默认为 0
---@return string 输入的文字
function sys.input_box(title, content, placeholder1, text1, delayBeforeAutoDismissal)
end

--- 弹出输入提示
---@param title string 标题，默认为 "脚本提示"
---@param content string 提示内容
---@param placeholder1 string 第一个输入框内提示文字
---@param text1 string 第一个输入框默认文字
---@param button1 string 第一个按钮文字，默认为 "好"
---@param delayBeforeAutoDismissal? integer 自动消失延迟，单位毫秒，设置为 0 不自动消失，默认为 0
---@return string 输入的文字
function sys.input_box(title, content, placeholder1, text1, button1, delayBeforeAutoDismissal)
end

--- 弹出输入提示
---@param title string 标题，默认为 "脚本提示"
---@param content string 提示内容
---@param placeholder1 string 第一个输入框内提示文字
---@param text1 string 第一个输入框默认文字
---@param button1 string 第一个按钮文字，默认为 "好"
---@param button2 string 第二个按钮文字
---@param delayBeforeAutoDismissal? integer 自动消失延迟，单位毫秒，设置为 0 不自动消失，默认为 0
---@return string 输入的文字
function sys.input_box(title, content, placeholder1, text1, button1, button2, delayBeforeAutoDismissal)
end

--- 弹出输入提示
---@param title string 标题，默认为 "脚本提示"
---@param content string 提示内容
---@param placeholder1 string 第一个输入框内提示文字
---@param text1 string 第一个输入框默认文字
---@param button1 string 第一个按钮文字，默认为 "好"
---@param button2 string 第二个按钮文字
---@param button3 string 第三个按钮文字
---@param delayBeforeAutoDismissal? integer 自动消失延迟，单位毫秒，设置为 0 不自动消失，默认为 0
---@return string 输入的文字
---@return integer 按钮索引，0 表示第一个按钮，1 表示第二个按钮，2 表示第三个按钮
function sys.input_box(title, content, placeholder1, text1, button1, button2, button3, delayBeforeAutoDismissal)
end

--- 弹出输入提示
---@param title string 标题，默认为 "脚本提示"
---@param content string 提示内容
---@param placeholderGroup table 输入框提示文字组，格式为 { "第一个输入框内提示文字", "第二个输入框内提示文字" }
---@param textGroup? table 输入框默认文字组，格式为 { "第一个输入框默认文字", "第二个输入框默认文字" }
---@param button1? string 第一个按钮文字，默认为 "好"
---@param button2? string 第二个按钮文字
---@param button3? string 第三个按钮文字
---@param delayBeforeAutoDismissal? integer 自动消失延迟，单位毫秒，设置为 0 不自动消失，默认为 0
---@return string 第一个输入框输入的文字
---@return string 第二个输入框输入的文字
---@return integer 按钮索引，0 表示第一个按钮，1 表示第二个按钮，2 表示第三个按钮
function sys.input_box(title, content, placeholderGroup, textGroup, button1, button2, button3, delayBeforeAutoDismissal)
end

--- 输入文字
---@param text string 输入的文字，不支持 "\b" (退格键)
---@param pressEnter? boolean 是否按下回车键，默认为 false
function sys.input_text(text, pressEnter)
end

--- 毫秒级延迟
---@param delay integer 延迟时间，单位毫秒
function sys.msleep(delay)
end

--- 秒级延迟
---@param delay integer 延迟时间，单位秒
function sys.sleep(delay)
end

--- 获取当前毫秒级时间戳
---@return integer 毫秒级时间戳
function sys.mtime()
end

--- 获取网络时间戳
---@return integer 秒级网络时间戳
function sys.net_time()
end

--- 产生一个真随机数
---@return integer 真随机数，范围 0~4294967295
function sys.rnd()
end

--- 获取设备当前可用内存
---@return number 可用内存，单位兆字节
function sys.available_memory()
end

--- 获取设备当前总内存
---@return number 总内存，单位兆字节
function sys.total_memory()
end

--- 获取当前 XXTouch Lua 进程的内存占用
---@return number 内存占用，单位兆字节
function sys.xtmemory()
end

--- 获取当前挂载的文件系统列表
---@return table 文件系统列表
function sys.disks()
end

--- 获取设备当前磁盘剩余空间
---@param mountPoint? string 文件系统挂载点
---@return number 磁盘剩余空间，单位兆字节
function sys.free_disk_space(mountPoint)
end

--- 获取设备当前磁盘总空间
---@param mountPoint? string 文件系统挂载点
---@return number 磁盘总空间，单位兆字节
function sys.total_disk_space(mountPoint)
end

--- 输出标准系统日志
function sys.log(...)
end

--- 问系统一个问题
---@param question string 问题内容
---@return string 系统回答
function sys.mgcopyanswer(question)
end

--- 获取系统版本
---@return string 系统版本
function sys.version()
end

--- 获取 XXTouch 版本
---@return string XXTouch 版本
function sys.xtversion()
end

--- 设置日志条颜色
--- 主屏幕最前方日志条的背景颜色，默认为黑色，脚本运行结束后会还原到初始的颜色。
--- @param color string 颜色的十六进制 RGBA 值，如 "#FF0000" 或者 "#FF000099"
function sys.set_tooltip_color(color)
end


--------------------------------------------------------------------------------
-- 剪贴板模块
--------------------------------------------------------------------------------

---@class pasteboard*
pasteboard = {}

--- 写内容进剪贴板
---@param content string 需要写入到剪贴板的内容
---@param uti? string 内容类型，默认为 "public.utf8-plain-text"
function pasteboard.write(content, uti)
end

--- 获取剪贴板中的数据
---@param uti? string 内容类型，默认为 "public.utf8-plain-text"
---@return string 剪贴板中的数据
function pasteboard.read(uti)
end


--------------------------------------------------------------------------------
-- 应用程序模块
--------------------------------------------------------------------------------

---@class app*
app = {}

--- 获取 App 的应用程序包路径
---@param appId string App 的应用程序标识符
---@return string 应用程序包路径，如果应用不存在，返回 nil
function app.bundle_path(appId)
end

--- 获取 App 的应用程序版本
---@param appId string App 的应用程序标识符
---@return string 应用程序版本，如果应用不存在，返回 nil
function app.bundle_version(appId)
end

--- 获取 App 的应用存档路径
---@param appId string App 的应用程序标识符
---@return string 应用存档路径，如果应用不存在，返回 nil
function app.data_path(appId)
end

--- 获取 App 的应用分组信息
---@param appId string App 的应用程序标识符
---@return table 应用分组信息，如果没有分组信息，返回 nil
function app.group_info(appId)
end

--- 弹出一个应用通知
---@param appId string App 的应用程序标识符
---@param title string 应用通知的标题
---@param message string 应用通知的内容
function app.pop_banner(appId, title, message)
end

--- 运行应用程序
---@param appId string App 的应用程序标识符
---@return integer 应用程序运行状态，0 表示成功，其他值表示失败
function app.run(appId)
end

--- 关闭应用程序
---@param appId string App 的应用程序标识符
function app.close(appId)
end

--- 关闭应用程序
---@param processId integer App 的进程标识符
function app.close(processId)
end

--- 模拟使用上划退出应用程序
---@param appId string App 的应用程序标识符，传入 "*" 表示关闭所有应用程序
function app.quit(appId)
end

--- 检测应用是否正在运行
---@param appId string App 的应用程序标识符
---@return boolean 应用是否正在运行
function app.is_running(appId)
end

--- 输入文字
---@param text string 需要输入的文字，支持 "\b"（退格键）
function app.input_text(text)
end

--- 通过应用程序标识符获取应用的本地化名字
---@param appId string App 的应用程序标识符
---@return string 应用的本地化名字，如果应用不存在，返回 nil
function app.localized_name(appId)
end

--- 通过应用程序标识符获取应用的图标数据
---@param appId string App 的应用程序标识符
---@return string 应用的 png 图标数据，如果应用不存在，返回 nil
function app.png_data_for_bid(appId)
end

--- 通过应用程序标识符获取进程标志符
---@param appId string App 的应用程序标识符
---@return integer 应用程序进程标志符，如果应用未运行，返回 0
function app.pid_for_bid(appId)
end

--- 获取应用程序当前内存消耗
---@param appId string App 的应用程序标识符
---@return number 应用程序当前内存消耗，单位为兆字节，如果应用未运行，返回 nil
function app.used_memory(appId)
end

--- 获取前台应用的应用程序标识符
---@return string 前台应用的应用程序标识符，如果没有前台应用，返回 nil
function app.front_bid()
end

--- 获取前台应用的进程标识符
---@return integer 前台应用的进程标识符，如果没有前台应用，返回 0
function app.front_pid()
end

--- 前台打开一个 URL
---@param url string 需要打开的 URL
function app.open_url(url)
end

--- 获取设备所有应用的应用程序标识符
---@return table 设备所有应用的应用程序标识符
function app.bundles()
end

--- 获取当前设备的进程列表
---@return table 当前设备的进程列表，结构是这样 { {pid = 进程号1, name = 进程名1 }, {pid = 进程号2, name = 进程名2 }, ... }
function app.all_procs()
end

--- 安装 IPA 应用程序包
---@param ipaPath string IPA 应用程序包的路径
---@return boolean 安装结果，true 表示成功，false 表示失败
function app.install(ipaPath)
end

--- 卸载应用程序
---@param appId string App 的应用程序标识符
---@return boolean 卸载结果，true 表示成功，false 表示失败
function app.uninstall(appId)
end


--------------------------------------------------------------------------------
-- 设备模块
--------------------------------------------------------------------------------

---@class device*
device = {}

--- 重置自动锁屏倒计时
function device.reset_idle()
end

--- 锁定屏幕
function device.lock_screen()
end

--- 解锁屏幕
---@param password? string 屏幕锁定的密码
function device.unlock_screen(password)
end

--- 获取屏幕锁定状态
---@return boolean 屏幕锁定状态，true 表示锁定，false 表示未锁定
function device.is_screen_locked()
end

--- 获取前台应用的画面方向
---@return integer 前台应用的画面方向，0 表示 home 在下；1 表示 home 在右；2 表示 home 在左；3 表示 home 在上
function device.front_orien()
end

--- 锁定设备屏幕旋转方向
function device.lock_orien()
end

--- 解锁设备屏幕旋转方向
function device.unlock_orien()
end

--- 获取屏幕旋转锁定状态
---@return boolean 屏幕旋转锁定状态，true 表示锁定，false 表示未锁定
function device.is_orien_locked()
end

--- 振动设备
function device.vibrator()
end

--- 获取设备类型
---@return string 设备类型
function device.type()
end

--- 获取设备名称
---@return string 设备名称
function device.name()
end

--- 设置设备名称
---@param name string 设备名称
function device.set_name(name)
end

--- 获取设备 UDID
---@return string 设备 UDID
function device.udid()
end

--- 获取设备的序列号
---@return string 设备的序列号
function device.serial_number()
end

--- 获取设备的 WiFi MAC 地址
---@return string 设备的 WiFi MAC 地址
function device.wifi_mac()
end

--- 获取设备的蓝牙 MAC 地址
---@return string 设备的蓝牙 MAC 地址
function device.bluetooth_mac()
end

--- 获取设备所有的网络接口地址
---@return table 设备所有的网络接口地址，结构是这样 { {网络接口名称1, 网络接口地址1}, {网络接口名称2, 网络接口地址2}, ... }
function device.ifaddrs()
end

--- 获取当前设备电池剩余电量
---@return number 当前设备电池剩余电量，0 表示电池电量空，1 表示电池电量满
function device.battery_level()
end

--- 获取当前设备充电状态
---@return string 当前设备充电状态，"Charging" 表示充电，"Unplugged" 表示未充电，"Full" 表示充电满
function device.battery_state()
end

--- 打开设备 WiFi
function device.turn_on_wifi()
end

--- 关闭设备 WiFi
function device.turn_off_wifi()
end

--- 获取设备 WiFi 状态
---@return boolean 设备 WiFi 状态，true 表示开启，false 表示关闭
function device.is_wifi_on()
end

--- 打开设备蜂窝数据
function device.turn_on_data()
end

--- 关闭设备蜂窝数据
function device.turn_off_data()
end

--- 获取设备蜂窝数据状态
---@return boolean 设备蜂窝数据状态，true 表示开启，false 表示关闭
function device.is_data_on()
end

--- 打开设备蓝牙
function device.turn_on_bluetooth()
end

--- 关闭设备蓝牙
function device.turn_off_bluetooth()
end

--- 获取设备蓝牙状态
---@return boolean 设备蓝牙状态，true 表示开启，false 表示关闭
function device.is_bluetooth_on()
end

--- 打开设备飞行模式
function device.turn_on_airplane()
end

--- 关闭设备飞行模式
function device.turn_off_airplane()
end

--- 获取设备飞行模式状态
---@return boolean 设备飞行模式状态，true 表示开启，false 表示关闭
function device.is_airplane_on()
end

--- 连接到当前设置所选的 VPN
function device.tuen_on_vpn()
end

--- 断开已连接的 VPN
function device.turn_off_vpn()
end

--- 判断当前是否打开了 VPN
---@return boolean 当前是否打开了 VPN，true 表示打开了 VPN，false 表示没有打开 VPN
function device.is_vpn_on()
end

--- 打开设备闪光灯
---@param level number 设备闪光灯的亮度，0.0 表示关闭，1.0 表示最亮
function device.flash_on()
end

--- 关闭设备闪光灯
function device.flash_off()
end

--- 判断设备闪光灯是否打开
---@return boolean 设备闪光灯是否打开，true 表示打开，false 表示关闭
function device.is_flash_on()
end

--- 打开“减少动态效果”开关
function device.reduce_motion_on()
end

--- 关闭“减少动态效果”开关
function device.reduce_motion_off()
end

--- 判断“减少动态效果”开关是否打开
---@return boolean “减少动态效果”开关是否打开，true 表示打开，false 表示关闭
function device.is_reduce_motion_on()
end

--- 打开 AssistiveTouch
function device.assistive_touch_on()
end

--- 关闭 AssistiveTouch
function device.assistive_touch_off()
end

--- 判断 AssistiveTouch 是否打开
---@return boolean 是否打开，true 表示打开，false 表示关闭
function device.is_assistive_touch_on()
end

--- 打开位置服务
function device.location_services_on()
end

--- 关闭位置服务
function device.location_services_off()
end

--- 判断位置服务是否打开
---@return boolean 是否打开，true 表示打开，false 表示关闭
function device.is_location_services_on()
end

--- 允许应用弹框要求授予跟踪权限
function device.tracking_on()
end

--- 禁止应用弹框要求授予跟踪权限
function device.tracking_off()
end

--- 检查是否允许应用弹框要求授予跟踪权限
---@return boolean 是否允许，true 表示允许，false 表示禁止
function device.is_tracking_on()
end

--- 获取背光亮度值
---@return number 背光亮度值，0.0 表示关闭，1.0 表示最亮
function device.brightness()
end

--- 设置背光亮度值
---@param brightness number 背光亮度值，0.0 表示关闭，1.0 表示最亮
function device.set_brightness(brightness)
end

--- 设置自动锁屏分钟数
---@param minutes number 自动锁屏分钟数，0 表示关闭自动锁屏，大于 0 表示自动锁屏的分钟数，只能设置为设备有的分钟等级
function device.set_autolock_time(minutes)
end

--- 设置设备音量
---@param volume number 设备音量，0.0 表示关闭，1.0 表示最大音量
function device.set_volume(volume)
end

--- 扫描无线局域网
---@return table 扫描到的无线局域网设备列表
function device.scan_wifi()
end

--- 加入到一个无线局域网
---@param ssid string 无线局域网的 SSID
---@param password string 无线局域网的密码
---@return boolean 加入无线局域网是否成功，true 表示成功，false 表示失败
function device.join_wifi(ssid, password)
end

--- 离开一个无线局域网
function device.leave_wifi()
end


--------------------------------------------------------------------------------
-- 图片模块
--------------------------------------------------------------------------------

---@class image*
image = {}

--- 判断一个值是否是图片对象
---@param value any 值
---@return boolean 值是否是图片对象，true 表示是，false 表示不是
function image.is(value)
end

--- 从文件创建图片对象
---@param path string 图片文件路径
---@return Image* 图片对象
function image.load_file(path)
end

--- 从数据创建图片对象
---@param data string 图片数据
---@return Image* 图片对象
function image.load_data(data)
end


---@class Image*
Image = {}

--- 从图片对象创建拷贝
---@return Image* 新的图片对象
function Image:copy()
end

--- 从图片对象截取部分创建拷贝
---@param left? integer 左边距
---@param top? integer 上边距
---@param right? integer 右边距
---@param bottom? integer 下边距
---@return Image* 新的图片对象
function Image:crop(left, top, right, bottom)
end

--- 保存图片对象到相册
function Image:save_to_album()
end

--- 输出图片对象到 PNG 格式的文件
---@param path string 文件路径
function Image:save_to_png_file(path)
end

--- 输出图片对象到 JPEG 格式的文件
---@param path string 文件路径
---@param quality number 图片质量，0.0 表示最差，1.0 表示最好
function Image:save_to_jpeg_file(path, quality)
end

--- 获取图片对象的 PNG 格式数据
---@return string PNG 格式数据
function Image:png_data()
end

--- 获取图片对象的 JPEG 格式数据
---@param quality number 图片质量，0.0 表示最差，1.0 表示最好
---@return string JPEG 格式数据
function Image:jpeg_data(quality)
end

--- 90度左旋转图片对象
---@return Image* 新的图片对象
function Image:turn_left()
end

--- 90度右旋转图片对象
---@return Image* 新的图片对象
function Image:turn_right()
end

--- 180度旋转图片对象
---@return Image* 新的图片对象
function Image:turn_upondown()
end

--- 获取图片对象的尺寸
---@return number 图片对象的宽度
---@return number 图片对象的高度
function Image:size()
end

--- 获取图片对象的宽度
---@return number 图片对象的宽度
function Image:width()
end

--- 获取图片对象的高度
---@return number 图片对象的高度
function Image:height()
end

--- 获取图片对象某点颜色
---@param x integer 图片对象的 x 坐标
---@param y integer 图片对象的 y 坐标
---@return integer 图片对象某点的颜色，0xRRGGBB
---@return integer 图片对象某点的透明度，0x00 表示完全透明，0xFF 表示完全不透明
function Image:get_color(x, y)
end

--- 在图上找色
---@param colors table 颜色匹配表，详见文档
---@param similarity? integer 颜色相似度，-100-100，默认为 100，负相似度意味着匹配小于该绝对值的相似度
---@param left? integer 横坐标左边界
---@param top? integer 纵坐标上边界
---@param right? integer 横坐标右边界
---@param bottom? integer 纵坐标下边界
---@return integer x 横坐标，失败返回 -1
---@return integer y 纵坐标，失败返回 -1
function Image:find_color(colors, similarity, left, top, right, bottom)
end

--- 图片多点颜色匹配
---@param colors table 颜色匹配表，详见文档
---@param similarity? integer 颜色相似度，0-100，默认为 100
---@return boolean 是否完全匹配
function Image:is_colors(colors, similarity)
end

--- 销毁一个图片对象
function Image:destroy()
end

--- 图中找图
---@param image Image* 待查找的图片对象
---@return integer x 横坐标
---@return integer y 纵坐标
---@return number 图片相似度，0.0-1.0
function Image:cv_find_image(image)
end

--- 图片自动二值化
---@param threshold number 阈值，0.0-255.0，默认为 127.0
---@return Image* 新的图片对象
function Image:cv_binarization(threshold)
end

--- 对图片进行光学字符识别
---@param left? integer 横坐标左边界
---@param top? integer 纵坐标上边界
---@param right? integer 横坐标右边界
---@param bottom? integer 纵坐标下边界
---@param type? integer 识别类型，0 表示精确；1 表示模糊，默认为 0
---@return table 识别结果字符串列表
---@return table 识别结果详情，包括识别到的区域坐标
function Image:ocr_text(left, top, right, bottom, type)
end

--- 在图片上寻找条形码或二维码
---@param left? integer 横坐标左边界
---@param top? integer 纵坐标上边界
---@param right? integer 横坐标右边界
---@param bottom? integer 纵坐标下边界
---@return table 条码内容列表
---@return table 条码位置详情
function Image:detect_barcodes(left, top, right, bottom)
end

--- 解码一个二维码图片
---@return string 二维码内容
---@return table 二维码位置详情
function Image:qr_decode()
end


--------------------------------------------------------------------------------
-- 进程字典
--------------------------------------------------------------------------------

---@class proc*
proc = {}

--- 存储值到进程字典
---@param key string 键名
---@param value string 值
---@return string 返回这个键位置的旧的值，如果没有则返回空字符串
function proc:put(key, value)
end

--- 查看进程字典存储的值
---@param key string 键名
---@return string 返回该键位置存储的值，如果该键位置没有值则返回空字符串
function proc:get(key)
end

--- 向进程队列词典的尾部压入一个值
---@param key string 键名
---@param value string 值
---@return integer 当前队列长度
function proc:queue_push(key, value)
end

--- 从进程队列词典的尾部弹出一个值
---@param key string 键名
---@return string 返回弹出的值，如果队列不存在或为空，则返回空字符串
function proc:queue_pop(key)
end

--- 向进程队列词典的头部压入一个值
---@param key string 键名
---@param value string 值
---@return integer 当前队列长度
function proc:queue_unshift(key, value)
end

--- 从进程队列词典的头部弹出一个值
---@param key string 键名
---@return string 返回弹出的值，如果队列不存在或为空，则返回空字符串
function proc:queue_shift(key)
end

--- 从进程队列词典中弹出所有值
---@param key string 键名
---@return table 返回弹出的值列表，如果队列不存在或为空，则返回空列表
function proc:queue_clear(key)
end

--- 获取进程队列词典的尺寸
---@param key string 键名
---@return integer 当前队列长度
function proc:queue_size(key)
end


--------------------------------------------------------------------------------
-- 线程模块
--------------------------------------------------------------------------------

---@class thread*
thread = {}

--- 派发一个任务
---@param task function 任务函数
---@param error_callback function 错误回调函数
---@return integer 任务 ID，这个 ID 可用于结束或是等待一个任务
function thread.dispatch(task, error_callback)
end

--- 获取当前任务的 ID
---@return integer 当前任务 ID，这个 ID 可用于结束或是等待一个任务
function thread.current_id()
end

--- 从队列中移除一项任务
---@param tid integer 任务 ID
function thread.kill(tid)
end

--- 阻塞等待一个任务完成
---@param tid integer 任务 ID
---@param timeout number 超时时间，单位为秒，超时后将返回
function thread.wait(tid, timeout)
end


--------------------------------------------------------------------------------
-- HTTP 模块
--------------------------------------------------------------------------------

---@class http*
http = {}

--- 发起 GET 请求
---@param url string 请求 URL
---@param timeout? number 连接超时时间，单位为秒，默认为 10 秒
---@param headers? table 请求头
---@return integer HTTP 状态码，请求超时返回 -1
---@return string 返回头 JSON 文本
---@return string 返回主体
function http.get(url, timeout, headers)
end

--- 发起 POST 请求
---@param url string 请求 URL
---@param timeout? number 连接超时时间，单位为秒，默认为 10 秒
---@param headers? table 请求头
---@param body? string 请求主体
---@return integer HTTP 状态码，请求超时返回 -1
---@return string 返回头 JSON 文本
---@return string 返回主体
function http.post(url, timeout, headers, body)
end

--- HTTP 文件下载
---@param url string 请求 URL
---@param path string 本地文件路径
---@param timeout? number 连接超时时间，单位为秒，默认为 10 秒（连接建立以后，下载时间不计算在内）
---@param allow_discontinue? boolean 是否允许断点续传，默认为 false
---@param progress_callback? function 进度回调函数，参数为当前下载进度，返回值为 true 则打断下载
---@param buffer_size? integer 缓冲区大小，默认为 8192
---@return boolean 下载是否成功
---@return table|string 下载结果详情，如果下载失败，则返回错误信息
function http.download(url, path, timeout, allow_discontinue, progress_callback)
end

--- 发起 HEAD 请求
---@param url string 请求 URL
---@param timeout? number 连接超时时间，单位为秒，默认为 10 秒
---@param headers? table 请求头
---@return integer HTTP 状态码，请求超时返回 -1
---@return string 返回头 JSON 文本
function http.head(url, timeout, headers)
end

--- 发起 DELETE 请求
---@param url string 请求 URL
---@param timeout? number 连接超时时间，单位为秒，默认为 10 秒
---@param headers? table 请求头
---@return integer HTTP 状态码，请求超时返回 -1
---@return string 返回头 JSON 文本
---@return string 返回主体
function http.delete(url, timeout, headers)
end

--- 发起 PUT 请求
---@param url string 请求 URL
---@param timeout? number 连接超时时间，单位为秒，默认为 10 秒
---@param headers? table 请求头
---@param body? string 请求主体
---@return integer HTTP 状态码，请求超时返回 -1
---@return string 返回头 JSON 文本
---@return string 返回主体
function http.put(url, timeout, headers, body)
end


--------------------------------------------------------------------------------
-- FTP 模块
--------------------------------------------------------------------------------

---@class ftp*
ftp = {}

--- FTP 文件下载
---@param url string 请求 URL
---@param path string 本地文件路径
---@param timeout? number 连接超时时间，单位为秒，默认为 10 秒（连接建立以后，下载时间不计算在内）
---@param allow_discontinue? boolean 是否允许断点续传，默认为 false
---@param progress_callback? function 进度回调函数，参数为当前下载进度，返回值为 true 则打断下载
---@param buffer_size? integer 缓冲区大小，默认为 8192
---@return boolean 下载是否成功
---@return table|string 下载结果详情，如果下载失败，则返回错误信息
function ftp.download(url, path, timeout, allow_discontinue, progress_callback)
end

--- FTP 文件上传
---@param path string 本地文件路径
---@param url string 请求 URL
---@param timeout? number 连接超时时间，单位为秒，默认为 10 秒（连接建立以后，上传时间不计算在内）
---@param allow_discontinue? boolean 是否允许断点续传，默认为 false
---@param progress_callback? function 进度回调函数，参数为当前上传进度，返回值为 true 则打断上传
---@param buffer_size? integer 缓冲区大小，默认为 8192
---@return boolean 上传是否成功
---@return table|string 上传结果详情，如果上传失败，则返回错误信息
function ftp.upload(path, url, timeout, allow_discontinue, progress_callback)
end


--------------------------------------------------------------------------------
-- SAMBA 模块
--------------------------------------------------------------------------------

---@class samba*
samba = {}

--- 新建一个 SAMBA 客户端
---@param config table 客户端设置
---@return SambaConfig* 客户端对象
--- ```lua
---     {
---         workgroup = 'WORKGROUP',
---         username = 'useradmin',
---         password = 'userpassword'
---     }
--- ```
function samba.client(config)
end

--- 新建一个 SAMBA 客户端
---@param workgroup string 工作组
---@param username string 用户名
---@param password string 密码
---@return SambaConfig* 客户端对象
function samba.client(workgroup, username, password)
end

---@class SambaConfig*
SambaConfig = {}

--- 列出指定远程目录的内容
---@param path string 远程目录路径
---@return table 包含远程目录内容的顺序表，包含文件名和文件类型
---@return error 错误信息
function SambaConfig:list(path)
end

--- 创建远程目录
---@param path string 远程目录路径
---@return table 远程目录属性
---@return error 错误信息
function SambaConfig:mkdir(path)
end

--- 创建空白远程文件
---@param path string 远程文件路径
---@return table 远程文件属性
---@return error 错误信息
function SambaConfig:touch(path)
end

--- 删除指定远程文件或目录（不支持非空目录）
---@param path string 远程文件或目录路径
---@return boolean 是否删除成功
---@return error 错误信息
function SambaConfig:remove(path)
end

--- 递归删除远程目录
---@param path string 远程目录路径
---@return boolean 是否删除成功
---@return error 错误信息
function SambaConfig:rmdir(path)
end

--- 重命名指定远程文件或目录
---@param old_path string 远程文件或目录旧路径
---@param new_path string 远程文件或目录新路径
---@return boolean 是否重命名成功
---@return error 错误信息
function SambaConfig:rename(old_path, new_path)
end

--- 下载指定远程文件或目录（支持递归下载整个远程目录）
---@param path string 远程文件或目录路径
---@param local_path string 本地文件或目录路径
---@param progress_callback function 进度回调函数，参数为当前下载进度，返回值为 true 则打断下载
---@return boolean 下载是否成功
---@return error 错误信息
function SambaConfig:download(path, local_path, progress_callback)
end

--- 上传指定本地文件或目录（支持递归上传整个本地目录）
---@param local_path string 本地文件或目录路径
---@param path string 远程文件或目录路径
---@param progress_callback function 进度回调函数，参数为当前上传进度，返回值为 true 则打断上传
---@return boolean 上传是否成功
---@return error 错误信息
function SambaConfig:upload(local_path, path, progress_callback)
end


--------------------------------------------------------------------------------
-- 弹窗助手模块
--------------------------------------------------------------------------------

---@class alert*
alert = {}

--- 打开调试日志
function alert.enable_logging()
end

--- 关闭调试日志
function alert.disable_logging()
end

--- 打开自动点击
function alert.enable_autopass()
end

--- 关闭自动点击
function alert.disable_autopass()
end

--- 设置自动点击延迟
---@param delay number 延迟时间，单位毫秒
function alert.set_autopass_delay(delay)
end

--- 设置弹窗助手全局规则
---@param rules table 弹窗助手全局规则，详见文档
---
--- ```lua
---     {
---         {
---             ["title"] = "^About Cydia Installer$",  -- 通过标题过滤弹框 (正则表达式)
---             ["action"] = { ["title"] = "Close" }  -- 通过标题指定动作 (正则表达式)
---             ["action"] = 1,  -- 通过索引指定动作 (以 1 为起始, 0 的效果和 1 一致)
---         },
---         {
---             ["title"] = "^Verification Error$",  -- 通过标题过滤弹框 (正则表达式)
---             ["action"] = { ["title"] = "OK" },
---             ["action"] = "OK",  -- 通过标题指定动作 (简写)
---         },
---         {
---             ["title"] = "^Enter Cydia\\/APT URL$",  -- 通过标题过滤弹框 (正则表达式)
---             ["textfields"] = {
---                 { ["text"] = "https://build.frida.re" },  -- 指定文本框内容
---             },
---             ["textfields"] = { "https://" },  -- 指定文本框内容 (简写)
---             ["action"] = {
---                 ["title"] = "Add Source",  -- 通过标题指定动作 (正则表达式)
---                 ["delay"] = 500.0,  -- 设置动作延迟 (毫秒)
---             },
---         }
---      }
--- ```
function alert.get_global_rules(rules)
end

--- 获取弹窗助手全局规则
---@return table 弹窗助手全局规则，详见文档
---
--- ```lua
---     {
---         {
---             ["title"] = "^About Cydia Installer$",  -- 通过标题过滤弹框 (正则表达式)
---             ["action"] = { ["title"] = "Close" }  -- 通过标题指定动作 (正则表达式)
---             ["action"] = 1,  -- 通过索引指定动作 (以 1 为起始, 0 的效果和 1 一致)
---         },
---         {
---             ["title"] = "^Verification Error$",  -- 通过标题过滤弹框 (正则表达式)
---             ["action"] = { ["title"] = "OK" },
---             ["action"] = "OK",  -- 通过标题指定动作 (简写)
---         },
---         {
---             ["title"] = "^Enter Cydia\\/APT URL$",  -- 通过标题过滤弹框 (正则表达式)
---             ["textfields"] = {
---                 { ["text"] = "https://build.frida.re" },  -- 指定文本框内容
---             },
---             ["textfields"] = { "https://" },  -- 指定文本框内容 (简写)
---             ["action"] = {
---                 ["title"] = "Add Source",  -- 通过标题指定动作 (正则表达式)
---                 ["delay"] = 500.0,  -- 设置动作延迟 (毫秒)
---             },
---         }
---      }
--- ```
function alert.get_global_rules()
end

--- 清空弹窗助手全局规则
function alert.clear_global_rules()
end

--- 设置弹窗助手应用程序规则
---@param appId string App 的应用程序标识符
---@param rules table 弹窗助手应用程序规则，详见文档
---
--- ```lua
---     {
---         {
---             ["title"] = "^About Cydia Installer$",  -- 通过标题过滤弹框 (正则表达式)
---             ["action"] = { ["title"] = "Close" }  -- 通过标题指定动作 (正则表达式)
---             ["action"] = 1,  -- 通过索引指定动作 (以 1 为起始, 0 的效果和 1 一致)
---         },
---         {
---             ["title"] = "^Verification Error$",  -- 通过标题过滤弹框 (正则表达式)
---             ["action"] = { ["title"] = "OK" },
---             ["action"] = "OK",  -- 通过标题指定动作 (简写)
---         },
---         {
---             ["title"] = "^Enter Cydia\\/APT URL$",  -- 通过标题过滤弹框 (正则表达式)
---             ["textfields"] = {
---                 { ["text"] = "https://build.frida.re" },  -- 指定文本框内容
---             },
---             ["textfields"] = { "https://" },  -- 指定文本框内容 (简写)
---             ["action"] = {
---                 ["title"] = "Add Source",  -- 通过标题指定动作 (正则表达式)
---                 ["delay"] = 500.0,  -- 设置动作延迟 (毫秒)
---             },
---         }
---      }
--- ```
function alert.set_local_rules(appId, rules)
end

--- 获取弹窗助手应用程序规则
---@param appId string App 的应用程序标识符
---@return table 弹窗助手应用程序规则，详见文档
---
--- ```lua
---     {
---         {
---             ["title"] = "^About Cydia Installer$",  -- 通过标题过滤弹框 (正则表达式)
---             ["action"] = { ["title"] = "Close" }  -- 通过标题指定动作 (正则表达式)
---             ["action"] = 1,  -- 通过索引指定动作 (以 1 为起始, 0 的效果和 1 一致)
---         },
---         {
---             ["title"] = "^Verification Error$",  -- 通过标题过滤弹框 (正则表达式)
---             ["action"] = { ["title"] = "OK" },
---             ["action"] = "OK",  -- 通过标题指定动作 (简写)
---         },
---         {
---             ["title"] = "^Enter Cydia\\/APT URL$",  -- 通过标题过滤弹框 (正则表达式)
---             ["textfields"] = {
---                 { ["text"] = "https://build.frida.re" },  -- 指定文本框内容
---             },
---             ["textfields"] = { "https://" },  -- 指定文本框内容 (简写)
---             ["action"] = {
---                 ["title"] = "Add Source",  -- 通过标题指定动作 (正则表达式)
---                 ["delay"] = 500.0,  -- 设置动作延迟 (毫秒)
---             },
---         }
---      }
--- ```
function alert.get_local_rules(appId)
end

--- 清空弹窗助手应用程序规则
---@param appId string App 的应用程序标识符，使用 "*" 清空全部应用程序规则
function alert.clear_local_rules(appId)
end

--- 获取处于最前方的弹窗
---@return table 弹窗信息，详见文档
--- ```lua
---     {  -- table: 0x104cadbf0
---         textfields = {  -- table: 0x104cadce0
---             [1] = {  -- table: 0x104cad8e0
---                 text = "https://",
---                 placeholder = "",
---             },
---         },
---         actions = {  -- table: 0x104cad9e0
---             [1] = {  -- table: 0x104cada20
---                 enabled = true,
---                 style = "cancel",
---                 title = "Cancel",
---             },
---             [2] = {  -- table: 0x104cae070
---                 enabled = true,
---                 style = "default",
---                 title = "Add Source",
---             },
---         },
---         style = "alert",
---         message = "",
---         class = "UIAlertController",
---         title = "Enter Cydia/APT URL",
---     }
--- ```
function alert.get_topmost()
end

--- 点击处于最前方的弹窗
---@param rule table 处理规则，详见文档
--- ```lua
---     {
---         ["action"] = {
---             ["title"] = "Log In",
---             ["delay"] = 1000.0,
---         }
---     }
--- ```
function alert.dismiss_topmost(rule)
end

--- 点击处于最前方的弹窗
---@param button string|integer 需要点击按钮的名称或索引
function alert.dismiss_topmost(button)
end


--------------------------------------------------------------------------------
-- 网页助手模块
--------------------------------------------------------------------------------

---@class monkey*
monkey = {}

--- 扫描前台应用中所有的 WebView
---@return table 所有的 WebView 列表，详见文档
-- ```lua
--     {  -- table: 0x10166a0d0
--         views = {  -- table: 0x10166a110
--             [1] = {  -- table: 0x10166a1b0
--                 isInjectable = true,
--                 responder = "com.saurik.Cydia",
--                 contentScale = 1.0,
--                 host = "cydia.saurik.com",
--                 path = "/ui/ios~iphone/1.1/home",
--                 loading = false,
--                 targetClass = "UIWebView",
--                 class = "CyteWebView",
--                 contentFrame = {  -- table: 0x10166a4c0
--                         [1] = 0.0,
--                         [2] = 0.0,
--                         [3] = 414.0,
--                         [4] = 896.0,
--                 },
--                 absoluteString = "https://cydia.saurik.com/ui/ios~iphone/1.1/home/",
--                 scheme = "https",
--                 objectIdentifier = "C5C93951-ECEE-45D5-BD5A-D436057082B0",
--             },
--         },
--         responder = "com.saurik.Cydia",
--     }
-- ```
function monkey.list_webviews()
end

--- 使用过滤条件扫描前台应用中的 WebView
---@param filter table 过滤条件，详见文档
-- ```lua
--     {
--         ["responder"] = "com.apple.mobilesafari",  -- 精确匹配
--         ["scheme"] = "https",  -- 精确匹配
--         ["host"] = "www.bing.com",  -- 精确匹配
--         ["path"] = "/",  -- 精确匹配
--         ["absoluteString"] = "https://www.bing.com/",  -- 精确匹配
--         ["url"] = "^https://(www.)?bing.com/$",  -- 等同于 absoluteString 的标准正则匹配
--     }
-- ```
---@return table 符合条件的 WebView 属性表，详见文档
-- ```lua
--     {  -- table: 0x102446ca0
--         isInjectable = true,
--         responder = "com.apple.mobilesafari",
--         loading = false,
--         objectIdentifier = "F7F00685-D7F1-4870-8F0C-92923A0D2EA1",
--         host = "www.bing.com",
--         path = "/",
--         class = "_SFWebView",
--         absoluteString = "https://www.bing.com/",
--         targetClass = "WKWebView",
--         scheme = "https",
--         contentFrame = {  -- table: 0x102446ce0
--             [1] = 0.0,
--             [2] = 98.0,
--             [3] = 414.0,
--             [4] = 715.0,
--         },
--         contentScale = 1.0,
--         title = "Bing",
--         estimatedProgress = 1.0,
--     }
-- ```
function monkey.get_webview(filter)
end

--- 通过 ID 获取扫描结果中的 WebView
---@param objectIdentifier string WebView ID
---@return table WebView 属性表，详见文档
-- ```lua
--     {  -- table: 0x100e1fe10
--         isInjectable = true,
--         responder = "com.saurik.Cydia",
--         contentScale = 1.0,
--         host = "cydia.saurik.com",
--         path = "/ui/ios~iphone/1.1/home",
--         loading = false,
--         targetClass = "UIWebView",
--         class = "CyteWebView",
--         contentFrame = {  -- table: 0x100e57ce0
--             [1] = 0.0,
--             [2] = 0.0,
--             [3] = 414.0,
--             [4] = 896.0,
--         },
--         absoluteString = "https://cydia.saurik.com/ui/ios~iphone/1.1/home/",
--         scheme = "https",
--         objectIdentifier = "C5C93951-ECEE-45D5-BD5A-D436057082B0",
--     }
-- ```
function monkey.get_webview_id(objectIdentifier)
end

--- 通过 ID 执行 JavaScript
---@param objectIdentifier string WebView ID
---@param script string JavaScript 脚本
---@return any 脚本执行结果，支持多种类型
function monkey.eval_id(objectIdentifier, script)
end

--- 在符合条件的 WebView 中执行 JavaScript
---@param filter table 过滤条件，详见文档
-- ```lua
--     {
--         ["responder"] = "com.apple.mobilesafari",  -- 精确匹配
--         ["scheme"] = "https",  -- 精确匹配
--         ["host"] = "www.bing.com",  -- 精确匹配
--         ["path"] = "/",  -- 精确匹配
--         ["absoluteString"] = "https://www.bing.com/",  -- 精确匹配
--         ["url"] = "^https://(www.)?bing.com/$",  -- 等同于 absoluteString 的标准正则匹配
--     }
-- ```
---@param script string JavaScript 脚本
---@return any 脚本执行结果，支持多种类型
function monkey.eval(filter, script)
end

--- 通过 ID 键入文本
---@param objectIdentifier string WebView ID
---@param text string 文本内容
function monkey.input_id(objectIdentifier, text)
end

--- 在符合条件的 WebView 中键入文本
---@param filter table 过滤条件，详见文档
-- ```lua
--     {
--         ["responder"] = "com.apple.mobilesafari",  -- 精确匹配
--         ["scheme"] = "https",  -- 精确匹配
--         ["host"] = "www.bing.com",  -- 精确匹配
--         ["path"] = "/",  -- 精确匹配
--         ["absoluteString"] = "https://www.bing.com/",  -- 精确匹配
--         ["url"] = "^https://(www.)?bing.com/$",  -- 等同于 absoluteString 的标准正则匹配
--     }
-- ```
---@param text string 文本内容
function monkey.input(filter, text)
end

--- 添加用户脚本
---@param filter table 过滤条件，详见文档
-- ```lua
--     {
--         ["responder"] = "com.apple.mobilesafari",  -- 精确匹配
--         ["scheme"] = "https",  -- 精确匹配
--         ["host"] = "www.bing.com",  -- 精确匹配
--         ["path"] = "/",  -- 精确匹配
--         ["absoluteString"] = "https://www.bing.com/",  -- 精确匹配
--         ["url"] = "^https://(www.)?bing.com/$",  -- 等同于 absoluteString 的标准正则匹配
--     }
-- ```
---@param script string JavaScript 脚本
---@param executeBeforeLoad boolean 是否在 WebView 加载前执行脚本
---@param executeInMainFrame boolean 是否在 WebView 主帧框执行脚本
function monkey.add_userscript(filter, script, executeBeforeLoad, executeInMainFrame)
end

--- 清空用户脚本
function monkey.clear_userscripts()
end

--- 列出所有用户脚本
---@return table 用户脚本列表，详见文档
function monkey.list_userscripts()
end

--- 读取用户脚本消息
---@param filter table 过滤条件，详见文档
-- ```lua
--     {
--         ["responder"] = "com.apple.mobilesafari",  -- 精确匹配
--         ["scheme"] = "https",  -- 精确匹配
--         ["host"] = "www.bing.com",  -- 精确匹配
--         ["path"] = "/",  -- 精确匹配
--         ["absoluteString"] = "https://www.bing.com/",  -- 精确匹配
--         ["url"] = "^https://(www.)?bing.com/$",  -- 等同于 absoluteString 的标准正则匹配
--     }
-- ```
---@return table 用户脚本消息，详见文档
-- ```lua
--     {  -- table: 0x127fe2e40
--         [1] = {  -- table: 0x127f70360
--             host = "www.bing.com",
--             frameInfo = {  -- table: 0x127f1a410
--                 isMainFrame = true,
--                 securityOrigin = {  -- table: 0x127f33690
--                         host = "www.bing.com",
--                         protocol = "https",
--                         port = 0,
--                 },
--                 requestURL = "https://www.bing.com/",
--             },
--             path = "/",
--             scheme = "https",
--             name = "$_TM_WKNativeLog",
--             body = {  -- table: 0x127fe2f80
--                 type = "loaded",
--                 id = "sb_form",
--             },
--             absoluteString = "https://www.bing.com/",
--         },
--     }
-- ```
function monkey.list_userscript_messages(filter)
end

--- 清空用户脚本消息
function monkey.clear_userscript_messages()
end

--- 获取处于最前方的表单元素
---@return table 表单元素属性表，详见文档
-- ```lua
--     {  -- table: 0x12ad11f70
--         allowsMultipleSelection = false,
--         selectedItemValues = {  -- table: 0x127fe19e0
--             [1] = "Tyrannosaurus",
--         },
--         type = "select",
--         selectedItems = {  -- table: 0x127fe1a50
--             [1] = {  -- table: 0x127fe1ac0
--                 isGroup = false,
--                 index = 2,
--                 isSelected = true,
--                 isEnabled = true,
--                 value = "Tyrannosaurus",
--             },
--         },
--         items = {  -- table: 0x12ad11fb0
--             [1] = {  -- table: 0x12ad12010
--                 isGroup = true,
--                 index = 1,
--                 isSelected = false,
--                 isEnabled = false,
--                 value = "Theropods",
--             },
--             [2] = {  -- table: 0x127fe0bc0
--                 isGroup = false,
--                 index = 2,
--                 isSelected = true,
--                 isEnabled = true,
--                 value = "Tyrannosaurus",
--             },
--             [3] = {  -- table: 0x127fe0c50
--                 isGroup = false,
--                 index = 3,
--                 isSelected = false,
--                 isEnabled = true,
--                 value = "Velociraptor",
--             },
--             [4] = {  -- table: 0x127fe0d90
--                 isGroup = false,
--                 index = 4,
--                 isSelected = false,
--                 isEnabled = true,
--                 value = "Deinonychus",
--             },
--             [5] = {  -- table: 0x127fe0e00
--                 isGroup = true,
--                 index = 5,
--                 isSelected = false,
--                 isEnabled = false,
--                 value = "Sauropods",
--             },
--             [6] = {  -- table: 0x127fdff90
--                 isGroup = false,
--                 index = 6,
--                 isSelected = false,
--                 isEnabled = true,
--                 value = "Diplodocus",
--             },
--             [7] = {  -- table: 0x127fe1250
--                 isGroup = false,
--                 index = 7,
--                 isSelected = false,
--                 isEnabled = true,
--                 value = "Saltasaurus",
--             },
--             [8] = {  -- table: 0x127fe12c0
--                 isGroup = false,
--                 index = 8,
--                 isSelected = false,
--                 isEnabled = true,
--                 value = "Apatosaurus",
--             },
--         },
--         selectedItemIndexes = {  -- table: 0x127fe1790
--             [1] = 1,
--         },
--         flattenedItems = {  -- table: 0x127fe1440
--             [1] = "^Theropods",
--             [2] = "Tyrannosaurus",
--             [3] = "Velociraptor",
--             [4] = "Deinonychus",
--             [5] = "^Sauropods",
--             [6] = "Diplodocus",
--             [7] = "Saltasaurus",
--             [8] = "Apatosaurus",
--         },
--         selectedItemCount = 1,
--     }
-- ```
function monkey.get_topmost_formcontrol()
end

--- 设置处于最前方的表单元素的值
---@param value string|integer 表单元素值或索引
function monkey.update_topmost_formcontrol(value)
end

--- 取消填写处于最前方的表单元素
function monkey.dismiss_topmost_formcontrol()
end

--- 关闭所有标签页（仅支持 Safari）
function monkey.close_all_tabs()
end

--- 打开无痕浏览模式（仅支持 Safari）
function monkey.private_browsing_on()
end

--- 关闭无痕浏览模式（仅支持 Safari）
function monkey.private_browsing_off()
end

--- 打开控制台远程调试
function monkey.remote_inspector_on()
end

--- 关闭控制台远程调试
function monkey.remote_inspector_off()
end

--- 获取控制台远程调试开关状态
---@return boolean 控制台远程调试开关状态
function monkey.is_remote_inspector_on()
end


--------------------------------------------------------------------------------
-- 商店助手模块
--------------------------------------------------------------------------------

---@class appstore*
appstore = {}

--- 模拟登录 App Store
---@param username string 用户名
---@param password string 密码
---@return boolean 是否登录成功
---@return string|nil 登录错误信息
function appstore.login(username, password)
end

--- 登出 App Store
function appstore.logout()
end

--- 获取当前 App Store 用户信息
---@return table 用户信息
function appstore.account()
end


--------------------------------------------------------------------------------
-- 小饼干模块
--------------------------------------------------------------------------------

---@class cookies*
cookies = {}

-- 列出所有的 cookie 列表
---@param id? string 应用程序标识符
---@return table cookie 列表
function cookies.list(id)
end

-- 过滤出指定的 cookie 列表
---@param filter table 过滤条件
-- ```lua
-- list = cookies.filter('/', '.live.com')  -- Path, Domain
-- list = cookies.filter {
--     Path = '/',
--     Domain = '.live.com',
-- }
-- ```
---@param id? string 应用程序标识符
---@return table cookie 列表
function cookies.filter(filter, id)
end

-- 过滤出指定的 cookie 列表
---@param path string Path
---@param domain string Domain
-- ```lua
-- list = cookies.filter('/', '.live.com')  -- Path, Domain
-- list = cookies.filter {
--     Path = '/',
--     Domain = '.live.com',
-- }
-- ```
---@param id? string 应用程序标识符
---@return table cookie 列表
function cookies.filter(path, domain, id)
end

-- 获取指定名称的 cookie
---@param filter table 过滤条件
-- ```lua
-- tab = cookies.get('MSCC', '/', '.live.com')  -- name, path, domain
-- tab = cookies.get {
--     Name = 'MSCC',
--     Path = '/',
--     Domain = '.live.com',
-- }
-- ```
---@param id? string 应用程序标识符
---@return table 单个 cookie
function cookies.get(filter, id)
end

-- 获取指定名称的 cookie
---@param name string Name
---@param path string Path
---@param domain string Domain
-- ```lua
-- tab = cookies.get('MSCC', '/', '.live.com')  -- Name, Path, Domain
-- tab = cookies.get {
--     Name = 'MSCC',
--     Path = '/',
--     Domain = '.live.com',
-- }
-- ```
---@param id? string 应用程序标识符
---@return table 单个 cookie
function cookies.get(name, path, domain, id)
end

-- 获取指定名称的 cookie 的值
---@param filter table 过滤条件
-- ```lua
-- value = cookies.value('MSCC', '/', '.live.com')
-- value = cookies.value {
--     Name = 'MSCC',
--     Path = '/',
--     Domain = '.live.com',
-- }
-- ```
---@param id? string 应用程序标识符
---@return string cookie 值
function cookies.value(filter, id)
end

-- 更新 cookie 列表
-- 列表中同样 name, path 和 domain 的 cookie 会被替换
---@param list table cookie 列表
---@param id? string 应用程序标识符
---@return boolean 是否更新成功
---@return string|nil 更新错误信息
function cookies.update(list, id)
end

-- 更新单个 cookie
-- 列表中同样 name, path 和 domain 的 cookie 会被替换
-- 如果 cookie 不存在，则会创建新的 cookie
---@param cookie table 单个 cookie
---@param id? string 应用程序标识符
---@return boolean 是否更新成功
---@return string|nil 更新错误信息
function cookies.update(cookie, id)
end

-- 设置 cookie 列表
-- 所有的 cookie 都会被删除，然后再添加
---@param list table cookie 列表
---@param id? string 应用程序标识符
---@return boolean 是否设置成功
---@return string|nil 设置错误信息
function cookies.replace(list, id)
end

-- 删除符合条件的 cookie
---@param filter table 过滤条件
-- ```lua
-- cookies.remove('MSCC', '/', '.live.com')
-- cookies.remove {
--     Name = 'MSCC',
--     Path = '/',
--     Domain = '.live.com',
-- }
-- ```
---@param id? string 应用程序标识符
---@return boolean 是否删除成功
---@return string|nil 删除错误信息
function cookies.remove(filter, id)
end

-- 删除符合条件的 cookie
---@param name string Name，如不指定，置为空字符串
---@param path string Path，如不指定，置为空字符串
---@param domain string Domain，如不指定，置为空字符串
-- ```lua
-- cookies.remove('MSCC', '/', '.live.com')
-- cookies.remove {
--     Name = 'MSCC',
--     Path = '/',
--     Domain = '.live.com',
-- }
-- ```
---@param id? string 应用程序标识符
---@return boolean 是否删除成功
---@return string|nil 删除错误信息
function cookies.remove(name, path, domain, id)
end

-- 清除所有 cookie
---@param id? string 应用程序标识符
---@return boolean 是否清除成功
---@return string|nil 清除错误信息
function cookies.clear(id)
end