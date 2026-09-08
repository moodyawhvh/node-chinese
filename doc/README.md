> 🌐 本文档由 [nodejs/node](https://github.com/nodejs/node) 翻译,英文原版见原项目。

# Node.js 文档风格指南

本指南提供了清晰简洁的说明,帮助你为 Node.js 社区编写结构良好、可读性强的文档。内容涵盖组织方式、拼写、格式等方面,确保所有文档保持一致性与专业性。

## 目录

1. [通用准则](#通用准则)
2. [写作风格](#写作风格)
3. [标点符号](#标点符号)
4. [文档结构](#文档结构)
5. [API 文档](#api-文档)
6. [代码块](#代码块)
7. [格式化](#格式化)
8. [产品与项目命名](#产品与项目命名)

***

## 通用准则

### 文件命名

* **Markdown 文件:** 使用 `lowercase-with-dashes.md`(小写加连字符)格式。
  * 仅当下划线属于主题名称的一部分时才使用下划线(例如 `child_process`)。
  * 部分文件(如顶层 Markdown 文件)可以是例外。

### 文本换行

* 文档每行控制在 120 个字符以内换行,以提升可读性并利于版本控制。

### 编辑器配置

* 遵循 `.editorconfig` 中规定的格式化规则。
  * 部分编辑器可安装[插件][plugin]来强制执行这些规则。

### 测试文档

* 使用 `make test-doc -j` 或 `vcbuild test-doc` 验证文档改动。

***

## 写作风格

### 拼写与语法

* **拼写:** 使用[美式拼写][US spelling]。(译注:中文文档不适用,此处指英文原文应遵循的规范。)
* **语法:** 使用清晰、简洁的语言,避免不必要的行话。

### 逗号

* **序列逗号:** 为清晰起见使用[序列逗号][serial commas]。
  * 示例:_apples, oranges<b>,</b> and bananas_

### 人称代词

* 避免使用第一人称代词(_I_、_we_)。
  * 例外:使用 _we recommend foo_ 而不是 _foo is recommended_。

### 性别中立用语

* 使用性别中立的代词和复数名词。
  * 可以:_they_、_their_、_them_、_folks_、_people_、_developers_
  * 不可以:_his_、_hers_、_him_、_her_、_guys_、_dudes_

### 术语

* 使用精确的技术术语,避免口语化表达。
* 专用术语或缩写首次出现时应给出定义。

***

## 标点符号

### 句末标点

* 如果括号或引号内的内容是一个完整的子句,标点放在括号/引号内。
* 如果只是子句的片段,标点放在括号/引号外。

### 引号

* 直接引语使用双引号。
* 引号中的引语使用单引号。

### 冒号与分号

* 使用冒号引出列表或解释说明。
* 使用分号连接关系紧密的独立子句。

***

## 文档结构

### 标题

* 文档以一级标题(`#`)开头。
* 使用后续层级的标题(`##`、`###` 等)按层次组织内容。

### 链接

* 优先使用引用式链接(`[a link][]`)而非行内链接(`[a link](http://example.com)`)。

### 列表

* 无序列表使用圆点,有序列表使用编号。
* 列表项的结构应保持平行一致。

### 表格

* 使用表格清晰地呈现结构化信息,并确保表格在纯文本下也可读。

***

## API 文档

### YAML 注释

* 及时更新与 API 关联的 YAML 注释,尤其是在引入或废弃某个 API 时。

### 用法示例

* 为每个函数提供用法示例或指向示例的链接。

### 参数说明

* 清楚地描述参数与返回值,包括类型和默认值。
  * 示例:
    ```markdown
    * `byteOffset` {integer} Index of first byte to expose. **Default:** `0`.
    ```

***

## 代码块

### 语言标注围栏

* 代码块使用带语言标注的围栏(例如 ` ```js `)。

  * **信息字符串:** 从下列列表中选用合适的信息字符串:

    | 语言             | 信息字符串   |
    | ---------------- | ------------ |
    | Bash             | `bash`       |
    | C                | `c`          |
    | CommonJS         | `cjs`        |
    | CoffeeScript     | `coffee`     |
    | 终端会话         | `console`    |
    | C++              | `cpp`        |
    | Diff             | `diff`       |
    | HTTP             | `http`       |
    | JavaScript       | `js`         |
    | JSON             | `json`       |
    | Markdown         | `markdown`   |
    | EcmaScript       | `mjs`        |
    | Powershell       | `powershell` |
    | R                | `r`          |
    | 纯文本           | `text`       |
    | TypeScript       | `typescript` |

  * 未列出的语言,在其语法规则加入 [`remark-preset-lint-node`][] 之前,使用 `text`。

### 代码注释

* 在代码示例中使用注释解释复杂逻辑。
* 遵循相应语言的标准注释风格。

***

## 格式化

### 字符转义

* 对下划线、星号和反引号使用反斜杠转义:`\_`、`\*`、`` \` ``。

### 命名约定

* **构造函数:** 使用 PascalCase。
* **实例:** 使用 camelCase。
* **方法:** 用括号表示方法:写 `socket.end()` 而不是 `socket.end`。

### 函数参数与返回值

* **参数:**
  ```markdown
  * `name` {type|type2} Optional description. **Default:** `value`.
  ```
  示例:
  ```markdown
  * `byteOffset` {integer} Index of first byte to expose. **Default:** `0`.
  ```
* **返回值:**
  ```markdown
  * Returns: {type|type2} Optional description.
  ```
  示例:
  ```markdown
  * Returns: {AsyncHook} A reference to `asyncHook`.
  ```

***

## 产品与项目命名

<!-- lint disable prohibited-strings remark-lint-->

### 官方写法

* 产品和项目名称使用官方大小写形式。
  * 可以:JavaScript、Google's V8
  * 不可以:Javascript、Google's v8

### Node.js 的指称

* 使用 _Node.js_,而不是 _Node_、_NodeJS_ 或类似变体。
  * 指可执行文件时,_`node`_ 是可以接受的。

### 版本指称

* 正文中使用 _Node.js_ 加版本号,版本号不要加 _v_ 前缀。
  * 可以:_Node.js 14.x_、_Node.js 14.3.1_
  * 不可以:_Node.js v14_

<!-- lint enable prohibited-strings remark-lint-->

本指南未涉及的主题,请查阅 [Microsoft Writing Style Guide][]。

***

[Microsoft Writing Style Guide]: https://learn.microsoft.com/en-us/style-guide/welcome/
[US spelling]: https://learn.microsoft.com/en-us/style-guide/word-choice/use-us-spelling-avoid-non-english-words
[`remark-preset-lint-node`]: https://github.com/nodejs/remark-preset-lint-node
[plugin]: https://editorconfig.org/#download
[serial commas]: https://learn.microsoft.com/en-us/style-guide/punctuation/commas
