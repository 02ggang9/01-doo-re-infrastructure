FROM gradle:8.5.0-jdk17

WORKDIR /home/doo-re

RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

COPY docker/data/server/dependencies .
COPY docker/data/server/spring-boot-loader .
COPY docker/data/server/snapshot-dependencies .
COPY docker/data/server/application .

ENTRYPOINT [ \
    "java", \
    "-jar", \
    "-Dspring.profiles.active=deploy", \
    "-Duser.timezone=Asia/Seoul", \
    "org.springframework.boot.loader.JarLauncher" \
]