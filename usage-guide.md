# Claude Code 技能使用指南

## 技能概述

Claude Code技能允许你通过OpenClaw调用Claude Code进行各种代码开发任务。Claude Code是一个强大的AI编码助手，可以处理复杂的开发工作流。

## 安装和设置

### 1. 安装Claude Code

```bash
# macOS/Linux/WSL
curl -fsSL https://claude.ai/install.sh | bash

# 或使用Homebrew
brew install --cask claude-code

# Windows PowerShell
irm https://claude.ai/install.ps1 | iex
```

### 2. 验证安装

```bash
claude --version
```

### 3. 首次登录

```bash
claude
```
首次运行时会提示登录，需要Claude订阅或Anthropic控制台账户。

## 技能调用方式

### 方式1：直接调用（推荐）
```
/claude-code [任务描述]
```

### 方式2：通过OpenClaw exec工具
```bash
exec "claude '[任务描述]'"
```

### 方式3：管道输入
```bash
cat file.txt | claude-code "分析此文件"
```

## 常用任务模式

### 1. 代码解释和理解
```
/claude-code 解释这个函数的逻辑
/claude-code 这个项目是做什么的？
/claude-code 这段代码有什么问题？
```

### 2. 代码编写和生成
```
/claude-code 创建一个用户登录的React组件
/claude-code 编写一个Python函数处理CSV文件
/claude-code 生成一个REST API的TypeScript接口
```

### 3. 代码重构和优化
```
/claude-code 重构这个函数，提高可读性
/claude-code 优化这个循环的性能
/claude-code 将这个类拆分为更小的组件
```

### 4. 错误调试
```
/claude-code 修复这个错误：TypeError: undefined is not a function
/claude-code 为什么这个测试会失败？
/claude-code 分析这个堆栈跟踪
```

### 5. 测试编写
```
/claude-code 为这个模块编写单元测试
/claude-code 添加集成测试覆盖这个功能
/claude-code 编写性能测试
```

### 6. 文档生成
```
/claude-code 为这个API生成OpenAPI文档
/claude-code 编写这个库的使用示例
/claude-code 创建项目README
```

## 高级用法

### 1. 使用特定模型
```bash
# 使用Sonnet模型
claude --model sonnet "复杂任务"

# 使用Opus模型（最强）
claude --model opus "非常重要的工作"
```

### 2. 结构化输出
```bash
# JSON输出，便于脚本处理
claude -p --output-format json "分析代码质量"

# 流式JSON，实时处理
claude -p --output-format stream-json --include-partial-messages "长任务"
```

### 3. 工具限制
```bash
# 只允许读取，不允许修改
claude --tools "Read,Grep,Glob" "安全审查"

# 完全访问
claude --tools "default" "开发任务"
```

### 4. 自定义系统提示
```bash
# 添加特定指令
claude --append-system-prompt "始终使用TypeScript，包含完整类型定义" "编写组件"

# 完全自定义提示
claude --system-prompt "你是一个安全专家，专注于代码安全审查" "审查代码"
```

### 5. 子代理模式
```bash
# 使用Explore代理探索代码库
claude --agent Explore "了解项目结构"

# 使用Plan代理制定计划
claude --agent Plan "设计新功能架构"
```

## 工作流示例

### 示例1：开发新功能

```bash
# 1. 理解需求
claude "我需要一个用户管理系统，包含增删改查功能"

# 2. 设计架构
claude "设计用户管理系统的数据库 schema 和 API 接口"

# 3. 实现代码
claude "实现用户创建的API端点"

# 4. 编写测试
claude "为用户创建API编写单元测试"

# 5. 代码审查
claude "审查这段代码的安全性和最佳实践"
```

### 示例2：重构遗留代码

```bash
# 1. 分析现状
claude "分析这个老代码的问题"

# 2. 制定计划
claude "制定重构计划，分阶段进行"

# 3. 逐步重构
claude "第一阶段：提取重复代码为函数"

# 4. 添加测试
claude "为重构后的代码添加测试"

# 5. 验证结果
claude "运行测试确保重构没有破坏功能"
```

### 示例3：性能优化

```bash
# 1. 性能分析
claude "分析这个函数的性能瓶颈"

# 2. 优化方案
claude "提出性能优化方案"

# 3. 实施优化
claude "实施缓存优化"

# 4. 基准测试
claude "编写性能基准测试"

# 5. 验证改进
claude "比较优化前后的性能"
```

## 集成OpenClaw功能

### 1. 结合文件操作
```bash
# 读取文件并让Claude分析
read "path/to/file.js"
/claude-code 分析这个文件的问题
```

### 2. 结合版本控制
```bash
# 查看git状态
exec "git status"
/claude-code 基于当前更改创建提交消息
```

### 3. 结合项目管理
```bash
# 读取项目文档
read "README.md"
/claude-code 基于README实现缺失的功能
```

## 最佳实践

### 1. 提供充分上下文
- 描述清楚需求
- 提供相关代码片段
- 说明约束条件
- 明确期望输出

### 2. 分步进行
- 复杂任务分解为小步骤
- 每步验证结果
- 逐步迭代改进

### 3. 验证结果
- 运行生成的代码
- 检查编译错误
- 运行测试套件
- 手动测试功能

### 4. 代码审查
- 让Claude审查自己的代码
- 检查安全漏洞
- 验证最佳实践
- 确保代码风格一致

### 5. 文档化
- 要求代码注释
- 生成API文档
- 更新README
- 记录设计决策

## 故障排除

### 1. Claude Code未响应
```bash
# 检查安装
which claude

# 检查版本
claude --version

# 重新安装
curl -fsSL https://claude.ai/install.sh | bash
```

### 2. 权限问题
```bash
# 检查文件权限
ls -la

# 以正确用户运行
sudo -u [username] claude "任务"
```

### 3. 模型限制
```bash
# 尝试不同模型
claude --model sonnet "任务"
claude --model haiku "简单任务"
```

### 4. 上下文限制
```bash
# 限制工具减少上下文
claude --tools "Read,Edit" "任务"

# 分步处理大任务
```

### 5. 网络问题
```bash
# 检查网络连接
ping api.anthropic.com

# 使用代理（如果需要）
export HTTPS_PROXY=http://proxy:port
```

## 性能优化技巧

### 1. 减少上下文大小
- 只提供必要代码
- 使用文件引用而非内联
- 分步骤处理

### 2. 使用合适模型
- 简单任务：Haiku
- 一般任务：Sonnet  
- 复杂任务：Opus

### 3. 缓存结果
- 保存常用代码片段
- 复用已验证的解决方案
- 创建代码模板

### 4. 批量处理
- 一次处理多个相关任务
- 使用脚本自动化
- 创建工作流管道

## 安全注意事项

### 1. 代码审查
- 始终审查生成的代码
- 检查安全漏洞
- 验证输入验证

### 2. 敏感信息
- 不要提交API密钥
- 使用环境变量
- 添加.gitignore

### 3. 依赖管理
- 检查依赖安全性
- 使用固定版本
- 定期更新依赖

### 4. 权限控制
- 最小权限原则
- 限制文件访问
- 使用安全配置

## 扩展和自定义

### 1. 创建自定义技能
参考Claude Code官方文档，创建针对特定工作流的自定义技能。

### 2. 集成MCP服务器
通过Model Context Protocol集成外部工具和数据源。

### 3. 开发插件
创建可共享的插件，扩展Claude Code功能。

### 4. 自动化工作流
使用脚本和钩子自动化重复任务。

---

**提示**：Claude Code技能最适合中等复杂度的编码任务。对于非常复杂的项目，建议分阶段进行，并定期验证结果。