FROM ubuntu:latest

RUN useradd -m -p pass myuser 

# Boost, Armadillo, Turtle, Exprtk, OpenBLAS

# Download needed packages from the Ubuntu repository
RUN apt-get clean && apt-get update && apt-get install -y -V apt-utils make build-essential g++-8 gfortran git libboost-all-dev wget libarmadillo-dev python3-pip mpich bison flex
RUN yes | pip3 install scipy requests request datetime --upgrade

USER myuser
RUN echo $HOME
ENV HOME /home/myuser
WORKDIR $HOME
RUN echo "$(pwd)"

# Download the new version of CMake and "install" it
RUN wget https://github.com/Kitware/CMake/releases/download/v3.14.0-rc2/cmake-3.14.0-rc2-Linux-x86_64.sh
RUN chmod +x cmake-*.sh
RUN yes | ./cmake-3.14.0-rc2-Linux-x86_64.sh
WORKDIR "cmake-3.14.0-rc2-Linux-x86_64/bin"
RUN ln -s $(pwd)/cmake /usr/bin/cmake

WORKDIR "${HOME}"
RUN git clone -b maint https://gitlab.com/petsc/petsc.git 
WORKDIR "${HOME}/petsc"
RUN ./configure --download-elemental --download-metis --download-parmetis --with-clanguage=C++
RUN TMP=`find . -name 'petscconf.h' | tail -n 1` && TMP=`echo ${TMP%/include*}` && make PETSC_DIR=$(pwd) PETSC_ARCH=${TMP} all
RUN TMP=`find . -name 'petscconf.h' | tail -n 1` && TMP=`echo ${TMP%/include*}` && make PETSC_DIR=$(pwd) PETSC_ARCH=${TMP} check

WORKDIR "${HOME}"
RUN git clone https://github.com/mat007/turtle.git
RUN git clone https://github.com/ArashPartow/exprtk.git

WORKDIR "${HOME}"
RUN git clone https://github.com/xianyi/OpenBLAS.git
WORKDIR "${HOME}/OpenBLAS"
RUN cmake .
RUN cmake --build .

