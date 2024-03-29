FROM nginx:1.21.6

RUN apt-get update && apt-get install -y \
	certbot \
	python3-certbot-nginx

COPY docker/data/nginx/certbot_renew.sh /certbot_renew.sh