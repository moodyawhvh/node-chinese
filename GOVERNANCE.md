> 🌐 本文档由 [nodejs/node](https://github.com/nodejs/node) 翻译,英文原版见原项目。
>
> ⚠️ 说明:本文件篇幅超过 10000 字符,此处翻译核心章节(Triagers、Collaborators、TSC、协作者提名与共识决策)。TSC 会议纪要细则、提名评审与反对流程的完整细节请参阅[英文原版](https://github.com/nodejs/node/blob/HEAD/GOVERNANCE.md)。

# Node.js 项目治理

* [Triagers](#triagers)
* [协作者(Collaborators)](#协作者collaborators)
* [技术指导委员会(TSC)](#技术指导委员会tsc)
* [协作者提名](#协作者提名)
* [共识决策流程](#共识决策流程)

## Triagers

Triager 负责评估 [nodejs/node][] 与 [nodejs/help][] 仓库中新建的 issue。Node.js triager 的 GitHub 团队是 @nodejs/issue-triage。Triager 被授予 "Triage" GitHub 角色,拥有:

* 为 issue 和 pull request 打标签的权限
* 评论、关闭和重开 issue 与 pull request 的权限

参见:

* [Triager 名单](./README.md#triagers)
* [Triager 指南](./doc/contributing/issues.md#triaging-a-bug-report)

## 协作者(Collaborators)

Node.js 核心协作者维护 [nodejs/node][] GitHub 仓库。对应的 GitHub 团队是 @nodejs/collaborators。协作者拥有:

* [nodejs/node][] 仓库的提交权限
* 访问 Node.js 持续集成(CI)任务的权限

协作者与非协作者都可以对 Node.js 源码提出修改,载体是 GitHub pull request。协作者负责评审并合并(_合入 / land_)pull request。

一个 pull request 需要两名协作者批准才能合入(若 PR 已开放超过 7 天,一名协作者批准即可)。批准意味着该协作者对这一改动承担责任。批准必须来自非改动作者的协作者。

若有协作者反对某项修改,则该修改不能合入。例外是 TSC 投票决定不顾反对予以通过。通常无需动用 TSC:讨论或进一步修改往往能让协作者撤回反对。

参见:

* [协作者名单](./README.md#current-project-team-members)
* [协作者指南](./doc/contributing/collaborator-guide.md)

### 协作者的活动

* 帮助用户和新手贡献者
* 贡献能改进项目的代码与文档
* 评审并评论 issue 与 pull request
* 参与工作组
* 合并 pull request

TSC 可以移除不活跃的协作者,或授予其 _荣休(emeritus)_ 状态。荣休者可以请求 TSC 恢复其活跃状态。

如果一名协作者超过 12 个月没有编写或批准过已合入的提交,则自动转为荣休(并移出活跃协作者名单)。

## 技术指导委员会(TSC)

部分协作者组成技术指导委员会(Technical Steering Committee,TSC)。TSC 对本项目拥有最终权力,涵盖:

* 技术方向
* 项目治理与流程(包括本政策)
* 贡献政策
* GitHub 仓库托管
* 行为准则
* 维护协作者名单

现任 TSC 成员名单见[项目 README](./README.md#current-project-team-members)。

TSC 的运作受 [TSC 章程][TSC Charter]约束。章程的任何修改都需 OpenJS Foundation 跨项目委员会(CPC)批准。

### TSC 会议

TSC 以视频会议形式开会,每年选举一名主席主持会议,并在 YouTube 上公开直播会议。

TSC 会议可包含公开环节与私密环节。私密环节用于讨论敏感话题(如人事问题、安全漏洞或其他机密事项)。私密讨论应尽量避免,TSC 应力求把讨论留在公开环节,但有时私密讨论确有必要。

TSC 议程收录陷入僵局的问题,其目的不是评审或批准所有补丁——补丁的评审与批准在 GitHub 上完成。能由协作者在 GitHub 上做出的决定,应尽量无需召开 TSC 会议。

任何社区成员都可以创建 GitHub issue 提请 TSC 审议某事。若某一问题的共识寻求失败,协作者可以打上 `tsc-agenda` 标签,该问题即进入 TSC 会议议程。

会前主席与 TSC 成员共享议程;TSC 成员也可在会议开始时添加议题。主席和 TSC 均无权否决或移除议题。

TSC 可以邀请他人以非投票身份参加公开或私密环节。公开环节应安排记录人整理纪要,会后经公开 pull request 发布。公开环节预期会被录制并直播或供下载,该预期须在每次会议开始、录制开始前告知全体与会者,与会在被告知后继续参加公开环节即视为同意录制。私密环节仅形成经与会者审阅的讨论摘要,经私密渠道(如 TSC 私密邮件列表)分享给全体 TSC 成员;只有在 TSC 与非 TSC 与会者达成共识时,摘要才可公开。

会议中的一切讨论均视为临时性:无人反对采取某行动,不等于 TSC 认可该行动。若有法定人数的 TSC 投票成员在场,可要求显式表决,无人反对时立即进行;其余投票成员获得通知后 48 小时内无人反对,决定即视为确认。

会外讨论使用 [TSC issue 跟踪器](https://github.com/nodejs/TSC/issues)处理公开事务,私密事项使用 TSC 私密邮件列表。公开 issue 的流程:

* 由一名 TSC 成员发起 issue 说明提案/问题,并 @-提及 @nodejs/tsc。
* 72 小时后,若有两名及以上 TSC 投票成员批准且无人反对,提案即通过。
* 若僵局持续,任一 TSC 成员可将该 issue 加入 TSC 议程,或动议表决。

## 协作者提名

### 谁能提名协作者?

现任协作者可以提名新协作者。

### 理想的被提名人

被提名人应在 Node.js 组织内有重要且有价值的贡献,形式可以是:提交 pull request、评论与评审、发起 issue、参与 Node.js 组织的其他项目/团队/工作组等。

协作者应当是愿意承担不起眼工作的人——因为这是正确的事、因为工作本身令人满足、因为他们在乎 Node.js 及其用户。授予协作者身份,是因为此人在做实际工作,并且大概率会继续做那些需要协作者权限的工作(如发起 CI 任务、评审批准 PR 等)。这通常(但并非总是)是涉及向 `nodejs/node` 仓库提交的工作;例外情况,例如主要维护官网的人,也可能因需要发起 Jenkins CI 任务测试文档工具改动而受益。

需要理解的是,潜在协作者的专业领域、兴趣与技能水平差异可能极大。个人贡献的复杂程度、"精巧度"甚至相对工程水平,都不是决定其是否应成为协作者的首要因素。首要因素是贡献的质量(是否有意义、是否增值、是否遵循成文规范、是否真诚且善意等)、对项目的投入、其判断力是否可信,以及与他人协作的能力。

#### 贡献者的真实性

Node.js 项目不要求贡献者使用法定姓名或提供任何验证身份的个人信息。

恶意行为者试图获取开源项目提交权限以注入恶意代码的情况并不罕见。项目已有多种防范机制,但仍需保持警惕。若对某贡献者的真实性有疑虑,请向 TSC 提出。提名者应采取合理步骤核实被提名人的贡献真实且出于善意。

### 提名新协作者

提名流程:

1. **可选但强烈建议**:在 [nodejs/collaborators 仓库][discussion in the nodejs/collaborators]发起私密讨论,概述被提名人的贡献。
2. **可选但强烈建议**:经过充分等待(如 72 小时),若提名获得支持且无人明确阻止、疑问已解答,则在私密讨论中留言说明将发起公开 issue。
3. **可选但强烈建议**:私下联系被提名人,确认其对此提名无异议。
4. 在 [nodejs/node][] 仓库发起 issue,概述被提名人的贡献,并在 issue 中提及 @nodejs/collaborators 通知其他协作者。

跳过"可选但强烈建议"的步骤不会使提名失效,但若一项对方毫不知情的提名最终被否决,场面会非常尴尬。除非完全确定被提名人能接受公开审视,否则不要跳过这些步骤。

提名在发起一周后无人反对即通过。出现反对时,由 TSC 负责与相关人员协商解决。TSC 可按其常规共识流程,选择推进一项未能自然达成共识的提名,也可在认定反对意见未被充分回应时阻止提名。

#### 如何评审协作者提名

可像评审一个新增功能的 PR 那样评审提名:认可就明说;中立或了解不足可以不参与;认为提名过早或有害,则表达关切。目标是将"守门"降到最低,但不可能为零——协作者身份意味着信任(可发起 CI、行使否决、推送提交等)。不要在提名讨论中纠缠提名流程本身,此类讨论应另开 issue。

显式反对应当是清晰明确的表态,例如"我认为这项提名不应通过"。提出澄清性问题或一般性关切不等同于显式反对,但应在推进提名前尽力解答。反对应尽量搭配积极、具体、明确的改进建议,让被提名人知道如何消除异议。注意:关于提名的全部私密讨论,在被提名人完成 onboarding 后对其可见。

### Onboarding

提名通过后,由一名 TSC 成员为新协作者办理 onboarding。详情见 [onboarding 指南](./onboarding.md)。

## 共识决策流程

TSC 依据 [TSC 章程][TSC Charter]遵循[共识决策(Consensus Seeking)][Consensus Seeking]模型。

[Consensus Seeking]: https://en.wikipedia.org/wiki/Consensus-seeking_decision-making
[TSC Charter]: https://github.com/nodejs/TSC/blob/HEAD/TSC-Charter.md
[discussion in the nodejs/collaborators]: https://github.com/nodejs/collaborators/discussions/categories/collaborator-nominations
[nodejs/help]: https://github.com/nodejs/help
[nodejs/node]: https://github.com/nodejs/node
