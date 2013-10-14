#!/bin/sh

# This build script generates various permutations of the targets below:
# OS X Deployment Target: 10.7 (min version end users must have)
# OS X Base SDK Versions: 10.8 and 10.9
# Architectures: i386 and x86_64 (that is, x86 32-bit and 64-bit, universal)
# Compilers: clang++
# C++ versions: C++03 and C++11
# Library types: Framekworks and Dynamic Libraries (dylibs)

# Base SDK locations:
# 10.8: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk
# 10.8: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk

# Update SFML to the latest version
cd SFML

git fetch
git rebase origin/master
export sfml_rev=`git rev-parse --short HEAD`
cd ..

git add SFML
git commit -m "Update SFML to $sfml_rev"

export sfml_src_dir="`pwd`/SFML"

git checkout bin
git reset HEAD~1
git rebase master

rm -rf bin/*

# Folder naming scheme example:
# sfml_osx_10.8base_for_g++_and_c++03_deploys_to_10.7

# Start building!
export cxx_cmp='clang++'
export c_cmp='clang'
export cpp_ver='c++11'
export base='10.8'
export deploy='10.7'
export extra_flags='-DCMAKE_CXX_FLAGS=-stdlib=libc++ -DCMAKE_C_FLAGS=-stdlib=libc++'
export cxx_opt_flags=
export c_opt_flags=
export extra_name=
./single_build.sh

export cxx_cmp='clang++'
export c_cmp='clang'
export cpp_ver='c++11'
export base='10.9'
export deploy='10.7'
export extra_flags='-DCMAKE_CXX_FLAGS=-stdlib=libc++ -DCMAKE_C_FLAGS=-stdlib=libc++'
export cxx_opt_flags=
export c_opt_flags=
export extra_name=
./single_build.sh

export cxx_cmp='clang++'
export c_cmp='clang'
export cpp_ver='c++03'
export base='10.8'
export deploy='10.7'
export extra_flags='-DCMAKE_CXX_FLAGS=-stdlib=libstdc++ -DCMAKE_C_FLAGS=-stdlib=libstdc++'
export cxx_opt_flags=
export c_opt_flags=
export extra_name=
./single_build.sh

export cxx_cmp='clang++'
export c_cmp='clang'
export cpp_ver='c++03'
export base='10.9'
export deploy='10.7'
export extra_flags='-DCMAKE_CXX_FLAGS=-stdlib=libstdc++ -DCMAKE_C_FLAGS=-stdlib=libstdc++'
export cxx_opt_flags=
export c_opt_flags=
export extra_name=
./single_build.sh


export cxx_cmp='clang++'
export c_cmp='clang'
export cpp_ver='c++11'
export base='10.8'
export deploy='10.7'
export extra_flags='-DCMAKE_CXX_FLAGS=-stdlib=libc++ -DCMAKE_C_FLAGS=-stdlib=libc++'
export cxx_opt_flags='-DCMAKE_CXX_FLAGS_RELEASE=-Ofast -flto -DNDEBUG'
export c_opt_flags='-DCMAKE_C_FLAGS_RELEASE=-Ofast -flto -DNDEBUG'
export extra_name="_Ofast_and_flto"
./single_build.sh

export cxx_cmp='clang++'
export c_cmp='clang'
export cpp_ver='c++11'
export base='10.9'
export deploy='10.7'
export extra_flags='-DCMAKE_CXX_FLAGS=-stdlib=libc++ -DCMAKE_C_FLAGS=-stdlib=libc++'
export cxx_opt_flags='-DCMAKE_CXX_FLAGS_RELEASE=-Ofast -flto -DNDEBUG'
export c_opt_flags='-DCMAKE_C_FLAGS_RELEASE=-Ofast -flto -DNDEBUG'
export extra_name="_Ofast_and_flto"
./single_build.sh

export cxx_cmp='clang++'
export c_cmp='clang'
export cpp_ver='c++03'
export base='10.8'
export deploy='10.7'
export extra_flags='-DCMAKE_CXX_FLAGS=-stdlib=libstdc++ -DCMAKE_C_FLAGS=-stdlib=libstdc++'
export cxx_opt_flags='-DCMAKE_CXX_FLAGS_RELEASE=-Ofast -flto -DNDEBUG'
export c_opt_flags='-DCMAKE_C_FLAGS_RELEASE=-Ofast -flto -DNDEBUG'
export extra_name="_Ofast_and_flto"
./single_build.sh

export cxx_cmp='clang++'
export c_cmp='clang'
export cpp_ver='c++03'
export base='10.9'
export deploy='10.7'
export extra_flags='-DCMAKE_CXX_FLAGS=-stdlib=libstdc++ -DCMAKE_C_FLAGS=-stdlib=libstdc++'
export cxx_opt_flags='-DCMAKE_CXX_FLAGS_RELEASE=-Ofast -flto -DNDEBUG'
export c_opt_flags='-DCMAKE_C_FLAGS_RELEASE=-Ofast -flto -DNDEBUG'
export extra_name="_Ofast_and_flto"
./single_build.sh

d=`date "+%Y-%m-%d"`
git add bin
git commit -m "Add builds from $d and SFML $sfml_rev"
git push -f

git checkout master
git push
