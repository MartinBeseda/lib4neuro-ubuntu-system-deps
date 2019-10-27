FROM ubuntu:latest

# Boost, Armadillo, Turtle, Exprtk, OpenBLAS

# Download needed packages from the Ubuntu repository
RUN apt-get clean && apt-get update && apt-get install -y -V apt-utils make build-essential g++-8 gfortran git libboost-all-dev wget libarmadillo-dev python3-pip mpich
RUN yes | pip3 install scipy requests request datetime --upgrade

# Download the new version of CMake and "install" it
RUN wget https://github.com/Kitware/CMake/releases/download/v3.14.0-rc2/cmake-3.14.0-rc2-Linux-x86_64.sh
RUN chmod +x cmake-*.sh
RUN yes | ./cmake-3.14.0-rc2-Linux-x86_64.sh
WORKDIR "cmake-3.14.0-rc2-Linux-x86_64/bin"
RUN ln -s $(pwd)/cmake /usr/bin/cmake

WORKDIR "/usr/include"
RUN git clone https://github.com/mat007/turtle.git
RUN git clone https://github.com/ArashPartow/exprtk.git

RUN git clone https://github.com/xianyi/OpenBLAS.git
WORKDIR "/usr/include/OpenBLAS"
RUN cmake .
RUN cmake --build .

RUN git clone git clone -b maint https://gitlab.com/petsc/petsc.git petsc
WORKDIR "/usr/include/petsc"
RUN ./configure --download-mumps --download-pastix --download-superlu
