---
name: claude-code
description: 调用Claude Code进行代码开发、调试、重构和自动化任务。当用户需要编写代码、修复bug、重构代码库或自动化开发任务时使用此技能。
disable-model-invocation: true
---

# Claude Code 技能

此技能允许你通过OpenClaw调用Claude Code进行代码开发任务。Claude Code是一个由AI驱动的编码助手，可以读取代码库、编辑文件、运行命令，并与开发工具集成。

## 前置要求

1. **安装Claude Code**：
   ```bash
   # macOS/Linux/WSL
   curl -fsSL https://claude.ai/install.sh | bash
   
   # 或使用Homebrew
   brew install --cask claude-code
   ```

2. **登录Claude Code**：
   ```bash
   claude
   ```
   首次使用时，系统会提示你登录。需要Claude订阅或Anthropic控制台账户。

## 使用方法

### 基本调用
```
/claude-code [任务描述]
```

### 参数说明
- `$ARGUMENTS`：任务描述，可以是任何编码相关的任务
- 支持管道输入：`cat file | claude-code "分析此文件"`

### 示例命令

1. **解释代码**：
   ```
   /claude-code 解释这个项目的结构
   ```

2. **修复bug**：
   ```
   /claude-code 修复登录模块的bug，错误信息是"Invalid credentials"
   ```

3. **编写测试**：
   ```
   /claude-code 为auth模块编写测试，运行它们，并修复任何失败
   ```

4. **重构代码**：
   ```
   /claude-code 重构这个函数以提高可读性
   ```

5. **创建提交**：
   ```
   /claude-code 提交我的更改并附带描述性消息
   ```

## 高级功能

### 1. 使用特定模型
```bash
claude --model claude-sonnet-4-5-20250929 "你的任务"
```

### 2. JSON输出（用于脚本）
```bash
claude -p --output-format json "你的任务"
```

### 3. 限制工具访问
```bash
claude --tools "Bash,Edit,Read" "你的任务"
```

### 4. 自定义系统提示
```bash
claude --append-system-prompt "始终使用TypeScript并包含JSDoc注释" "你的任务"
```

### 5. 在子代理中运行
```bash
claude --agent Explore "你的任务"
```

## 工作流程

### 1. 探索代码库
```bash
# 查看项目结构
claude "解释这个项目的结构"

# 查找特定文件
claude "找到所有包含'login'的文件"
```

### 2. 开发功能
```bash
# 描述功能需求
claude "创建一个用户注册API端点，包含验证和错误处理"

# 迭代开发
claude "添加密码强度验证到注册功能"
```

### 3. 调试和测试
```bash
# 分析错误
claude "修复这个错误：TypeError: Cannot read property 'name' of undefined"

# 编写测试
claude "为这个函数编写单元测试，覆盖边界情况"
```

### 4. 代码审查
```bash
# 审查代码质量
claude "审查这段代码的安全问题和最佳实践"

# 检查性能
claude "分析这个函数的性能瓶颈"
```

## 集成功能

### 1. Git集成
Claude Code可以直接与git配合工作：
- 暂存更改
- 编写提交消息
- 创建分支
- 打开拉取请求

### 2. MCP（Model Context Protocol）
通过MCP，Claude Code可以连接外部工具：
- 读取Google Drive中的设计文档
- 更新Jira中的工单
- 从Slack拉取数据
- 使用自定义工具

### 3. 技能和钩子
- **CLAUDE.md**：项目根目录的markdown文件，设置编码标准、架构决策
- **自定义斜杠命令**：打包可重复的工作流
- **钩子**：在操作前后运行shell命令

## 最佳实践

1. **明确描述任务**：提供具体的上下文和要求
2. **分步进行**：复杂的任务分解为多个步骤
3. **验证结果**：运行测试检查代码是否工作
4. **代码审查**：让Claude审查自己的代码
5. **文档化**：要求Claude为代码添加注释和文档

## 故障排除

### 常见问题

1. **Claude Code未安装**：
   ```bash
   which claude
   # 如果未找到，重新安装
   curl -fsSL https://claude.ai/install.sh | bash
   ```

2. **权限问题**：
   ```bash
   # 检查文件权限
   ls -la
   # 确保有读写权限
   ```

3. **模型限制**：
   ```bash
   # 使用不同的模型
   claude --model sonnet "你的任务"
   ```

4. **上下文限制**：
   ```bash
   # 限制工具使用
   claude --tools "Read,Edit" "你的任务"
   ```

### 调试模式
```bash
claude --debug "api,mcp" "你的任务"
```

## 相关资源

- [官方文档](https://code.claude.com/docs/zh-CN/overview)
- [快速入门](https://code.claude.com/docs/zh-CN/quickstart)
- [常见工作流](https://code.claude.com/docs/zh-CN/common-workflows)
- [CLI参考](https://code.claude.com/docs/zh-CN/cli-reference)
- [技能文档](https://code.claude.com/docs/zh-CN/skills)

---

**注意**：此技能需要在系统上安装Claude Code CLI工具。如果没有安装，技能将无法正常工作。