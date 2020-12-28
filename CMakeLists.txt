cmake_minimum_required(VERSION 3.1)

# Add folder where are supportive functions
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

include(WebOSPackage)

project(qmlvideo LANGUAGES C CXX)

# these calls create special `PkgConfig::<MODULE>` variables
find_package(Qt5 REQUIRED COMPONENTS Core Multimedia Quick REQUIRED)

set(BASE_SRC
    "main.cpp"
)

set(QRC_SRC
    "qml.qrc"
)

add_executable(qmlvideo ${BASE_SRC} ${QRC_SRC})

set_target_properties(qmlvideo PROPERTIES
    CXX_STANDARD                11
    CXX_STANDARD_REQUIRED       ON
    AUTOMOC                     ON
    AUTORCC                     ON
)

target_link_libraries(qmlvideo PRIVATE
 Qt5::Core Qt5::Multimedia Qt5::Quick # QT libraries
)

set_target_properties(qmlvideo PROPERTIES
    WEBOS_APPINFO_ID org.webosbrew.sample.qmlvideo
    WEBOS_APPINFO_VERSION 0.0.1
    WEBOS_APPINFO_VENDOR "Mariotaku Lee"
    WEBOS_APPINFO_ICON ${CMAKE_CURRENT_SOURCE_DIR}/icon.png
    WEBOS_APPINFO_TITLE "QML Video"
    WEBOS_APPINFO_EXTRA "nativeLifeCycleInterfaceVersion=2"
)

target_webos_package(qmlvideo)