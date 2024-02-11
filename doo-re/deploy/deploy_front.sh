#!/bin/sh

### Set Variables
MAIN_PATH=$(pwd)
BUILD_PATH="docker/data/front"

### Check Arguments / $1: commit hash / $2: prod or dev
echo "Check Arguments"
if [ $# -ne 2 ]; then
    echo 'Check Arguments'
    exit -1
fi

### Delete old files
echo "Delete old files"
rm -r $BUILD_PATH/*

### Download Build Files From S3
echo "Download Build Files From S"
aws s3 cp s3://doo-re-dev-bucket/doo-re-front-dev-deploy/ $BUILD_PATH --include=$1.tar.gz* --recursive

### Unzip Build Files
echo "Unzip Build Files"
cd $BUILD_PATH
cat $1.tar.gz* | tar zxvf -
rm $1.tar.gz*
cd $MAIN_PATH

### Docker Compose Down
echo "Docker Compose Down"
docker rm -f front

### Docker Build
echo "Docker Build"
docker build --no-cache -t doo-re-front:$2 -f docker/front.dockerfile .

### Docker Compose Up
echo "Docker Compose Up"
docker-compose up -d front


docker rmi $(docker images --filter "dangling=true" -q)