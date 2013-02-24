#!/bin/sh

# This build script generates various permutations of the targets below:
# OS X Deployment Target: 10.5 (min version end users must have)
# OS X Base SDK Versions: 10.7 and 10.8
# Architectures: i386 and x86_64 (that is, x86 32-bit and 64-bit, universal)
# Compilers: clang++ and g++
# C++ versions: C++03 and C++11
# Library types: Framekworks and Dynamic Libraries (dylibs)

# Base SDK locations:
# 10.5: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.5.sdk
# 10.6: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.6.sdk
# 10.7: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.7.sdk
# 10.8: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk

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
# sfml_osx_10.7base_for_g++_and_c++03_deploys_to_10.5

# If using 10.8 base SDK, the target must be 10.6 or later (with g++)
# if using 10.7 base SDK, the target may be 10.5 (with g++)
# I'm unable to get 10.6/10.5 base SDKs working without Xcode 3, which I don't really want to install right now... maybe later

# Start building!
export cxx_cmp='g++'
export c_cmp='gcc'
export cpp_ver='c++03'
export base='10.7'
export deploy='10.5'
export extra_flags=
./single_build.sh

export cxx_cmp='g++'
export c_cmp='gcc'
export cpp_ver='c++03'
export base='10.8'
export deploy='10.6'
export extra_flags=
./single_build.sh



export cxx_cmp='clang++'
export c_cmp='clang'
export cpp_ver='c++11'
export base='10.8'
export deploy='10.7'
export extra_flags='-DCMAKE_CXX_FLAGS=-stdlib=libc++ -DCMAKE_C_FLAGS=-stdlib=libc++'
./single_build.sh

export cxx_cmp='clang++'
export c_cmp='clang'
export cpp_ver='c++11'
export base='10.7'
export deploy='10.7'
export extra_flags='-DCMAKE_CXX_FLAGS=-stdlib=libc++ -DCMAKE_C_FLAGS=-stdlib=libc++'
./single_build.sh

export cxx_cmp='clang++'
export c_cmp='clang'
export cpp_ver='c++03'
export base='10.8'
export deploy='10.5'
export extra_flags=
./single_build.sh

export cxx_cmp='clang++'
export c_cmp='clang'
export cpp_ver='c++03'
export base='10.7'
export deploy='10.5'
export extra_flags=
./single_build.sh

d=`date "+%Y-%m-%d"`
git add bin
git commit -m "Add builds from $d and SFML $sfml_rev"
git push -f

git checkout master