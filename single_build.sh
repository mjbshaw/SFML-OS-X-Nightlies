#!/bin/sh

dir="sfml_osx_${base}base_for_${cxx_cmp}_and_${cpp_ver}_deploys_to_${deploy}${extra_name}"
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
      -DOPENAL_INCLUDE_DIR="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${base}.sdk/System/Library/Frameworks/OpenAL.framework/Headers" \
      -DOPENAL_LIBRARY="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${base}.sdk/System/Library/Frameworks/OpenAL.framework" \
      -DOPENGL_INCLUDE_DIR="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${base}.sdk/System/Library/Frameworks/OpenGL.framework/Headers" \
      -DOPENGL_gl_LIBRARY="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${base}.sdk/System/Library/Frameworks/OpenGL.framework" \
      -DOPENGL_glu_LIBRARY="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${base}.sdk/System/Library/Frameworks/AGL.framework" \
      -DSFML_BUILD_FRAMEWORKS="ON" \
      -DSFML_INSTALL_XCODE4_TEMPLATES="ON" \
      -DSFML_BUILD_DOC="ON" \
      -DSFML_BUILD_EXAMPLES="ON" \
      $extra_flags \
      "$sfml_src_dir"

make -j8

# for templates:
ditto "$sfml_src_dir/tools/xcode/templates/SFML" "$install_dir/templates/SFML"

# for cmake:
ditto "$sfml_src_dir/cmake/Modules/FindSFML.cmake" "$install_dir/cmake/Modules/"

# for sndfile:
ditto "$sfml_src_dir/extlibs/libs-osx/Frameworks/sndfile.framework" "$install_dir/extlibs/sndfile.framework"

# for freetype:
ditto "$sfml_src_dir/extlibs/libs-osx/Frameworks/freetype.framework" "$install_dir/extlibs/freetype.framework"

# for documentation
ditto "doc/html" "$install_dir/doc/html"
cp  "$sfml_src_dir/license.txt" "$install_dir/"
cp  "$sfml_src_dir/readme.txt" "$install_dir/"

# for examples
ditto "examples/cocoa/cocoa.app" "$install_dir/examples/cocoa/cocoa.app"

ditto "$sfml_src_dir/examples/ftp/ftp.cpp" "$install_dir/examples/ftp/Ftp.cpp"
ditto "examples/ftp/ftp" "$install_dir/examples/ftp/ftp"

ditto "$sfml_src_dir/opengl/OpenGL.cpp" "$install_dir/examples/opengl/OpenGL.cpp"
ditto "$sfml_src_dir/opengl/resources/background.jpg" "$install_dir/examples/opengl/resources/background.jpg"
ditto "$sfml_src_dir/opengl/resources/sansation.ttf" "$install_dir/examples/opengl/resources/sansation.ttf"
ditto "$sfml_src_dir/opengl/resources/texture.jpg" "$install_dir/examples/opengl/resources/texture.jpg"
ditto "examples/opengl/opengl" "$install_dir/examples/opengl/opengl"

ditto "$sfml_src_dir/pong/Pong.cpp" "$install_dir/examples/pong/Pong.cpp"
ditto "$sfml_src_dir/pong/resources/ball.wav" "$install_dir/examples/pong/resources/ball.wav"
ditto "$sfml_src_dir/pong/resources/sansation.ttf" "$install_dir/examples/pong/resources/sansation.ttf"
ditto "examples/pong/pong" "$install_dir/examples/pong/pong"

ditto "$sfml_src_dir/shader/Effect.hpp" "$install_dir/examples/shader/Effect.hpp"
ditto "$sfml_src_dir/shader/Shader.cpp" "$install_dir/examples/shader/Shader.cpp"
ditto "$sfml_src_dir/shader/resources/background.jpg" "$install_dir/examples/shader/resources/background.jpg"
ditto "$sfml_src_dir/shader/resources/blink.frag" "$install_dir/examples/shader/resources/blink.frag"
ditto "$sfml_src_dir/shader/resources/blur.frag" "$install_dir/examples/shader/resources/blur.frag"
ditto "$sfml_src_dir/shader/resources/devices.png" "$install_dir/examples/shader/resources/devices.png"
ditto "$sfml_src_dir/shader/resources/edge.frag" "$install_dir/examples/shader/resources/edge.frag"
ditto "$sfml_src_dir/shader/resources/pixelate.frag" "$install_dir/examples/shader/resources/pixelate.frag"
ditto "$sfml_src_dir/shader/resources/sansation.ttf" "$install_dir/examples/shader/resources/sansation.ttf"
ditto "$sfml_src_dir/shader/resources/sfml.png" "$install_dir/examples/shader/resources/sfml.png"
ditto "$sfml_src_dir/shader/resources/storm.vert" "$install_dir/examples/shader/resources/storm.vert"
ditto "$sfml_src_dir/shader/resources/text-background.png" "$install_dir/examples/shader/resources/text-background.png"
ditto "$sfml_src_dir/shader/resources/wave.vert" "$install_dir/examples/shader/resources/wave.vert"
ditto "examples/shader/shader" "$install_dir/examples/shader/shader"

ditto "$sfml_src_dir/sockets/Sockets.cpp" "$install_dir/examples/sockets/Sockets.cpp"
ditto "$sfml_src_dir/sockets/TCP.cpp" "$install_dir/examples/sockets/TCP.cpp"
ditto "$sfml_src_dir/sockets/UDP.cpp" "$install_dir/examples/sockets/UDP.cpp"
ditto "examples/sockets/sockets" "$install_dir/examples/sockets/sockets"

ditto "$sfml_src_dir/sound/Sound.cpp" "$install_dir/examples/sound/Sound.cpp"
ditto "$sfml_src_dir/sound/resources/canary.wav" "$install_dir/examples/sound/resources/canary.wav"
ditto "$sfml_src_dir/sound/resources/orchestral.ogg" "$install_dir/examples/sound/resources/orchestral.ogg"
ditto "examples/sound/sound" "$install_dir/examples/sound/sound"

ditto "$sfml_src_dir/sound_capture/SoundCapture.cpp" "$install_dir/examples/sound-capture/SoundCapture.cpp"
ditto "examples/sound_capture/sound-capture" "$install_dir/examples/sound-capture/sound-capture"

ditto "$sfml_src_dir/voip/Client.cpp" "$install_dir/examples/voip/Client.cpp"
ditto "$sfml_src_dir/voip/Server.cpp" "$install_dir/examples/voip/Server.cpp"
ditto "$sfml_src_dir/voip/VoIP.cpp" "$install_dir/examples/voip/VoIP.cpp"
ditto "examples/voip/voip" "$install_dir/examples/voip/voip"

ditto "$sfml_src_dir/window/Window.cpp" "$install_dir/examples/window/Window.cpp"
ditto "examples/window/window" "$install_dir/examples/window/window"

# for frameworks:
ditto "SFML.framework" "$install_dir/Frameworks/SFML.framework"
ditto "lib" "$install_dir/Frameworks/"

cd ..

mkdir lib
cd lib

# Build as dylibs
cmake -G "Unix Makefiles" \
      -DCMAKE_OSX_ARCHITECTURES='i386;x86_64' \
      -DCMAKE_CXX_COMPILER="/usr/bin/$cxx_cmp" \
      -DCMAKE_C_COMPILER="/usr/bin/$c_cmp" \
      -DCMAKE_OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${base}.sdk" \
      -DCMAKE_OSX_DEPLOYMENT_TARGET="$deploy" \
      -DOPENAL_INCLUDE_DIR="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${base}.sdk/System/Library/Frameworks/OpenAL.framework/Headers" \
      -DOPENAL_LIBRARY="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${base}.sdk/System/Library/Frameworks/OpenAL.framework" \
      -DOPENGL_INCLUDE_DIR="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${base}.sdk/System/Library/Frameworks/OpenGL.framework/Headers" \
      -DOPENGL_gl_LIBRARY="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${base}.sdk/System/Library/Frameworks/OpenGL.framework" \
      -DOPENGL_glu_LIBRARY="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${base}.sdk/System/Library/Frameworks/AGL.framework" \
      $extra_flags \
      "$sfml_src_dir"

make -j8

# for dylibs:
ditto "lib" "$install_dir/lib"
ditto "$sfml_src_dir/include/SFML" "$install_dir/include/SFML"

echo These binaries were built on `date "+%Y-%m-%d"` from SFML $sfml_rev > "$install_dir/version.txt"

cd ..

cp "../install.sh" "$install_dir/"

tar -cjf "${dir}.tar.bz2" "$dir"

cp "${dir}.tar.bz2" ../bin

cd ..

rm -rf "$dir"
