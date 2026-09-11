# 开发与复核

1. 在独立 checkout 开发，不修改全局 Git 身份。本次参赛提交归属于 chenliyi-cly；不伪造或代记他人贡献。若以后有真实外部贡献，应如实保留，不为保持“唯一贡献者”改写历史。
2. 新功能必须给出明确数据语义、边界和至少一个反例；修改交织／浮线算法需保留穷举和 oracle 测试。
3. 执行 moon fmt，然后分别运行 python scripts/verify.py --target wasm-gc / wasm / js / native。native 需要本地 C 编译器，不能把 moon check 当成 native 编译运行。
4. 检查 moon info 产生的公共接口 diff，公共语义变化同步修改 README、docs/algorithms.md 和 CHANGELOG。
5. 只提交可解释的完整功能或修复；不要提交 _build、凭据、申报个人联系方式或空 commit。不要为了凑数拆成占位文档／格式提交。
6. CI 必须通过真实示例、命令行错误退出和多目标测试。发布前复核公开身份、实际贡献映射、许可证、版本、干净工作树、标签与 CI 提交一致性。

项目采用 MoonBit 小型单包结构：按 draft/treadles/floats/reconstruct 等领域文件划分；cmd 为薄进程入口，examples 是用户路径。可恢复输入错误返回 Result，不将错误输入当成功结果。
