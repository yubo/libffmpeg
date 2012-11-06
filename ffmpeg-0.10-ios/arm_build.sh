#!/bin/sh

trap exit ERR

USR=/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.3.sdk

SCRIPT_DIR=$( (cd -P $(dirname $0) && pwd) )

#echo "Pulling r22403..."
#svn co -r22403 svn://svn.ffmpeg.org/ffmpeg/trunk $FFMPEG_DIR

#cd $FFMPEG_DIR
mkdir -p dist

# Default configure options
CONFIGURE_OPTIONS="--enable-gpl --enable-postproc --enable-swscale --enable-avfilter \
                        --disable-ffmpeg --disable-ffserver \
			--enable-neon --enable-armv6 --enable-armvfp \
			--disable-asm --disable-yasm --disable-ffprobe \
                        --disable-ffplay --disable-doc"

# Add x264 if we built that
X264_DIST="$SCRIPT_DIR/x264-armv6/dist"
if [ -d "$X264_DIST" ]; then
  CONFIGURE_OPTIONS="$CONFIGURE_OPTIONS --enable-libx264 --extra-ldflags=-L$X264_DIST/lib --extra-cflags=-I$X264_DIST/include"
fi

# Add xvid if exists
XVID_DIST="$SCRIPT_DIR/xvid-armv6"
if [ -d "$XVID_DIST" ]; then
  CONFIGURE_OPTIONS="$CONFIGURE_OPTIONS --enable-libxvid --extra-ldflags=-L$XVID_DIST/lib --extra-cflags=-I$XVID_DIST/include"
fi

echo "Configure options: $CONFIGURE_OPTIONS"

./configure --cc=/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin10-gcc-4.2.1 \
		--sysroot=/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.2.sdk \
 		--as="$SCRIPT_DIR/gas-preprocessor.pl /Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin10-gcc-4.2.1" \
		--target-os=darwin --arch=arm \
		--sysroot=$USR --enable-cross-compile --prefix="dist" \
		--extra-cflags="-L$USR/lib -I$USR/include" --extra-ldflags="-L$USR/lib -I$USR/include" $CONFIGURE_OPTIONS

make && make install

echo "Installed: $FFMPEG_DIR/dist"

sudo cp -rfv dist/include/* /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.2.sdk/usr/include/
sudo cp -rfv dist/lib/pkgconfig/* /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.2.sdk/usr/lib/pkgconfig/
sudo cp -rfv dist/lib/lib* /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.2.sdk/usr/lib/
