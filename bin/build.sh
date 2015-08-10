#!/bin/bash

cd $CHECKOUT_PATH
if [ ! -d build ]; then mkdir build; fi
cd build
if [ "$ASAN" == "on"]; then export CXX_FLAGS="${CXX_FLAGS} -fsanitize=address,undefined,integer -fno-omit-frame-pointer -fno-sanitize=unsigned-integer-overflow"; fi
if [ "$LIBCXX" = "on" ]; then CXX_FLAGS="${CXX_FLAGS} -stdlib=libc++ -I/usr/include/c++/v1/"; fi
if [ "$LIBCXX" = "on" ]; then CXX_LINKER_FLAGS="${CXX_FLAGS} -L/usr/lib/ -lc++"; fi
cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_CXX_FLAGS="${CXX_FLAGS}" -DCMAKE_EXE_LINKER_FLAGS="${CXX_LINKER_FLAGS}" ..
CTEST_OUTPUT_ON_FAILURE=1 make -j4 check VERBOSE=1
cd .. && rm -rf build/
