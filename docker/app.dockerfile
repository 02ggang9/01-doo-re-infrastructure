FROM gradle:8.5.0-jdk17

WORKDIR /home/doo-re

RUN git clone https://github.com/BDD-CLUB/bulk-mailing-service.git .

ENV LANG=ko_KR.UTF-8 \
    LANGUAGE=ko_KR.UTF-8 \
    LC_ALL=ko_KR.UTF-8

