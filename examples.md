# Claude Code 使用示例

## 示例1：创建React组件

### 任务描述
创建一个用户个人资料卡片React组件，包含头像、姓名、邮箱和编辑按钮。

### Claude Code命令
```bash
claude "创建一个React函数组件UserProfileCard，包含以下功能：
1. 接收props：name, email, avatarUrl
2. 显示圆形头像
3. 显示姓名和邮箱
4. 添加编辑按钮
5. 使用Tailwind CSS进行样式设计
6. 添加PropTypes验证
7. 编写组件文档"
```

### 预期输出
```jsx
import React from 'react';
import PropTypes from 'prop-types';

/**
 * 用户个人资料卡片组件
 * @param {Object} props - 组件属性
 * @param {string} props.name - 用户姓名
 * @param {string} props.email - 用户邮箱
 * @param {string} props.avatarUrl - 头像URL
 * @param {Function} props.onEdit - 编辑按钮点击回调
 * @returns {JSX.Element} 用户个人资料卡片
 */
const UserProfileCard = ({ name, email, avatarUrl, onEdit }) => {
  return (
    <div className="max-w-sm mx-auto bg-white rounded-xl shadow-md overflow-hidden md:max-w-2xl">
      <div className="md:flex">
        <div className="md:flex-shrink-0">
          <img
            className="h-48 w-full object-cover md:h-full md:w-48"
            src={avatarUrl || 'https://via.placeholder.com/150'}
            alt={`${name}的头像`}
          />
        </div>
        <div className="p-8">
          <div className="uppercase tracking-wide text-sm text-indigo-500 font-semibold">
            个人资料
          </div>
          <div className="mt-4 flex items-center">
            <div className="h-12 w-12 rounded-full overflow-hidden bg-gray-200">
              <img
                className="h-full w-full object-cover"
                src={avatarUrl || 'https://via.placeholder.com/150'}
                alt={`${name}的头像`}
              />
            </div>
            <div className="ml-4">
              <h2 className="text-xl font-bold text-gray-900">{name}</h2>
              <p className="text-gray-600">{email}</p>
            </div>
          </div>
          <div className="mt-6">
            <button
              onClick={onEdit}
              className="px-4 py-2 bg-indigo-600 text-white font-medium rounded-md hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
            >
              编辑资料
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

UserProfileCard.propTypes = {
  name: PropTypes.string.isRequired,
  email: PropTypes.string.isRequired,
  avatarUrl: PropTypes.string,
  onEdit: PropTypes.func.isRequired,
};

UserProfileCard.defaultProps = {
  avatarUrl: 'https://via.placeholder.com/150',
};

export default UserProfileCard;
```

## 示例2：修复TypeScript错误

### 任务描述
修复TypeScript类型错误：对象可能为"undefined"

### Claude Code命令
```bash
claude "修复以下TypeScript代码中的类型错误：

interface User {
  id: number;
  name: string;
  profile?: {
    avatar: string;
    bio: string;
  };
}

function getUserAvatar(user: User): string {
  return user.profile.avatar; // 错误：对象可能为'undefined'
}"
```

### 预期输出
```typescript
interface User {
  id: number;
  name: string;
  profile?: {
    avatar: string;
    bio: string;
  };
}

function getUserAvatar(user: User): string {
  // 方案1：使用可选链和空值合并
  return user.profile?.avatar ?? 'default-avatar.png';
  
  // 方案2：使用条件判断
  // if (user.profile && user.profile.avatar) {
  //   return user.profile.avatar;
  // }
  // return 'default-avatar.png';
  
  // 方案3：使用类型断言（不推荐，除非确定不为undefined）
  // return (user.profile as { avatar: string }).avatar;
}

// 更好的方案：创建类型安全的辅助函数
function getUserAvatarSafe(user: User): string {
  if (!user.profile?.avatar) {
    throw new Error('User profile or avatar is missing');
  }
  return user.profile.avatar;
}

// 或者使用类型守卫
function hasProfileWithAvatar(user: User): user is User & { profile: { avatar: string } } {
  return !!user.profile?.avatar;
}

function getUserAvatarWithGuard(user: User): string {
  if (hasProfileWithAvatar(user)) {
    return user.profile.avatar;
  }
  return 'default-avatar.png';
}
```

## 示例3：编写Python API端点

### 任务描述
使用FastAPI创建一个用户注册API端点

### Claude Code命令
```bash
claude "使用FastAPI创建一个用户注册API端点，包含以下功能：
1. POST /api/register 端点
2. 请求体：username, email, password
3. 密码哈希存储
4. 邮箱格式验证
5. 用户名唯一性检查
6. 返回JWT令牌
7. 添加输入验证
8. 错误处理
9. 编写测试"
```

### 预期输出
```python
from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel, EmailStr, validator
from typing import Optional
from datetime import datetime, timedelta
import hashlib
import secrets
from sqlalchemy.orm import Session
import models
import schemas
from database import get_db

app = FastAPI()

class UserRegister(BaseModel):
    username: str
    email: EmailStr
    password: str
    
    @validator('username')
    def validate_username(cls, v):
        if len(v) < 3:
            raise ValueError('用户名至少3个字符')
        if len(v) > 50:
            raise ValueError('用户名最多50个字符')
        if not v.isalnum():
            raise ValueError('用户名只能包含字母和数字')
        return v
    
    @validator('password')
    def validate_password(cls, v):
        if len(v) < 8:
            raise ValueError('密码至少8个字符')
        if not any(c.isupper() for c in v):
            raise ValueError('密码必须包含至少一个大写字母')
        if not any(c.isdigit() for c in v):
            raise ValueError('密码必须包含至少一个数字')
        return v

def hash_password(password: str) -> str:
    """哈希密码"""
    salt = secrets.token_hex(16)
    hashed = hashlib.pbkdf2_hmac(
        'sha256',
        password.encode('utf-8'),
        salt.encode('utf-8'),
        100000
    )
    return f"{salt}${hashed.hex()}"

def verify_password(password: str, hashed: str) -> bool:
    """验证密码"""
    salt, stored_hash = hashed.split('$')
    computed_hash = hashlib.pbkdf2_hmac(
        'sha256',
        password.encode('utf-8'),
        salt.encode('utf-8'),
        100000
    ).hex()
    return computed_hash == stored_hash

def create_jwt_token(user_id: int) -> str:
    """创建JWT令牌"""
    # 简化示例，实际应使用jose或PyJWT
    payload = {
        'user_id': user_id,
        'exp': datetime.utcnow() + timedelta(days=7)
    }
    # 实际实现中应使用密钥签名
    return secrets.token_urlsafe(32)

@app.post("/api/register", response_model=schemas.UserResponse)
async def register(
    user_data: UserRegister,
    db: Session = Depends(get_db)
):
    """
    用户注册
    
    - **username**: 用户名（3-50个字符，字母数字）
    - **email**: 邮箱地址
    - **password**: 密码（至少8字符，包含大写字母和数字）
    """
    
    # 检查用户名是否已存在
    existing_user = db.query(models.User).filter(
        models.User.username == user_data.username
    ).first()
    if existing_user:
        raise HTTPException(
            status_code=400,
            detail="用户名已存在"
        )
    
    # 检查邮箱是否已存在
    existing_email = db.query(models.User).filter(
        models.User.email == user_data.email
    ).first()
    if existing_email:
        raise HTTPException(
            status_code=400,
            detail="邮箱已注册"
        )
    
    # 创建用户
    hashed_password = hash_password(user_data.password)
    user = models.User(
        username=user_data.username,
        email=user_data.email,
        hashed_password=hashed_password,
        created_at=datetime.utcnow()
    )
    
    db.add(user)
    db.commit()
    db.refresh(user)
    
    # 创建JWT令牌
    token = create_jwt_token(user.id)
    
    return {
        "id": user.id,
        "username": user.username,
        "email": user.email,
        "token": token,
        "created_at": user.created_at
    }

# 测试
import pytest
from fastapi.testclient import TestClient

client = TestClient(app)

def test_register_success():
    """测试成功注册"""
    response = client.post("/api/register", json={
        "username": "testuser",
        "email": "test@example.com",
        "password": "Test1234"
    })
    assert response.status_code == 200
    data = response.json()
    assert "id" in data
    assert data["username"] == "testuser"
    assert "token" in data

def test_register_duplicate_username():
    """测试重复用户名"""
    # 先注册一个用户
    client.post("/api/register", json={
        "username": "duplicate",
        "email": "test1@example.com",
        "password": "Test1234"
    })
    
    # 尝试注册相同用户名
    response = client.post("/api/register", json={
        "username": "duplicate",
        "email": "test2@example.com",
        "password": "Test1234"
    })
    assert response.status_code == 400
    assert "用户名已存在" in response.json()["detail"]

def test_register_invalid_password():
    """测试无效密码"""
    response = client.post("/api/register", json={
        "username": "testuser2",
        "email": "test2@example.com",
        "password": "short"
    })
    assert response.status_code == 422  # 验证错误
```

## 示例4：数据库迁移脚本

### 任务描述
创建数据库迁移脚本，添加用户角色字段

### Claude Code命令
```bash
claude "创建一个SQL数据库迁移脚本，为users表添加role字段：
1. 添加role列，默认值为'user'
2. 可能的角色：'user', 'admin', 'moderator'
3. 创建索引提高查询性能
4. 添加回滚脚本
5. 编写迁移说明"
```

### 预期输出
```sql
-- migration_001_add_user_role.sql
-- 描述：为用户表添加角色字段
-- 作者：Claude Code
-- 创建时间：2026-02-23

-- 迁移前检查
DO $$
BEGIN
    -- 检查users表是否存在
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables 
                   WHERE table_name = 'users') THEN
        RAISE EXCEPTION 'users表不存在';
    END IF;
    
    -- 检查role列是否已存在
    IF EXISTS (SELECT 1 FROM information_schema.columns 
               WHERE table_name = 'users' AND column_name = 'role') THEN
        RAISE WARNING 'role列已存在，跳过迁移';
        RETURN;
    END IF;
END $$;

-- 开始事务
BEGIN;

-- 添加role列
ALTER TABLE users 
ADD COLUMN role VARCHAR(20) NOT NULL DEFAULT 'user'
CHECK (role IN ('user', 'admin', 'moderator'));

-- 为role列创建索引（如果表很大）
-- 注意：对于小表，索引可能不必要
DO $$
DECLARE
    row_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO row_count FROM users;
    IF row_count > 1000 THEN
        CREATE INDEX idx_users_role ON users(role);
    END IF;
END $$;

-- 更新现有用户（如果需要）
-- 假设第一个用户是管理员
UPDATE users 
SET role = 'admin' 
WHERE id = 1 AND role = 'user';

-- 添加注释
COMMENT ON COLUMN users.role IS '用户角色：user-普通用户, admin-管理员, moderator-版主';

-- 记录迁移
INSERT INTO migrations (name, applied_at) 
VALUES ('001_add_user_role', NOW());

-- 提交事务
COMMIT;

-- 验证迁移
DO $$
BEGIN
    -- 验证列已添加
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'users' AND column_name = 'role') THEN
        RAISE EXCEPTION '迁移失败：role列未添加';
    END IF;
    
    -- 验证约束
    BEGIN
        INSERT INTO users (username, email, role) 
        VALUES ('test', 'test@example.com', 'invalid_role');
        RAISE EXCEPTION 'CHECK约束未生效';
    EXCEPTION
        WHEN check_violation THEN
            -- 约束生效，正常
            NULL;
    END;
    
    RAISE NOTICE '迁移成功完成';
END $$;

-- 回滚脚本（保存为 migration_001_add_user_role_rollback.sql）
/*
-- 回滚迁移_001_add_user_role
BEGIN;

-- 删除索引（如果存在）
DROP INDEX IF EXISTS idx_users_role;

-- 删除role列
ALTER TABLE users DROP COLUMN IF EXISTS role;

-- 删除迁移记录
DELETE FROM migrations WHERE name = '001_add_user_role';

COMMIT;
*/
```

## 示例5：Docker配置

### 任务描述
创建Python应用的Docker配置

### Claude Code命令
```bash
claude "创建一个Python FastAPI应用的Docker配置，包含：
1. Dockerfile
2. docker-compose.yml
3. .dockerignore
4. 多阶段构建
5. 健康检查
6. 环境变量配置
7. 日志配置"
```

### 预期输出
```dockerfile
# Dockerfile
# 多阶段构建：构建阶段
FROM python:3.11-slim as builder

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 复制依赖文件
COPY requirements.txt .

# 创建虚拟环境并安装依赖
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 生产阶段
FROM python:3.11-slim

# 设置环境变量
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PATH="/opt/venv/bin:$PATH" \
    APP_ENV=production

# 创建非root用户
RUN groupadd -r appuser && useradd -r -g appuser appuser

# 创建工作目录
WORKDIR /app

# 从构建阶段复制虚拟环境
COPY --from=builder /opt/venv /opt/venv

# 复制应用代码
COPY . .

# 设置权限
RUN chown -R appuser:appuser /app
USER appuser

# 健康检查
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:8000/health', timeout=2)" || exit 1

# 暴露端口
EXPOSE 8000

# 运行应用
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build: .
    container_name: fastapi-app
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql://user:password@db:5432/appdb
      - REDIS_URL=redis://redis:6379/0
      - SECRET_KEY=${SECRET_KEY:-your-secret-key-here}
    env_file:
      - .env
    volumes:
      - ./logs:/app/logs
      - ./uploads:/app/uploads
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
    healthcheck:
      test: ["CMD", "python", "-c", "import requests; requests.get('http://localhost:8000/health', timeout=2)"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    restart: unless-stopped
    networks:
      - app-network

  db:
    image: postgres:15-alpine
    container_name: postgres-db
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=appdb
    volumes:
      - postgres-data:/var/lib/postgresql/data
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user -d appdb"]
      interval: