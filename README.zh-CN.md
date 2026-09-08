<div align="center">

# Node.js 中文文档

**[中文翻译版] 开源跨平台 JavaScript 运行时环境**

[![原项目](https://img.shields.io/badge/原项目-nodejs--node-blue?style=flat-square&logo=github)](https://github.com/nodejs/node)
[![微信联系](https://img.shields.io/badge/微信-uaycar-brightgreen?style=flat-square&logo=wechat)](#)

</div>

---

## 项目简介

Node.js 是一个开源、跨平台的 JavaScript 运行时环境。关于 Node.js 的使用说明,请访问 [Node.js 官网](https://nodejs.org)。

Node.js 项目采用[开放治理模式](https://github.com/nodejs/node/blob/main/GOVERNANCE.md),由 [OpenJS 基金会](https://openjsf.org/)提供支持。

贡献者应以协作方式推动项目前进。社区鼓励建设性的意见交换与妥协。[TSC(技术指导委员会)](https://github.com/nodejs/node/blob/main/GOVERNANCE.md#technical-steering-committee) 保留限制或屏蔽反复妨碍、消耗或对其他参与者造成负面影响者的权利。

**本项目有 [行为准则](https://github.com/nodejs/node/blob/main/CODE_OF_CONDUCT.md)。**

## 支持渠道

需要帮助?请查看[获取支持的说明](https://github.com/nodejs/node/blob/main/.github/SUPPORT.md)。

## 发布类型

- **Current(当前版)**:处于积极开发状态。Current 发布的代码位于其主版本号分支(例如 [v22.x](https://github.com/nodejs/node/tree/v22.x))。Node.js 每 6 个月发布一个新的主版本,允许破坏性变更,时间在每年 4 月与 10 月。每年 10 月发布的版本支持周期为 8 个月;每年 4 月发布的版本会在当年 10 月转为 LTS。
- **LTS(长期支持版)**:获得长期支持、聚焦稳定性与安全性的版本。每个偶数主版本都会成为 LTS。LTS 版本先获得 12 个月的 *Active LTS* 支持,再获得 18 个月的 *Maintenance(维护)* 支持。LTS 版本线以字母顺序命名,从 v4 Argon 开始。除特殊情况外不引入破坏性变更或新功能。
- **Nightly(每夜构建)**:由 Current 分支每日构建,供测试尝鲜。

### 下载

- 官方下载页:https://nodejs.org/download/
- 包管理器安装(nvm、Homebrew、apt 等渠道见官方文档)

### 校验二进制

从 nodejs.org 下载的二进制文件可通过 SHA-256 校验和与 SHASUMS 签名文件验证完整性,详见原文档 [Verifying binaries](https://github.com/nodejs/node#verifying-binaries) 章节。

## 从源码构建 Node.js

```bash
# 平台要求与依赖见 BUILDING.md
./configure
make -j4    # 数字可按 CPU 核心数调整
make install
```

支持的平台包括 Linux、macOS、Windows、SmartOS、IBM AIX、FreeBSD 与 Linux on Power。各平台前置依赖与交叉编译细节见 [BUILDING.md](https://github.com/nodejs/node/blob/main/BUILDING.md)。

## 安全

- 发现安全漏洞请按[安全政策](https://github.com/nodejs/node/blob/main/SECURITY.md)私密上报
- 当前发布线的安全发布时间表见官方文档

## 参与贡献

欢迎参与 Node.js 开发!贡献指南见 [CONTRIBUTING.md](https://github.com/nodejs/node/blob/main/CONTRIBUTING.md),新手可从 `good first issue` 标签的问题入手。

## 当前项目团队成员

- **TSC(技术指导委员会)**:负责技术方向与重大决策
- **Collaborators(协作者)**:拥有仓库日常维护权限的贡献者
- **Triagers(分诊员)**:负责问题分类与标签管理
- **发布密钥**:用于验证官方发布签名的公钥列表

## 许可证

Node.js 采用 MIT 许可证发布,仓库同时包含众多第三方组件的许可声明,详见 [LICENSE](https://github.com/nodejs/node/blob/main/LICENSE)。

---

## 联系方式

**代部署 / 定制服务 / 技术咨询 请添加微信:uaycar**

---

本项目为 [nodejs/node](https://github.com/nodejs/node) 的中文翻译版本,所有代码版权归原项目作者所有,遵循其原始许可证。

**如果觉得有用,请给原项目点个 Star!** ⭐
