FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y \
    curl \
    git \
    wget \
    build-essential \
    valgrind \
    software-properties-common \
    python-software-properties \
    subversion \
    make

# Install cmake
RUN wget http://www.cmake.org/files/v3.1/cmake-3.1.3-Linux-x86_64.sh
RUN sh cmake-3.1.3-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir
# Setup sources
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y
RUN wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key|sudo apt-key add -
RUN apt-add-repository -y "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.4 main"
RUN apt-add-repository -y "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.5 main"
RUN apt-add-repository -y "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.6 main"
RUN apt-add-repository -y "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty main"
RUN apt-get update -qq
# Install gcc and clang
RUN apt-get install -qq g++-4.6 g++-4.7 g++-4.8 g++-4.9 clang-3.4 clang-3.5 clang-3.6
# Install libc++
RUN svn co --quiet http://llvm.org/svn/llvm-project/libcxx/trunk libcxx
RUN cd libcxx/lib && CXX=clang++-3.4 CC=clang-3.4 bash buildit
RUN cd libcxx/lib && cp ./libc++.so.1.0 /usr/lib/
RUN mkdir /usr/include/c++/v1
RUN cd libcxx/ && cp -r include/* /usr/include/c++/v1/
RUN cd /usr/lib && ln -sf libc++.so.1.0 libc++.so
RUN ln -sf libc++.so.1.0 libc++.so.1 && cd $cwd

RUN mkdir /data
WORKDIR /data

