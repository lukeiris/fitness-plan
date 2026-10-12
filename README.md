# 增肌训练计划网页

这是一个纯静态网页，无需安装依赖或构建。训练记录通过 Supabase 登录后同步到云端。

## 发布方法

将本文件夹内的 `index.html` 上传到任意静态网页托管服务即可，例如 GitHub Pages、Cloudflare Pages、Netlify 或 Vercel。

如果服务要求选择发布目录，请选择当前文件夹的根目录。

## 首次启用云端同步

1. 在 Supabase Dashboard 打开 **SQL Editor**。
2. 打开并复制本目录的 `supabase-schema.sql`，粘贴后点击 Run。
3. 在 Supabase 的 Authentication 设置中确认 Email 登录已启用；若启用确认邮件，请将 Gitee Pages 的网址加入 Redirect URLs。
4. 发布网页后，使用邮箱注册并登录。训练记录会自动同步到当前账户。

## 本地打开

直接双击 `index.html` 即可使用。训练打卡、日历与计时器数据保存在浏览器本地；换浏览器、清除站点数据或换设备不会自动同步。
