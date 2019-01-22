FROM ubuntu:latest

RUN apt-get clean && apt-get update && apt-get install -y -V make cmake build-essential g++-8 git libboost-all-dev

cd /usr/include
git clone https://github.com/mat007/turtle.git

git clone https://github.com/ArashPartow/exprtk.git
