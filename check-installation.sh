#!/bin/bash

# Claude Code 安装检查脚本
# 用法: ./check-installation.sh

set -e

echo "🔍 检查Claude Code安装状态..."

# 检查claude命令是否存在
if command -v claude &> /dev/null; then
    echo "✅ Claude Code已安装"
    
    # 获取版本信息
    echo "📋 版本信息:"
    claude --version || echo "  无法获取版本信息"
else
    echo "❌ Claude Code未安装"
    echo ""
    echo "📥 安装方法:"
    echo ""
    echo "1. macOS/Linux/WSL:"
    echo "   curl -fsSL https://claude.ai/install.sh | bash"
    echo ""
    echo "2. Homebrew (macOS):"
    echo "   brew install --cask claude-code"
    echo ""
    echo "3. Windows PowerShell:"
    echo "   irm https://claude.ai/install.ps1 | iex"
    echo ""
    echo "安装后，运行 'claude' 进行首次登录"
    exit 1
fi

echo ""
echo "🔧 检查系统依赖..."

# 检查Python（某些功能需要）
if command -v python3 &> /dev/null; then
    python_version=$(python3 --version 2>/dev/null || echo "未知")
    echo "✅ Python3: $python_version"
else
    echo "⚠️  Python3未安装（某些功能可能需要）"
fi

# 检查Node.js（某些功能需要）
if command -v node &> /dev/null; then
    node_version=$(node --version 2>/dev/null || echo "未知")
    echo "✅ Node.js: $node_version"
else
    echo "⚠️  Node.js未安装（某些功能可能需要）"
fi

# 检查Git（集成功能需要）
if command -v git &> /dev/null; then
    git_version=$(git --version 2>/dev/null || echo "未知")
    echo "✅ Git: $git_version"
else
    echo "⚠️  Git未安装（版本控制功能需要）"
fi

echo ""
echo "📊 测试基本功能..."

# 创建测试目录
TEST_DIR="/tmp/claude-test-$$"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

# 创建测试文件
cat > test.py << 'EOF'
def greet(name: str) -> str:
    """打招呼函数"""
    return f"Hello, {name}!"

def add(a: int, b: int) -> int:
    """加法函数"""
    return a + b

if __name__ == "__main__":
    print(greet("World"))
    print(f"1 + 2 = {add(1, 2)}")
EOF

echo "📝 测试文件已创建: $TEST_DIR/test.py"

# 测试Claude Code解释功能
echo ""
echo "🧪 测试Claude Code解释功能..."
if timeout 30s claude -p "解释这个Python文件的功能" < test.py 2>/dev/null | head -5; then
    echo "✅ Claude Code响应正常"
else
    echo "⚠️  Claude Code响应超时或失败"
    echo "   请确保已登录: claude"
fi

# 清理
cd /
rm -rf "$TEST_DIR"

echo ""
echo "🎉 检查完成!"
echo ""
echo "📚 下一步:"
echo "1. 运行 'claude' 进行首次登录（如果需要）"
echo "2. 尝试命令: claude '解释这个技能如何使用'"
echo "3. 查看文档: https://code.claude.com/docs/zh-CN/overview"
echo ""
echo "🦞 在OpenClaw中使用: /claude-code [任务描述]"