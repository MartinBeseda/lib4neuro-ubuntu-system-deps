FROM ubuntu:latest

# Download needed packages from the Ubuntu repository
RUN apt-get clean && apt-get update && apt-get install -y -V apt-utils make build-essential g++-8 git libboost-all-dev wget

# Download the new version of CMake and "install" it
wget https://github.com/Kitware/CMake/releases/download/v3.14.0-rc2/cmake-3.14.0-rc2-Linux-x86_64.sh
chmod +x cmake-*.sh
yes | ./cmake-3.14.0-rc2-Linux-x86_64.sh
cd cmake-3.14.0-rc2-Linux-x86_64/bin
ln -s $(pwd)/cmake /usr/bin/cmake

WORKDIR "/usr/include"
RUN git clone https://github.com/mat007/turtle.git
RUN git clone https://github.com/ArashPartow/exprtk.git
