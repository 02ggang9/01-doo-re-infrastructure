#!/bin/sh

### Check Arguments / $1: Commit ID, $2: prod or dev
if [ $# -ne 2 ]; then
    echo 'Check Arguments'
    exit -1
fi

### Download layered jar From S3
BUILD_PATH="docker/data/server"

aws s3 cp s3://doo-re-dev-bucket/doo-re-back-dev-deploy/$1.tar.gz $BUILD_PATH/$1.tar.gz

if [ -d $BUILD_PATH/application ]
then
    rm -r \
        $BUILD_PATH/dependencies \
        $BUILD_PATH/snapshot-dependencies \
        $BUILD_PATH/spring-boot-loader \
        $BUILD_PATH/application
fi

tar -zxf $BUILD_PATH/$1.tar.gz -C $BUILD_PATH
rm $BUILD_PATH/$1.tar.gz

### Make Docker Image
docker build -t doo-re-app:$2 -f docker/app.layer.dockerfile .

docker-compose down --rmi all

### Deploy
docker-compose -p doo-re up -d

### Cleanup
# docker rmi $(sudo docker images -f "dangling=true" -q)