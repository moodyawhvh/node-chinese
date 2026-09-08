> 🌐 本文档由 [nodejs/node](https://github.com/nodejs/node) 翻译,英文原版见原项目。

# 如何为 Node.js 项目编写文档

本文档针对部署到 [nodejs.org/en/docs][] 的 Node.js API 文档,是关于如何编写和更新这类文档的通用参考。

## 风格指南

有关如何编写或更新 Node.js 文档的风格指南,请参阅 [doc/README][] 文档。

## 构建

有若干命令可用于在本地构建和查看文档,最简单的一个是:

```bash
make docserve
```

该命令会构建文档、启动一个本地服务器,并给你一个 URL,在浏览器中打开即可查看构建好的文档。

更多构建选项请参阅[文档构建][building-the-documentation]文档。

关于构建文档所用工具链的更多细节,请参阅 [API 文档工具链][]文档。

## Lint 与格式化

要确保你的改动通过 lint 检查,请运行以下命令:

```bash
make lint-md
```

[API 文档工具链]: ./api-documentation.md
[building-the-documentation]: ../../BUILDING.md#building-the-documentation
[doc/README]: ../../doc/README.md
[nodejs.org/en/docs]: https://nodejs.org/en/docs/
