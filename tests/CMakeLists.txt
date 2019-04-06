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
