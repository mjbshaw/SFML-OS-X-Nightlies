#!/bin/sh

# Contents:
# frameworks
#   root/Library/Frameworks/
# dylibs
#   root/usr/local/include/
#   root/usr/local/lib/
# documentation
#    root/usr/local/share/
# sndfile
#    root/Library/Frameworks/
# templates
#    root/Library/Developer/Xcode/Templates/

# for templates:
# cp -r SFML/tools/xcode/templates/SFML templates/root/Library/Developer/Xcode/Templates/

# for sndfile:
# cp -r SFML/extlibs/libs-osx/Frameworks/sndfile.framework sndfile/root/Library/Frameworks/

# for documentation
# cp -r doc/html documentation/root/usr/local/share/SFML/doc
# cp  SFML/license.txt documentation/root/usr/local/share/SFML
# cp  SFML/readme.txt documentation/root/usr/local/share/SFML

# for dylibs:
# cp lib/* dylibs/root/usr/local/lib/
# cp -r SFML/include/SFML dylibs/root/usr/local/include/

# for frameworks:
# cp -r SFML.framework frameworks/root/Library/Frameworks/
# cp -r lib/* frameworks/root/Library/Frameworks/

dir="sfml_osx_${base}base_for_${cxx_cmp}_and_${cpp_ver}_deploys_to_${deploy}"
mkdir "$dir"
cd "$dir"

mkdir "$dir"
install_dir="`pwd`/$dir"

mkdir frameworks
cd frameworks

# Build as frameworks
cmake -G "Unix Makefiles" \
      -DCMAKE_OSX_ARCHITECTURES='i386;x86_64' \
      -DCMAKE_CXX_COMPILER="/usr/bin/$cxx_cmp" \
      -DCMAKE_C_COMPILER="/usr/bin/$c_cmp" \
      -DCMAKE_OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${base}.sdk" \
      -DCMAKE_OSX_DEPLOYMENT_TARGET="$deploy" \
      -DSFML_BUILD_FRAMEWORKS="ON" \
      -DSFML_INSTALL_XCODE4_TEMPLATES="ON" \
      -DSFML_BUILD_DOC="ON" \
      $extra_flags \
      "$sfml_src_dir"

make -j8

# for templates:
ditto "$sfml_src_dir/tools/xcode/templates/SFML" "$install_dir/templates/root/Library/Developer/Xcode/Templates/SFML"

# for sndfile:
ditto "$sfml_src_dir/extlibs/libs-osx/Frameworks/sndfile.framework" "$install_dir/sndfile/root/Library/Frameworks/sndfile.framework"

# for documentation
ditto "doc/html" "$install_dir/documentation/root/usr/local/share/SFML/doc/html"
cp  "$sfml_src_dir/license.txt" "$install_dir/documentation/root/usr/local/share/SFML"
cp  "$sfml_src_dir/readme.txt" "$install_dir/documentation/root/usr/local/share/SFML"

# for frameworks:
ditto "SFML.framework" "$install_dir/frameworks/root/Library/Frameworks/SFML.framework"
ditto "lib" "$install_dir/frameworks/root/Library/Frameworks/"

cd ..

mkdir dylibs
cd dylibs

# Build as dylibs
cmake -G "Unix Makefiles" \
      -DCMAKE_OSX_ARCHITECTURES='i386;x86_64' \
      -DCMAKE_CXX_COMPILER="/usr/bin/$cxx_cmp" \
      -DCMAKE_C_COMPILER="/usr/bin/$c_cmp" \
      -DCMAKE_OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${base}.sdk" \
      -DCMAKE_OSX_DEPLOYMENT_TARGET="$deploy" \
      $extra_flags \
      "$sfml_src_dir"

make -j8


# for dylibs:
ditto "lib" "$install_dir/dylibs/root/usr/local/lib/"
ditto "$sfml_src_dir/include/SFML" "$install_dir/dylibs/root/usr/local/include/SFML"

echo These binaries were built on `date "+%Y-%m-%d"` from SFML $sfml_rev > "$install_dir/version.txt"

cd ..

tar -cjf "${dir}.tar.bz2" "$dir"

cp "${dir}.tar.bz2" ../bin

cd ..

rm -rf "$dir"
