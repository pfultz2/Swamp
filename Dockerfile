FROM ubuntu:16.04

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

# Setup sources
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y
RUN apt-get update -qq
# Install gcc and clang
RUN apt-get install -qq \
    cmake \
    cmake-curses-gui \
    g++-4.6 \
    g++-4.7 \
    g++-4.8 \
    g++-4.9 \
    g++-5 \
    g++-6 \
    clang-3.5 \
    clang-3.6 \
    clang-3.7 \
    clang-3.8 \
    clang-tidy-3.8 \
    clang-format-3.8 \
    libc++-dev

RUN mkdir -p /data
WORKDIR /data

