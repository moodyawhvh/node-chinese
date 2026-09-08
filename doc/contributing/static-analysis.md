> 🌐 本文档由 [nodejs/node](https://github.com/nodejs/node) 翻译,英文原版见原项目。

# 静态分析

本项目使用 Coverity 扫描 Node.js 源码,并报告 C/C++ 代码库中的潜在问题。

被加入 [Node.js coverity 项目][] 的成员,在有新问题报告时可以收到邮件通知,也可以通过 <https://scan9.scan.coverity.com/reports.htm> 查看当前所有问题。

任何协作者都可以通过在 [build][] 仓库发起标题为 `Please add me to coverity` 的 issue 来申请加入 Node.js coverity 项目。拥有管理员权限的 build 工作组成员会核实申请者确实是 nodejs/node 项目仓库[协作者名单][collaborators section]中的现有协作者。验证通过后,申请者会被加入 coverity 项目。

[Node.js coverity 项目]: https://scan.coverity.com/projects/node-js
[build]: https://github.com/nodejs/build
[collaborators section]: https://github.com/nodejs/node#collaborators
