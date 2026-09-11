# 第三方来源与许可

|项目／来源|地址|许可／用途|纳入本仓库的范围|
|---|---|---|---|
|MoonBit core|https://github.com/moonbitlang/core|Apache-2.0；工具链自带的容器、字符串、JSON、环境及错误运行时|作为依赖使用，没有拷贝实现源码|
|MoonBit 工具链|https://www.moonbitlang.com/download/|官方工具链按其发布条款使用|不随本仓库分发二进制|
|actions/checkout|https://github.com/actions/checkout|MIT；CI 检出|仅工作流引用|
|Python 标准库|https://www.python.org/|PSF；验证脚本运行环境|没有第三方 Python 包或 vendored 实现|

领域公式（集合并集／补集、列等价分组、连续区间和周期）为本项目自行实现，不是某个第三方织造库的源代码移植。图样和测试数据由本项目生成；SVG 是程序生成的矢量图，不含下载素材。

查重时读取的相邻仓库仅用于比较能力，不作为代码来源，见 docs/competition/duplicate-check.md。本版本没有实现 WIF，也不复制 WIF 规范正文。若后续引入依赖、标准片段、真实图样或移植算法，应在此补充具体版本、许可证、改动范围和原版权声明。

本仓库自己的源码、文档、测试及示例采用根目录 LICENSE 中的 MIT 许可。依赖的许可不被本项目的 MIT 许可覆盖。
