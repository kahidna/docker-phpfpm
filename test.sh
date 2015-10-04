#!/bin/bash

set -e

echo "-- Building PHP 5.6 image"
docker build -t php-5.6 5.6/

echo ""
echo "-- Testing server is running"
docker run --name app -d php-5.6; sleep 5
docker exec -it app bash -c 'echo "echo 2;" | php -a | grep -wc 2'
docker exec -it app bash -c "php -v | grep -c 'PHP 5.6'"

echo ""
echo "-- Clear"
docker rm -f -v $(sudo docker ps -aq); sleep 5
docker rmi -f php-5.6

echo ""
echo ""
echo "-- Building PHP 5.5 image"
docker build -t php-5.5 5.5/

echo ""
echo "-- Testing server is running"
docker run --name app -d php-5.5; sleep 5
docker exec -it app bash -c 'echo "echo 2;" | php -a | grep -wc 2'
docker exec -it app bash -c "php -v | grep -c 'PHP 5.5'"

echo ""
echo "-- Clear"
docker rm -f -v $(sudo docker ps -aq); sleep 5
docker rmi -f php-5.5


echo ""
echo ""
echo "-- Building PHP 5.4 image"
docker build -t php-5.4 5.4/

echo ""
echo "-- Testing server is running"
docker run --name app -d php-5.4; sleep 5
docker exec -it app bash -c 'echo "echo 2;" | php -a | grep -wc 2'
docker exec -it app bash -c "php -v | grep -c 'PHP 5.4'"

echo ""
echo "-- Clear"
docker rm -f -v $(sudo docker ps -aq); sleep 5
docker rmi -f php-5.4


echo ""
echo ""
echo "-- Building PHP 5.3 image"
docker build -t php-5.3 5.3/

echo ""
echo "-- Testing server is running"
docker run --name app -d php-5.3; sleep 5
docker exec -it app bash -c 'echo "echo 2;" | php -a | grep -wc 2'
docker exec -it app bash -c "php -v | grep -c 'PHP 5.3'"

echo ""
echo "-- Clear"
docker rm -f -v $(sudo docker ps -aq); sleep 5
docker rmi -f php-5.3