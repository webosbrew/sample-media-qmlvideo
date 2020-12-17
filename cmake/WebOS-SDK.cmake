# QMake is not yet included in SDK itself, that one we needed is located in build-webos/BUILD/sysroots/x86_64-linux
set(OE_QMAKE_PATH_EXTERNAL_HOST_BINS $ENV{OE_QMAKE_PATH_HOST_BINS})

# This is required to make build work
list(APPEND CMAKE_PREFIX_PATH "$ENV{OECORE_TARGET_SYSROOT}/usr/lib/cmake/Qt5")

add_definitions(-DQ_OS_WEBOS)