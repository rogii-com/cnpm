cmake_minimum_required(
    VERSION
    3.9.6
)

project(
    CMakeNastyPackageManager
    LANGUAGES
        NONE
)

enable_testing()

add_subdirectory(
    emptyTag
)

add_subdirectory(
    twoEmptyTags
)

add_subdirectory(
    defaultUrlList
)

file(
    MAKE_DIRECTORY
        ${PROJECT_BINARY_DIR}/severalAddPackage
)

add_test(
    NAME
        severalAddPackage
    COMMAND
        ${CMAKE_COMMAND}
        -G
        ${CMAKE_GENERATOR}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCNPM_ROOT=${CMAKE_SOURCE_DIR}/..
        ${PROJECT_SOURCE_DIR}/severalAddPackage
    WORKING_DIRECTORY
        ${PROJECT_BINARY_DIR}/severalAddPackage
)
