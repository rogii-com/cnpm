cmake_minimum_required(
    VERSION
    3.9.6
)

cmake_policy(
    SET
    CMP0043 OLD
)

project(
    twoEmptyTagsTest
)

file(
    MAKE_DIRECTORY
        "${twoEmptyTagsTest_BINARY_DIR}/test"
)

add_test(
    NAME
        twoEmptyTags
    COMMAND
        "${CMAKE_COMMAND}"
        "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
        "-DCNPM_ROOT=${CMAKE_SOURCE_DIR}/.."
        "${twoEmptyTagsTest_SOURCE_DIR}/test"
    WORKING_DIRECTORY
        "${twoEmptyTagsTest_BINARY_DIR}/test"
)
