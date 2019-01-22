FROM ubuntu:latest

RUN apt-get clean && apt-get update && apt-get install -y -V apt-utils make cmake build-essential g++-8 git libboost-all-dev

RUN cd /usr/include
RUN git clone https://github.com/mat007/turtle.git
RUN git clone https://github.com/ArashPartow/exprtk.git
