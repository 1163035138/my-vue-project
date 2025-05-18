FROM nginx
FROM node
# 安装pnpm
RUN npm install -g pnpm@8.15.9

LABEL name='my-vue-project'
LABEL version='1.0.0'
COPY ./dist /usr/share/nginx/html
COPY ./vue-front.conf /etc/nginx/conf.d
EXPOSE 80
CMD pnpm start
