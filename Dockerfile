FROM nginx:alpine
COPY 2048.html /usr/share/nginx/html/index.html
EXPOSE 80