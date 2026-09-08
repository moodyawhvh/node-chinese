> 🌐 本文档由 [nodejs/node](https://github.com/nodejs/node) 翻译,英文原版见原项目。

# 提交队列(Commit Queue)

_一句话概括:给 pull request 打上 `commit-queue` 标签,即可请求队列将其合入。_

Commit Queue 通过 GitHub Actions 将合入流程自动化,从而简化落地(landing)过程。一旦 pull request 处于[作者就绪][author ready]状态且当前 CI 通过,协作者即可为其打上 `commit-queue` 标签将其加入合入队列。打标签前不需要第二次批准。

队列通过 `@node-core/utils` 检查就绪条件,包括从 pull request 发起时起算的必要等待时间:

* 获得至少两个批准的 pull request 必须开放满 48 小时。
* 只有一个批准的 pull request 必须开放满七天。
* 按规范获得批准的[快速通道 pull request][fast-track pull requests]没有最短等待时间。

如果唯一未满足的条件是等待时间,队列会保留 `commit-queue` 标签并稍后重试。对于加入队列已超过两天、仍在等待第二次批准的 pull request,队列还会打上 `lacks-second-approval` 标签。只要其他条件仍然满足,再获得一个批准即可使其进入下一轮队列执行。当队列移除 `commit-queue` 时会自动移除 `lacks-second-approval`,协作者无需手动处理。

出现硬性失败时,队列会移除 `commit-queue`、打上 `commit-queue-failed`,并发表评论说明可操作的失败原因和重试方法。要解决失败,移除 `commit-queue-failed` 并重新打上 `commit-queue` 即可重试。

要让 Commit Queue 将 pull request 的所有提交压缩(squash)为第一个提交,打上 `commit-queue-squash` 标签。
要让 Commit Queue 以保留多个提交的方式合入 pull request,打上 `commit-queue-rebase` 标签。使用该选项时,请确保每个提交都自成一体,即每个提交都能通过全部测试。

实现在 `commit-queue.yml` 和 `commit-queue.sh` 中。

## 当前限制

以下是提交队列目前已知的一些限制:

1. pull request 中的所有提交必须符合提交信息规范,或者是有效的
   [`fixup!`](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---fixupamendrewordltcommitgt)
   提交(可由 [`--autosquash`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---autosquash)
   选项正确处理)。
2. 自 PR 最后一次修改以来,必须有一次 CI 运行成功。
3. 自最后一次修改以来,必须有协作者批准该 PR。
4. 只检查 Jenkins CI 和 GitHub Actions(V8 CI 和 CITGM 会被忽略)。
5. PR 必须以 `main` 分支为目标(面向其他分支的 PR,例如回移 backport PR,会被忽略)。

[author ready]: ./collaborator-guide.md#author-ready-pull-requests
[fast-track pull requests]: ./collaborator-guide.md#waiting-for-approvals
