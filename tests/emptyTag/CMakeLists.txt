cmake_minimum_required(
    VERSION
    3.9.6
)

cmake_policy(
    SET
    CMP0043 OLD
)

project(
    emptyTagTest
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
