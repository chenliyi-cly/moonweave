# MoonWeave 查重与 MoonCSP 驳回复核

复核日期：2026-09-11。遵循本地 moonbit-hackathon-builder 和 osc2026-guide 的项目研究流程；九月规则以 builder 固定资料为准。

## 驳回原因与决策
用户提供的邮件指出 MoonCSP 与 HYF-ai2006/moonsec-headers 的 CSP 功能重合、申报缺少扩展边界；允许于 2026-09-24 前修改材料。直接读取对方 README 和源目录确认其 CSP source/fallback/profile 能力，撤回此前“查重过关”的无条件表述。旧仓库、作者和历史保留，不重写。新项目不宣称已获初审通过。

## 候选矩阵
|候选领域|核心数据与流程|结论|
|---|---|---|
|字幕处理|SRT/WebVTT、时间码、交付质检|MaoDingA/moonpost 0.2.1 直接重叠，排除|
|纠错编码|有限域码字、Reed–Solomon|CAIMEOX/reed_solomon 0.1.0 已有实现，排除|
|CAD STEP|实体引用、STEP 编解码|gmlewis/step 0.1.18、chiooo09/moonbit-ifc 重叠，排除|
|GS1 物流标识|AI 字段、GS1-128|Qlcdsba/moonbit-barcoder 0.2.1 重叠，排除|
|曲线几何|NURBS、B-spline 评价|存在 three-mbt JS NURBS、STEP 曲线实体、symbit 符号接口及 cubic spline，避免相同核心|
|MoonWeave 织造模拟|经纱穿综、提综集合、经纬交织矩阵、周期浮线|选择；不是 CSP、INI 编辑、通用 CAD 或 G-code 轨迹|

## 实際检索与局限
1. 本地 moon search 不存在；没有把失败当作零结果。
2. GET https://mooncakes.io/api-new/v0/modules 返回 HTTP 200，完整数组 2408 条；保留本地快照。按名称、描述、关键词检索 weaving/textile/WIF/drawdown/treadling/liftplan/织造/纺织/织物，零命中。不是全文源码覆盖，不保证未索引包不存在。
3. GitHub repository search: weaving language:MoonBit、textile language:MoonBit、WIF language:MoonBit、treadling language:MoonBit、liftplan language:MoonBit 均零；code search treadling/liftplan language:MoonBit 均零。查询日期同上。
4. web 工具多次无可用正文；以可重复的 GitHub API 与 MoonCakes API 结果为证，不以网页搜索空白为证。
5. 本地永久 registry 的全部内容经程序扫描，对已有项目指纹逐项比较；共享 JSON/CI/矩阵不是同题证据。MoonGCode 的核心是机床运动，MoonINI 的核心是保留语法编辑，MoonPetri 是离散状态可达性，均不承担织造交织/浮线分析。

## 独立边界
用户：织造教学、数字草稿工具、离线织机设置预检的开发者。核心：穿综 + tie-up/treadling 或 liftplan -> 交织矩阵 -> 周期/非周期浮线与织机约束 -> 可复现诊断及图示。不实现 HTTP 安全、纺织硬件控制、布料物理仿真、实时驱动、CAD 几何内核或完整 WIF 标准认证。
结论：在上述已检查范围内未发现直接同题维护项目，选择新建；并非组委会审核结论。重新提交前复核。

## 直接核查的相邻项目
- CAIMEOX/reed_solomon@0.1.0 — https://github.com/CAIMEOX/reed_solomon ; https://mooncakes.io/docs/CAIMEOX/reed_solomon — Reed Solomon error correction implementation in Moonbit
- CMoonBack/computational-geometry@0.2.3 — https://github.com/CMoonBack/Computational-geometry ; https://mooncakes.io/docs/CMoonBack/computational-geometry — computational geometry library in moonbit
- cn-xjr/moongeokit@0.3.0 — https://github.com/cn-xjr/moongeokit ; https://mooncakes.io/docs/cn-xjr/moongeokit — Robust 2D geometry and observable spatial indexing for MoonBit.
- gmlewis/step@0.1.18 — https://github.com/gmlewis/moonbit-step ; https://mooncakes.io/docs/gmlewis/step — Port of https://github.com/tscircuit/stepts to MoonBit
- HYF-ai2006/moonsec-headers@0.1.0 — https://github.com/HYF-ai2006/moonsec-headers.git ; https://mooncakes.io/docs/HYF-ai2006/moonsec-headers — MoonBit native HTTP security header and CSP audit library
- Kai-Junhan/moonbit-motion-lab@0.1.1 — https://github.com/Kai-Junhan/moonbit-motion-lab ; https://mooncakes.io/docs/Kai-Junhan/moonbit-motion-lab — Motion curve toolkit for MoonBit: parameterized curves, cubic Bezier, sampling, diagnostics, and animation value generation
- Lmy271828/moonim@0.2.1 — https://github.com/Lmy271828/moonim ; https://mooncakes.io/docs/Lmy271828/moonim — A mathematical animation engine kernel: bezier geometry, mobject scene graph, typed animation combinators and an SVG backend.
- Luna-Flow/geometry3d@0.5.1 — https://github.com/Luna-Flow/geometry3d ; https://mooncakes.io/docs/Luna-Flow/geometry3d — A small MoonBit 3D geometry foundation with core, view, frontend, TUI, Canvas, and GSAP SVG backend packages built on Luna-Flow/linear-algebra.
- MaoDingA/moonpost@0.2.1 — https://github.com/MaoDingA/moonbitpostqc ; https://mooncakes.io/docs/MaoDingA/moonpost — Pure MoonBit toolkit for subtitles, timecode, creator cleanup, delivery checks, and post-production QC.
- Qlcdsba/moonbit-barcoder@0.2.1 — https://github.com/Qlcdsba/moonbit-barcoder ; https://mooncakes.io/docs/Qlcdsba/moonbit-barcoder — GS1-128 and Code 128 data parser toolkit for MoonBit logistics applications.
