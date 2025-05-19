FROM nginx
FROM node
# 安装pnpm
RUN npm install -g pnpm@8.15.9

LABEL name='my-vue-project'
LABEL version='1.0.0'
COPY ./dist /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
# 使用最新的官方 Node.js 镜像作为基础镜像，并命名为 `builder` 阶段
