# FROM nginx
# FROM node
# # 安装pnpm
# RUN npm install -g pnpm@8.15.9

# LABEL name='my-vue-project'
# LABEL version='1.0.0'
# COPY ./dist /usr/share/nginx/html
# COPY ./vue-front.conf /etc/nginx/conf.d/default.conf
# EXPOSE 80
# 使用最新的官方 Node.js 镜像作为基础镜像，并命名为 `builder` 阶段
FROM node
RUN npm install -g pnpm@8.15.9

# 设置工作目录  
WORKDIR /app

# 将当前目录下的所有文件复制到容器的工作目录 `/app` 中
COPY . .

# 在容器中安装项目依赖
RUN pnpm install

# 在容器中构建项目
RUN pnpm run build

# 使用轻量级的官方 Nginx 镜像作为基础镜像
FROM nginx

# 时区
ENV TZ=Asia/Shanghai

# 本地的 `nginx.conf` 文件复制到容器的 `/etc/nginx/conf.d/default.conf`
COPY nginx.conf /etc/nginx/conf.d/default.conf

# `builder` 阶段中复制构建好的文件到 Nginx 容器的网页根目录 `/usr/share/nginx/html`
COPY  /app/dist /usr/share/nginx/html
