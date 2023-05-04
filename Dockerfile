FROM ubuntu:latest
RUN apt-get update && apt install nginx -y
COPY html /var/www/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
