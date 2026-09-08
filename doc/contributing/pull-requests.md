> 🌐 本文档由 [nodejs/node](https://github.com/nodejs/node) 翻译,英文原版见原项目。
>
> ⚠️ 说明:本文件篇幅超过 10000 字符,此处仅翻译核心章节(Dependencies、完整提交流程、合入要求与关键注意事项)。评审细则、子系统附录等其余章节请参阅[英文原版](https://github.com/nodejs/node/blob/HEAD/doc/contributing/pull-requests.md)。

# Pull Request

* [依赖](#依赖)
* [配置本地环境](#配置本地环境)
* [进行修改的流程](#进行修改的流程)
* [合入(Landing)要求](#合入landing要求)
* [关键注意事项](#关键注意事项)

## 依赖

Node.js 在 _deps/_ 与 _tools/_ 目录中包含若干并非本项目自身的捆绑依赖,
详见 [maintaining dependencies][] 文档。
对这些目录中文件的改动应提交给各自的上游项目。
不要向 Node.js 提交此类补丁,我们无法接受。

拿不准时,请在 [issue 跟踪器](https://github.com/nodejs/node/issues/)发起 issue,或联系某位[项目协作者](https://github.com/nodejs/node/#current-project-team-members)。

Node.js 在 [OpenJS Foundation Slack](https://slack-invite.openjsf.org/) 上有多个频道,比较有用的有:
[#nodejs](https://openjs-foundation.slack.com/archives/CK9Q4MB53)(一般帮助、提问与讨论)和
[#nodejs-core](https://openjs-foundation.slack.com/archives/C019Y2T6STH)(Node.js 核心开发)。

Node.js 还有一个非官方 IRC 频道:[#Node.js](https://web.libera.chat/#node.js)。

## 配置本地环境

开始之前,本地需要安装 `git`。根据操作系统的不同,还需要其他一些依赖,详见 [Building 指南][]。

先在 [GitHub 上 fork](https://github.com/nodejs/node) 本项目,然后在本地克隆你的 fork:

```bash
git clone git@github.com:username/node.git
cd node
git remote add upstream https://github.com/nodejs/node.git
git fetch upstream
```

配置 `git`,让它知道你是谁:

```bash
git config user.name "J. Random User"
git config user.email "j.random.user@example.com"
```

姓名/邮箱可以随意填写,这些元数据只用于在 `AUTHORS` 文件和变更日志中正确归属你的改动。

最佳实践是为开发工作创建本地分支,并直接基于上游默认分支创建:

```bash
git checkout -b my-branch -t upstream/HEAD
```

## 进行修改的流程

Pull request 通常涉及仓库中以下一处或多处的改动:

* `src` 目录中的 C/C++ 代码
* `lib` 目录中的 JavaScript 代码
* `doc/api` 中的文档
* `test` 目录中的测试

修改代码后,务必运行 `make lint`(Windows 上为 `vcbuild.bat lint`),确保改动符合 Node.js 代码风格。

**提交(Commit):** 尽量让每个提交在逻辑上内聚。提交信息第一行应以变更的子系统名作前缀并以祈使动词开头,例如 `net: add localAddress and localPort to Socket`;第二行留空;其余行每行不超过 72 列。修复某个 issue 时在 PR 描述中使用 `Fixes: <完整 issue URL>`,其他引用用 `Refs:`。提交必须包含 `Signed-off-by` 行(可用 `git commit -s` 自动添加),以确认同意[开发者来源证明][Developer Certificate of Origin]。

**变基(Rebase):** 提交后,用 `git rebase`(而不是 `git merge`)与主仓库同步:

```bash
git fetch upstream HEAD
git rebase FETCH_HEAD
```

**测试:** 缺陷修复和新特性必须附带测试。提交前始终运行完整的 Node.js 测试套件。Unix / macOS:

```bash
./configure && make -j4 test
```

Windows:

```powershell
vcbuild test
```

**推送与发起 PR:**

```bash
git push origin my-branch
```

在 GitHub 上发起新 pull request 时会呈现一个模板,请尽量填写完整。若改动超过 5000 行,请参阅[大型 pull request][large pull requests]指南的附加要求。

**讨论与更新:** 收到评审意见后,在本地分支上追加提交并推送,GitHub 会自动更新 PR:

```bash
git add my/changed/files
git commit -s
git push origin my-branch
```

如遇冲突,用 `git rebase` 同步上游改动后,以 `git push --force-with-lease origin my-branch` 推送。**注意:** 强推会抹除历史并增加评审难度,使用前务必清楚风险。

## 合入(Landing)要求

一个 pull request 要被合入,需要获得至少两名 Node.js 协作者的评审与[批准][approved](若 PR 已开放超过 7 天,一名协作者的批准即可),并通过 [CI(持续集成)测试运行][CI (Continuous Integration) test run]。此后只要没有其他贡献者反对,即可合并。

合入时协作者会在 PR 页面留言说明落地为哪些提交。GitHub 可能将 PR 显示为 `Closed`,不要担心,到目标分支上就能看到署你名字的提交。感谢你的贡献!

此外,PR 自提交起须保持开放至少 48 小时,即使已获批准并通过 CI,以便让所有人都有机会发表意见。

## 关键注意事项

* **提交压缩:** 评审过程中一般不要 squash 你自己的提交;合入时可能按逻辑变更压缩为一个提交,PR 页面上的提交历史会原样保留。
* **获得批准:** PR 通过 `LGTM` 评论或 GitHub 的 Approve 按钮获得批准。向分支推送新改动后,需要重新获得批准。
* **CI:** 所有包含代码改动的 PR 都必须在 [https://ci.nodejs.org/][] 上跑 CI。只有协作者和 triager 能发起 CI;通常在批准陆续到位时会有协作者帮你发起,也可以主动请他们代跑。
* **评审文化:** 评审应聚焦最有意义的方面(改动是否合理、是否有明显缺陷、提交信息是否正确),以 _请求_ 而非 _命令_ 的口吻提出修改意见;对琐碎的小建议标注 `Nit:` 并说明不阻塞合入。任何贬低或不尊重贡献者的评审都严重违背[行为准则][Code of Conduct]。
* **非琐碎改动的最短等待时间:** 非琐碎改动要求 PR 至少开放 48 小时;琐碎改动(小的格式修正、文档修复)可在 48 小时窗口内合入。
* **停滞的 PR:** 若 PR 六个月以上无活动,会被打上 `stalled` 标签并触发自动提示,之后可能因不活跃被关闭。

[maintaining dependencies]: ./maintaining/maintaining-dependencies.md
[Building 指南]: ../../BUILDING.md
[Developer Certificate of Origin]: ../../CONTRIBUTING.md#developers-certificate-of-origin-11
[approved]: https://github.com/nodejs/node/blob/HEAD/doc/contributing/pull-requests.md#getting-approvals-for-your-pull-request
[CI (Continuous Integration) test run]: https://github.com/nodejs/node/blob/HEAD/doc/contributing/pull-requests.md#continuous-integration-testing
[Code of Conduct]: https://github.com/nodejs/admin/blob/HEAD/CODE_OF_CONDUCT.md
[large pull requests]: large-pull-requests.md
[https://ci.nodejs.org/]: https://ci.nodejs.org/
