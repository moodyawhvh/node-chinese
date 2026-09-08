> 🌐 本文档由 [nodejs/node](https://github.com/nodejs/node) 翻译,英文原版见原项目。

# 参与 Node.js 贡献

> \[!TIP]
> 第一次参与贡献?请阅读我们的[新人贡献者指南](./doc/contributing/first-contributions.md),里面有实用技巧和常见问题解答。

对 Node.js 的贡献包括:编写代码、撰写文档、回答用户问题、维护项目基础设施,以及为各类 Node.js 用户发声。

Node.js 项目欢迎任何人以善意与其他贡献者和社区合作并做出的所有贡献。没有微不足道的贡献,每一份贡献都值得珍视。

Node.js 项目采用开放的治理模式。做出重要且有价值贡献的个人会被吸纳为协作者(Collaborator),并获得项目的提交权限。详见 [GOVERNANCE.md](./GOVERNANCE.md) 文档。

## 目录

* [行为准则](#行为准则)
* [Issue](#issue)
* [Pull Request](#pull-request)
* [自动化与机器人](#自动化与机器人)
* [AI 使用政策与准则](#ai-使用政策与准则)
* [开发者来源证明 1.1](#开发者来源证明-11)

## [行为准则](./doc/contributing/code-of-conduct.md)

Node.js 项目有一份[行为准则](https://github.com/nodejs/admin/blob/HEAD/CODE_OF_CONDUCT.md),所有贡献者都必须遵守。

详见[行为准则相关政策说明](./doc/contributing/code-of-conduct.md)。

## [Issue](./doc/contributing/issues.md)

* [寻求一般性帮助](./doc/contributing/issues.md#asking-for-general-help)
* [讨论非技术话题](./doc/contributing/issues.md#discussing-non-technical-topics)
* [提交缺陷报告](./doc/contributing/issues.md#submitting-a-bug-report)
* [分诊缺陷报告](./doc/contributing/issues.md#triaging-a-bug-report)

## [Pull Request](./doc/contributing/pull-requests.md)

Pull Request 是对 `nodejs/node` 仓库中的代码、文档、依赖和工具进行具体修改的方式。
非协作者 Contributors 同时最多只能有 10 个处于打开状态的 pull request。

* [依赖](./doc/contributing/pull-requests.md#dependencies)
* [配置本地环境](./doc/contributing/pull-requests.md#setting-up-your-local-environment)
* [进行修改的流程](./doc/contributing/pull-requests.md#the-process-of-making-changes)
* [评审 Pull Request](./doc/contributing/pull-requests.md#reviewing-pull-requests)
* [大型 Pull Request](./doc/contributing/large-pull-requests.md)
* [注意事项](./doc/contributing/pull-requests.md#notes)

## 自动化与机器人

非 Node.js 项目管理的自动化工具或机器人,在与本仓库交互之前,必须由其所有者在
[nodejs/admin](https://github.com/nodejs/admin) 中发起 issue 并获得明确授权。

未经 Node.js 协作者授权的自动化行为(包括 Issue、评论、Pull Request 和 Review),
其自动化账号及所有者可能被立即执行治理措施,且不会另行通知。

## [AI 使用政策与准则](./doc/contributing/ai-guidelines.md)

Node.js 要求贡献者理解并对他们提出的每一处修改负全责。包含贡献者本人未曾理解、测试和验证过的 AI 生成代码的 pull request,很可能不经评审直接关闭。

详见 [AI 使用政策与准则说明](./doc/contributing/ai-guidelines.md)。

## 开发者来源证明 1.1

```text
By making a contribution to this project, I certify that:

 (a) The contribution was created in whole or in part by me and I
     have the right to submit it under the open source license
     indicated in the file; or

 (b) The contribution is based upon previous work that, to the best
     of my knowledge, is covered under an appropriate open source
     license and I have the right under that license to submit that
     work with modifications, whether created in whole or in part
     by me, under the same open source license (unless I am
     permitted to submit under a different license), as indicated
     in the file; or

 (c) The contribution was provided directly to me by some other
     person who certified (a), (b) or (c) and I have not modified
     it.

 (d) I understand and agree that this project and the contribution
     are public and that a record of the contribution (including all
     personal information I submit with it, including my sign-off) is
     maintained indefinitely and may be redistributed consistent with
     this project or the open source license(s) involved.
```
