FROM gradle:8.5.0-jdk17

WORKDIR /home/doo-re

RUN git clone https://github.com/BDD-CLUB/01-doo-re-back.git .

ENV LANG=ko_KR.UTF-8 \
    LANGUAGE=ko_KR.UTF-8 \
    LC_ALL=ko_KR.UTF-8

COPY docker/data/entrypoint.sh /entrypoint.sh
COPY docker/data/application.yml /application.yml