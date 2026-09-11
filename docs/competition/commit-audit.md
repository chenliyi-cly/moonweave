# MoonWeave 有效提交审计

审计日期：2026-09-11。审计基线：1ae37507bb97efa5453b8868cc56bf9feefb6e03。基线原始 21 条，**保守有效 20 条**。

将每个历史 commit 用 git archive 解出独立目录，逐个执行 moon fmt --check、moon check --target wasm-gc --deny-warn、moon test --target wasm-gc，21/21 均返回 0。不是只查看 git log 标题，也不是仅运行最终工作树。原始逐次结果见 commit-replay.json。所有下列实现／测试／文档仍保留在交付树。

|SHA／主题|改动路径|工程目的|历史重放测试|计入|
|---|---|---|---|---|
|`c3f39755c6fec016f7682cc93bfae8b2d7da439f` Implement validated immutable weave drafts and rising-shed drawdown|`.gitignore`、`LICENSE`、`docs/competition/duplicate-check.md`、`draft.mbt`、`draft_test.mbt`、`moon.mod`、`moon.pkg`|验证式不可变草稿、输入边界、交织矩阵|fmt/check=0；Total tests: 2, passed: 2, failed: 0.|是|
|`53406917b1e6f8594f540e277465b351375dc611` Compile multi-treadle tie-ups and normalize sinking sheds|`treadles.mbt`、`treadles_test.mbt`|多踏板并集、下降式补集与错误输入|fmt/check=0；Total tests: 4, passed: 4, failed: 0.|是|
|`e08b690a5ceb7771a7d615a7ce54e056b32d20d1` Analyze face-aware warp and weft floats with exact coordinates|`floats.mbt`、`floats_test.mbt`|有限区间、经纬方向与前后面浮线|fmt/check=0；Total tests: 6, passed: 6, failed: 0.|是|
|`6fae4c5fcf480197d739da83fe307d3c970ef9f8` Detect cyclic float seams and unbounded exposure with exhaustive coverage tests|`periodic.mbt`、`periodic_wbtest.mbt`|周期接缝、无界纱线、1–8位穷举覆盖|fmt/check=0；Total tests: 8, passed: 8, failed: 0.|是|
|`6d814fa70d47d7160833587ddea7f48fc1bfa0be` Validate loom capacity and report closed sheds and unbound threads|`loom.mbt`、`loom_test.mbt`|织机容量、闭合梭口、未用综框诊断|fmt/check=0；Total tests: 10, passed: 10, failed: 0.|是|
|`539fb4bfe06d823c54bf9b7747f44a124962f66c` Generate bounded plain twill and coprime satin drafts|`recipes.mbt`、`recipes_test.mbt`|三种可织逻辑生成器与互质缎纹验证|fmt/check=0；Total tests: 12, passed: 12, failed: 0.|是|
|`38e1b66243d3d4cd13766a1e95612d0511124183` Transform fabric faces and repeat origins with simulation invariants|`transform.mbt`、`transform_test.mbt`|换面、反序、相位移动及对合性质|fmt/check=0；Total tests: 13, passed: 13, failed: 0.|是|
|`bc5a778e5981764f2e488dae1fb60fa0cbbc8b13` Tile and crop finite fabric samples with overflow-safe resource limits|`tile.mbt`、`tile_test.mbt`|溢出安全的重复／裁剪和模拟一致性|fmt/check=0；Total tests: 14, passed: 14, failed: 0.|是|
|`be1ce35dffc7d15b10cf4fbd7a6ceadaad4d3f97` Find and reduce minimal axis-aligned fabric repeats|`repeat.mbt`、`repeat_test.mbt`|基于交织图的最小重复单元|fmt/check=0；Total tests: 15, passed: 15, failed: 0.|是|
|`ec120f2962e6bbb24f031a30f62b321e17109939` Infer minimum shaft groups from drawdown with exhaustive roundtrip tests|`reconstruct.mbt`、`reconstruct_test.mbt`|列签名分组、512图穷举与容量反例|fmt/check=0；Total tests: 17, passed: 17, failed: 0.|是|
|`85fcfa60b927f20e5e378b641de3e8d438056b6c` Synthesize feasible direct tie-ups with explicit pedal capacity failures|`synthesis.mbt`、`synthesis_test.mbt`|预算约束下可复原的直接踏板方案|fmt/check=0；Total tests: 18, passed: 18, failed: 0.|是|
|`20ee9ff71d7a72de914b2d94bb848bf639aa1e7d` Compare fabric intersections and measure yarn binding transitions|`compare.mbt`、`compare_test.mbt`|交点差异及有限／周期交织转换统计|fmt/check=0；Total tests: 19, passed: 19, failed: 0.|是|
|`ec36c0e5834f5bfdaff4703806eb74606cf29396` Add bounded versioned JSON interchange with strict field and integer validation|`exchange.mbt`、`exchange_test.mbt`|版本化JSON、数值与字段／资源验证|fmt/check=0；Total tests: 20, passed: 20, failed: 0.|是|
|`681d3709e985cd79408065b958146c38097510c0` Import and export hand-editable interlacement grids with strict dimensions|`grid.mbt`、`grid_test.mbt`|严格二值网格输入及往返输出|fmt/check=0；Total tests: 21, passed: 21, failed: 0.|是|
|`0eabaa376bfcf5b78abdaef06cc895c4eef1957c` Render bounded standalone SVG drawdowns with injection-safe palette validation|`svg.mbt`、`svg_test.mbt`|安全色板、尺寸受限的独立SVG|fmt/check=0；Total tests: 22, passed: 22, failed: 0.|是|
|`19c7fddf3fb7a1e1e5978beebb999c4ed1f63521` Expose pure CLI dispatch and executable recipe import render and analysis commands|`cmd/moonweave/main.mbt`、`cmd/moonweave/moon.pkg`、`command.mbt`、`command_test.mbt`|纯命令分发及薄执行入口／错误协议|fmt/check=0；Total tests: 23, passed: 23, failed: 0.|是|
|`07719712136b042d2b79f123852c0ee141ce2638` Harden Unicode numeric and resource boundaries with independent float oracle tests|`loom.mbt`、`robustness_test.mbt`、`svg.mbt`|新增独立oracle、硬资源及Unicode边界回归|fmt/check=0；Total tests: 26, passed: 26, failed: 0.|是|
|`1489cd8d06b873ce42f8ecf0a9ddb36ab47e86bb` Provide executable Chinese plain weave loom diagnostics and reconstruction examples|`examples/loom/main.mbt`、`examples/loom/moon.pkg`、`examples/plain/main.mbt`、`examples/plain/moon.pkg`、`examples/reconstruct/main.mbt`、`examples/reconstruct/moon.pkg`|三个独立真实使用场景及程序断言|fmt/check=0；Total tests: 26, passed: 26, failed: 0.|是|
|`c0da095dd74112efd6437018f6bf7e8f7b01f3f3` Make loom findings actionable with explicit faces yarn directions and grid coordinates|`location_test.mbt`、`loom.mbt`|修复此前诊断字段语义与坐标（保守排除）|fmt/check=0；Total tests: 27, passed: 27, failed: 0.|否|
|`1c992acd4d1a2b8c11b7d1dc2e9c87834e50f587` Enforce multi-target CI with runnable examples process failures and serialized output checks|`.github/workflows/ci.yml`、`scripts/verify.py`|四目标CI和真实进程／JSON／SVG验收|fmt/check=0；Total tests: 27, passed: 27, failed: 0.|是|
|`1ae37507bb97efa5453b8868cc56bf9feefb6e03` Document Chinese usage examples algorithm guarantees public API and responsible AI provenance|`AI_USAGE.md`、`CHANGELOG.md`、`CONTRIBUTING.md`、`README.md`、`SECURITY.md`、`THIRD_PARTY_NOTICES.md`、`cmd/moonweave/pkg.generated.mbti`、`docs/algorithms.md`、`examples/loom/pkg.generated.mbti`、`examples/plain/pkg.generated.mbti`、`examples/reconstruct/pkg.generated.mbti`、`pkg.generated.mbti`|可操作中文教程、接口与算法界限、许可证及AI说明|fmt/check=0；Total tests: 27, passed: 27, failed: 0.|是|

第 19 条修正自己前面实现的坐标／面标记，虽然有价值且测试通过，但为避免将修补链用来增加阈值，保守排除。第 17 条计入的依据是新增独立 oracle、穷举验证与资源边界，而非仅修两处错误。文档提交计入一次，不把其中多份说明分别凑数。

本审计及后续纯发布状态／审计材料提交不计入上述 20 条；最终原始总数可增加，保守有效数不因这些维护提交增加。20 是参与者 skill 的交付阈值，不是官方章程的最低提交数，也不保证初审通过。旧 MoonCSP 的提交未计入。

完整验收：scripts/verify.py 在 wasm-gc、wasm、js 本地通过；27 个命名测试、3 个断言示例、CLI 非零退出与序列化验收。native 本地严格静态检查通过，编译运行须以 GitHub Actions 结果为准。

## 发布阶段兼容性说明
首次 Linux CI 在 0.10.12 格式器检查失败，历史重放使用的是 0.10.4，二者不能混称同一验证。后续格式／StringBuilder API 适配和扩词查重材料属于发布维护，不增加保守有效提交数；未关闭 fmt 或 deny-warn。最终验收以 0.10.12 上再次执行的多目标脚本与对应 CI 为准。
