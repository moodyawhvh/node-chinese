> 🌐 本文档由 [nodejs/node](https://github.com/nodejs/node) 翻译,英文原版见原项目。

# Issue

* [寻求一般性帮助](#寻求一般性帮助)
* [讨论非技术话题](#讨论非技术话题)
* [提交缺陷报告](#提交缺陷报告)
* [分诊缺陷报告](#分诊缺陷报告)

## 寻求一般性帮助

由于 `nodejs/node` 仓库的活跃度非常高,关于使用 Node.js 的问题或一般性求助请求,请前往 [Node.js help 仓库][]提出。

## 讨论非技术话题

非技术话题(如知识产权与商标)的讨论,请提交到[技术指导委员会(TSC)仓库][]。

## 提交缺陷报告

在 `nodejs/node` 的 issue 跟踪系统中新建 issue 时,用户会看到一组 issue 模板供选择。如果你认为自己发现了 Node.js 的一个缺陷,请尽可能完整地填写 `Bug Report` 模板。答不上每个细节也不要紧,能填多少填多少即可。

为了正确评估报告,我们最需要两条信息:一是你所观察到的行为的描述,二是一个可供我们在本地复现问题的简单测试用例。如果无法复现问题,我们就无从修复。

为了排除用户态代码引入缺陷的可能性,测试用例应尽量做到_只_使用 Node.js API。如果缺陷只在使用某个特定用户态模块时出现,那么很可能要么 (a) 该模块本身有缺陷,要么 (b) Node.js 的某些变动导致该模块失效。

参见[如何创建最小、完整、可验证的示例](https://stackoverflow.com/help/mcve)。

## 分诊缺陷报告

issue 提交后,围绕它展开讨论是很常见的。有些贡献者可能对 issue 持不同看法,包括观察到的行为究竟算是缺陷还是特性。这种讨论是流程的一部分,应当保持聚焦、有益且专业。

协助分诊 issue(在 core 与 help 仓库中)的目标是减少 issue 积压、保持 issue 跟踪系统的健康,同时为新成员提供另一条有意义的参与和贡献途径。

任何对 Node.js 编程和本项目的 GitHub 组织有合理了解、并为项目做过若干贡献(在 issue 或 PR 下评论)的人,都可以申请成为 triager。在本项目的 README.md 上发起一个 PR,内容包括:i) 申请被添加为 triager 的请求,ii) 想成为 triager 的动机,iii) 承诺阅读、理解并遵守项目的[行为准则](https://github.com/nodejs/admin/blob/HEAD/CODE_OF_CONDUCT.md)。

triager 角色可以执行最常见的分诊操作,例如打标签、关闭/重开/指派 issue。有关角色与权限的更多信息,参见["组织所拥有的仓库的权限级别"](https://docs.github.com/en/github/setting-up-and-managing-organizations-and-teams/repository-permission-levels-for-an-organization#permission-levels-for-repositories-owned-by-an-organization)。

在分诊 issue 和 PR 时:

* 保持耐心与同理心,尤其是对第一次参与贡献的人。
* 对垃圾信息或恶意捣乱零容忍:不与其互动,直接关闭 issue,并将该用户举报到内容治理仓库。
* 如果无法复现某个 issue,请留言索要更多信息,并打上 `needs more info` 标签。
* 理想情况下,issue 只应在已修复或已解答(对 PR 而言是已合并)后关闭。过早关闭 issue(或 PR)在报告者/作者看来可能显得敷衍。关闭 issue/PR 时请务必说明原因。

[Node.js help 仓库]: https://github.com/nodejs/help/issues
[技术指导委员会(TSC)仓库]: https://github.com/nodejs/TSC/issues
