#!/usr/bin/env bash
set -e

xcrun -sdk iphoneos clang -o bootstrap bootstrap.m -lobjc -m32 -arch armv7 -miphoneos-version-min=7.1 \
  -framework Foundation -framework CoreTelephony -framework CFNetwork \
  -framework UIKit -framework CoreFoundation -framework SystemConfiguration && \
mv bootstrap bootstrap32 && \
xcrun -sdk iphoneos clang -o bootstrap bootstrap.m -lobjc -m64 -arch arm64 -miphoneos-version-min=7.1 \
  -framework Foundation -framework CoreTelephony -framework CFNetwork \
  -framework UIKit -framework CoreFoundation -framework SystemConfiguration && \
mv bootstrap bootstrap64 && \
lipo -create bootstrap32 bootstrap64 -output bootstrap_objc && \
rm bootstrap32 bootstrap64 && \
mv bootstrap_objc ../../resources/ios/

xcrun -sdk iphoneos clang -o bootstrap bootstrap.c -lobjc -m32 -arch armv7 -miphoneos-version-min=7.1 && \
mv bootstrap bootstrap32 && \
xcrun -sdk iphoneos clang -o bootstrap bootstrap.c -lobjc -m64 -arch arm64 -miphoneos-version-min=7.1 && \
mv bootstrap bootstrap64 && \
lipo -create bootstrap32 bootstrap64 -output bootstrap && \
rm bootstrap32 bootstrap64 && \
mv bootstrap ../../resources/ios/

xcrun -sdk iphoneos clang -o libclassdump.dylib class-dump.m -shared -lobjc -m32 -arch armv7 -miphoneos-version-min=7.1 -framework Foundation && \
mv libclassdump.dylib libclassdump32.dylib && \
xcrun -sdk iphoneos clang -o libclassdump.dylib class-dump.m -shared -lobjc -m64 -arch arm64 -miphoneos-version-min=7.1 -framework Foundation && \
mv libclassdump.dylib libclassdump64.dylib && \
lipo -create libclassdump32.dylib libclassdump64.dylib -output libclassdump.dylib && \
rm libclassdump32.dylib libclassdump64.dylib && \
mv libclassdump.dylib ../../resources/ios/lib/
