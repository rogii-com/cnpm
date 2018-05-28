cmake_minimum_required(
    VERSION
    3.9.6
)

cmake_policy(
    SET
    CMP0043 OLD
)

project(
    CMakeNastyPackageManager
)

enable_testing()

add_subdirectory(
    emptyTag
)

add_subdirectory(
    twoEmptyTags
)
