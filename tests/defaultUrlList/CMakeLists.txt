cmake_minimum_required(
    VERSION
    3.9.6
)

set(
    NAME
    defaultUrlList
)

project(
    "${NAME}Test"
)

file(
    MAKE_DIRECTORY
        "${PROJECT_BINARY_DIR}/test"
)

add_test(
    NAME
        ${NAME}
    COMMAND
        "${CMAKE_COMMAND}"
        "-G"
        "${CMAKE_GENERATOR}"
        "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
        "-DCNPM_ROOT=${CMAKE_SOURCE_DIR}/.."
        "${PROJECT_SOURCE_DIR}/test"
    WORKING_DIRECTORY
        "${PROJECT_BINARY_DIR}/test"
)
