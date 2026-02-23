# OpenClaw Claude Code 技能

![GitHub](https://img.shields.io/github/license/goulin2k/openclaw-claude-code)
![GitHub last commit](https://img.shields.io/github/last-commit/goulin2k/openclaw-claude-code)
![GitHub repo size](https://img.shields.io/github/repo-size/goulin2k/openclaw-claude-code)

一个OpenClaw技能，用于调用Claude Code进行代码开发、调试、重构和自动化任务。

## 🚀 功能特性

- **代码开发**：编写、调试、重构代码
- **测试编写**：生成单元测试、集成测试
- **文档生成**：创建API文档、代码注释
- **性能优化**：分析性能瓶颈并提供优化方案
- **安全审查**：检查代码安全漏洞
- **多语言支持**：Python、JavaScript/TypeScript、Java、Go等

## 📦 安装

### 1. 安装Claude Code

```bash
# macOS/Linux/WSL
curl -fsSL https://claude.ai/install.sh | bash

# 或使用Homebrew
brew install --cask claude-code

# Windows PowerShell
irm https://claude.ai/install.ps1 | iex
```

### 2. 安装OpenClaw技能

```bash
# 克隆仓库
git clone https://github.com/goulin2k/openclaw-claude-code.git

# 复制到OpenClaw技能目录
cp -r openclaw-claude-code/* ~/.openclaw/workspace/skills/claude-code/
```

## 🛠️ 使用方法

### 基本调用
```
/claude-code [任务描述]
```

### 示例命令

1. **解释代码**：
   ```
   /claude-code 解释这个项目的结构
   ```

2. **修复bug**：
   ```
   /claude-code 修复登录模块的bug
   ```

3. **编写测试**：
   ```
   /claude-code 为auth模块编写测试
   ```

4. **重构代码**：
   ```
   /claude-code 重构这个函数以提高可读性
   ```

5. **创建提交**：
   ```
   /claude-code 提交我的更改并附带描述性消息
   ```

## 📚 详细示例

查看 [examples.md](examples.md) 获取完整示例，包括：
- React组件创建
- TypeScript错误修复
- Python API端点开发
- 数据库迁移脚本
- Docker配置

## 🔧 高级功能

### 1. 使用特定模型
```bash
claude --model sonnet "复杂任务"
```

### 2. JSON输出
```bash
claude -p --output-format json "分析代码质量"
```

### 3. 工具限制
```bash
claude --tools "Read,Edit" "安全审查"
```

### 4. 自定义系统提示
```bash
claude --append-system-prompt "始终使用TypeScript" "编写组件"
```

### 5. 子代理模式
```bash
claude --agent Explore "了解项目结构"
```

## 📁 项目结构

```
openclaw-claude-code/
├── README.md              # 项目说明
├── SKILL.md              # 主技能文件
├── examples.md           # 使用示例
├── usage-guide.md        # 使用指南
├── check-installation.sh # 安装检查脚本
├── LICENSE              # MIT许可证
├── .gitignore           # Git忽略文件
└── UPLOAD_INSTRUCTIONS.md # 上传说明（可删除）
```

## 🧪 验证安装

运行安装检查脚本：

```bash
chmod +x check-installation.sh
./check-installation.sh
```

## 🎯 最佳实践

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

## 🔍 故障排除

### Claude Code未安装
```bash
# 检查安装
which claude

# 重新安装
curl -fsSL https://claude.ai/install.sh | bash
```

### 权限问题
```bash
# 检查文件权限
ls -la

# 以正确用户运行
sudo -u [username] claude "任务"
```

### 模型限制
```bash
# 尝试不同模型
claude --model sonnet "任务"
```

## 🤝 贡献

欢迎提交Issue和Pull Request！

1. Fork仓库
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开Pull Request

## 📄 许可证

本项目采用MIT许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 🙏 致谢

- [Claude Code](https://code.claude.com/) - 强大的AI编码助手
- [OpenClaw](https://openclaw.ai/) - 开源AI助手平台
- [Agent Skills](https://agentskills.io/) - 技能开放标准

## 📞 支持

如有问题，请：
1. 查看 [usage-guide.md](usage-guide.md)
2. 检查 [examples.md](examples.md)
3. 提交 [GitHub Issue](https://github.com/goulin2k/openclaw-claude-code/issues)

---

**提示**: Claude Code技能最适合中等复杂度的编码任务。对于非常复杂的项目，建议分阶段进行，并定期验证结果。