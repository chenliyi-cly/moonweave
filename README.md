# MoonWeave：MoonBit 织造草稿模拟与浮线分析

MoonWeave 把**穿综、提综或踩踏方案**转换为可检查的经纬交织图，分析跨循环接缝的浮线，并将手绘交织图反推为可执行的综框／直接踏板方案。面向织造教学、数字草稿工具和离线织机设置预检，不是布料物理仿真器。

原创 MoonBit 实现，MIT 许可；维护者／参赛贡献者为 **chenliyi-cly**。AI 辅助范围见 [AI_USAGE.md](AI_USAGE.md)。

## 获取与验证

安装官方 [MoonBit 工具链](https://www.moonbitlang.com/download/)，然后在本仓库执行：


```text
git clone https://github.com/chenliyi-cly/moonweave.git
cd moonweave
moon version --all
moon fmt --check
moon check --target wasm-gc --deny-warn
moon test --target wasm-gc
moon run examples/plain
```

在已有 MoonBit 项目中执行 `moon add chenliyi-cly/moonweave`。包文档：[MoonCakes](https://mooncakes.io/docs/chenliyi-cly/moonweave)。库只依赖工具链自带的 core。

验证工具链：moon 0.1.20260904、moonc 0.10.12。CI 在 wasm-gc、wasm、js、native 四个目标上运行相同验收脚本；native 使用 Linux C 编译器。

## 三个明确、可运行的示例

### 示例一：教师演示平纹交织

输入：4 次经向重复与 4 次纬向重复。运行：

    moon run examples/plain

结果：输出 8×8 的 #／. 交替图，并断言周期内没有长度 ≥2 的正面浮长。# 表示正面经纱在上，. 表示纬纱在上。每行是一次投纬，从左到右为穿综次序。

    #.#.#.#.
    .#.#.#.#
    #.#.#.#.
    .#.#.#.#
    #.#.#.#.
    .#.#.#.#
    #.#.#.#.
    .#.#.#.#

源文件：[examples/plain/main.mbt](examples/plain/main.mbt)。

### 示例二：织机草稿编辑器预检斜纹

输入：4 综框、4 踏板的 2/2 斜纹；最多同时提升 2 综框，允许浮长为 1。运行：

    moon run examples/loom

结果：容量条件满足，但输出 loom.long_float 诊断。每条浮线诊断明确标记正／反面、经／纬方向及起始交点，因此不会漏掉跨首尾的长浮线；示例内置结果断言。

源文件：[examples/loom/main.mbt](examples/loom/main.mbt)。这只是逻辑预检，不表示真实织机或织物经过安全认证。

### 示例三：设计工具把手绘交织图变成踩踏草稿

输入：4×4 二值平纹网格。运行：

    moon run examples/reconstruct

结果：按相同经向列分组得到 2 个综框，用 2 个直接踏板复原交织图；断言重建前后差异为 0，并导出 moonweave/1 JSON。

源文件：[examples/reconstruct/main.mbt](examples/reconstruct/main.mbt)。这里最小化的是固定交织图所需的综框数；直接踏板方案仅保证可行，不声称踏板数全局最优。

## 命令行

    moon run cmd/moonweave -- help
    moon run cmd/moonweave -- plain 2 2
    moon run cmd/moonweave -- twill 2 2 report
    moon run cmd/moonweave -- satin 5 2 json
    moon run cmd/moonweave -- twill 2 2 svg

生成器命令带两个整数参数；最后可选 grid／json／svg／report，默认 grid。json 和 grid 命令的第一个参数是**文档内容而非文件路径**。例如 Python subprocess 可以可靠地把读取的文件文本作为单独参数传递，避免 shell 引号歧义。CLI 不主动读取文件、联网或控制硬件。失败会输出稳定错误码并以非零状态结束；运行时可能同时打印 panic 栈。

保存 SVG 时请使用 UTF-8 重定向（Windows PowerShell 5 应使用 Out-File -Encoding utf8；其可能写 BOM）。报告是 JSON，包含前后面周期浮线、最小重复单元和纱线正反面转换次数。

## 库 API 与数据约定

在调用方 moon.pkg 导入 `chenliyi-cly/moonweave` 并命名 @weave，示例展示完整用法。

|能力|API|约定|
|---|---|---|
|验证草稿|draft|综框和踏板 ID 从 1 开始；去重／越界错误不静默修复|
|踩踏模拟|from_treadles|多个踏板提升综框取并集；下降式一次性取补集|
|交织图|drawdown|[pick][warp]；true 是正面经纱在上|
|浮线|floats / periodic_floats|有限边界／周期边界；back=true 切换反面|
|织机检查|check_loom|容量、全开／全闭交织、未用综框、长浮线／不交织纱线|
|生成|plain / twill / satin|缎纹步长须与综框数互质且非相邻|
|变换|other_face / reverse_warp / reverse_picks / shift|有等价性与双次变换测试|
|采样|tile / crop / reduce_repeat|有限裁剪不自动成为合理周期|
|反推与比较|from_drawdown / direct_tieup / differences|精确图样反推；显式拒绝容量不足／尺寸不同|
|交换／展示|read_json / write_json / read_grid / write_grid / svg|版本化 JSON、自定义网格、纯 SVG|

FloatRun.thread 与 start 均从 0 开始；Warp 时为经纱索引及投纬起点，Weft 时为纬纱索引及经向起点。PeriodicFloat.wraps 表示跨接缝；unbounded 表示整条周期纱线不发生交织，此时 length 仅为一个周期长度，不能解释为有限最大浮长，而且不受最小阈值过滤。

Finding.pick/thread 统一为从 0 开始的投纬／经纱交点；-1 表示不适用。shaft 单独保存从 1 开始的综框 ID。浮线报告还有 direction 和 back，其余诊断为 null。更完整定义见 [docs/algorithms.md](docs/algorithms.md)。

## 边界与不支持的范围

- 1–64 个综框；经纱、投纬各 1–2048；最多 262144 个交点；限制在乘法／大数组分配之前检查。
- JSON ≤1048576 个 UTF-16 code units、嵌套 ≤8；字段必须为 schema/shafts/threading/lifts，版本为 moonweave/1；ID 拒绝小数。重复 JSON 键遵循 core 解析器的后值覆盖规则，调用方应避免歧义重复键。
- SVG ≤16384 个交点，单格 1–64；颜色只接受 #RRGGBB，无外部资源和脚本。
- 不支持 WIF 读写（包括部分 WIF），不宣称任何 WIF 标准兼容；不做机械驱动、材料参数仿真、结织／针织、全局最优多踏板合成或生产安全认证。
- 浮长用“交点个数”而不是毫米；是否可织还依赖线材、张力、密度及具体织机。

## 实现质量与复现

| 指标 | 验证内容 | 证据 |
|---|---|---|
| 27 个命名测试 | 草稿、浮线、反推、格式与错误处理 | `moon test` |
| 512 张二值图 | 穷举全部 3×3 图样，反推后交点一致，综框数等于不同列签名数 | [reconstruct_test.mbt](reconstruct_test.mbt) |
| 510 个周期序列 | 穷举长度 1–8 的二值序列，暴露交点恰好覆盖一次 | [periodic_wbtest.mbt](periodic_wbtest.mbt) |
| 512 张图 × 2 个面 | 与独立逐格遍历算法对照周期浮线，检查经纬方向及定位 | [robustness_test.mbt](robustness_test.mbt) |
| 262144 个交点 | 接受上限内输入，拒绝超过资源预算的图样 | [robustness_test.mbt](robustness_test.mbt) |
| 4 个运行目标、3 个示例 | 构建、测试、示例及 CLI JSON/SVG 输出与错误退出 | [verify.py](scripts/verify.py) |

以上为正确性和输入边界指标，不是吞吐量或代码覆盖率；样本数是测试内部的数据规模。

```text
python scripts/verify.py --target wasm-gc
python scripts/verify.py --target wasm
python scripts/verify.py --target js
python scripts/verify.py --target native
```

脚本需 Python 3.8+；native 另需 C 编译器。最小综框结论及周期浮线算法见 [算法说明](docs/algorithms.md)。
参见 [贡献指南](CONTRIBUTING.md)、[安全边界](SECURITY.md)、[第三方说明](THIRD_PARTY_NOTICES.md)及 [变更记录](CHANGELOG.md)。
