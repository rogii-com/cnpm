cmake_minimum_required(
    VERSION
    3.9.6
)

project(
    test
)

include(
    "${CNPM_SOURCE_ROOT}/NastyPackageManager.cmake"
)

NPM_ADD_PACKAGE(
    NAME
        Qt
    VERSION
        5.9.6
    ARCHITECTURE
        amd64
    BUILD_NUMBER
        4
)

NPM_ADD_PACKAGE(
    NAME
        Manual
    VERSION
        1.0
    ARCHITECTURE
        AnyArch
)

NPM_ADD_PACKAGE(
    NAME
        GTest
    VERSION
        1.8.0
    ARCHITECTURE
        x86
    BUILD_NUMBER
        3
    TAG
        "sdk14393_vs2015up3"
)

NPM_ADD_PACKAGE(
    NAME
        zlib
    VERSION
        1.2.8
    ARCHITECTURE
        amd64
    BUILD_NUMBER
        1
    TAG
        "sdk14393_vs2015up3"
)

set(
    NPM_ONLY
    1
)

# URLs may be specified on a separate lines/separated by space-symbols or
# as a list or even combined
NPM_PREPARE_PACKAGES(
    DEFAULT_REPOSITORY_URLS
        "file:///${PROJECT_SOURCE_DIR};file:///${PROJECT_SOURCE_DIR}/3repository"
        "file:///${PROJECT_SOURCE_DIR}/private_repository"
        #"file:///${PROJECT_SOURCE_DIR};file:///${PROJECT_SOURCE_DIR}/3repository;file:///${PROJECT_SOURCE_DIR}/private_repository"
)

