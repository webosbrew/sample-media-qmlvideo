cmake_minimum_required(VERSION 3.1)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

project(qmlvideo LANGUAGES C CXX)

# these calls create special `PkgConfig::<MODULE>` variables
find_package(Qt5 REQUIRED COMPONENTS Core Multimedia Quick REQUIRED)

set(EXECUTABLE_NAME "qmlvideo")

set(BASE_SRC
    "main.cpp"
)

set(QRC_SRC
    "qml.qrc"
)

add_executable(${EXECUTABLE_NAME} ${BASE_SRC} ${QRC_SRC})

set_target_properties(${EXECUTABLE_NAME} PROPERTIES
    CXX_STANDARD                11
    CXX_STANDARD_REQUIRED       ON
    AUTOMOC                     ON
    AUTORCC                     ON
    RUNTIME_OUTPUT_DIRECTORY    ${CMAKE_BINARY_DIR}/pkg_$ENV{ARCH}/
)

target_link_libraries(${EXECUTABLE_NAME} PRIVATE
 Qt5::Core Qt5::Multimedia Qt5::Quick # QT libraries
)

add_custom_target("webos-package" COMMAND ${CMAKE_SOURCE_DIR}/scripts/package.sh ${CMAKE_SOURCE_DIR}
    DEPENDS ${EXECUTABLE_NAME}
)

add_custom_target("device-install" COMMAND ${CMAKE_SOURCE_DIR}/scripts/device-install.sh ${CMAKE_SOURCE_DIR}
    DEPENDS "webos-package"
)

add_custom_target("device-launch" COMMAND CMAKE_SOURCE_DIR=${CMAKE_SOURCE_DIR} ${CMAKE_SOURCE_DIR}/scripts/device-launch.sh)