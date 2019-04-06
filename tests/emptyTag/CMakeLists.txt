cmake_minimum_required(
    VERSION
    3.9.6
)

project(
    emptyTagTest
    LANGUAGES
        NONE
)

file(
    MAKE_DIRECTORY
        "${emptyTagTest_BINARY_DIR}/test"
)

add_test(
    NAME
        emptyTag
    COMMAND
        "${CMAKE_COMMAND}"
        "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
        "-DCNPM_ROOT=${CMAKE_SOURCE_DIR}/.."
        "${emptyTagTest_SOURCE_DIR}/test"
    WORKING_DIRECTORY
        "${emptyTagTest_BINARY_DIR}/test"
)
