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

include(
    "${CNPM_ROOT}/NastyPackageManager.cmake"
)

NPM_ADD_PACKAGE(
    NAME
        Qt
    VERSION
        5.9.0
    ARCHITECTURE
        amd64
)

set(
    NPM_ROOT
    "${CMAKE_SOURCE_DIR}"
)

set(
    NPM_ONLY
    1
)

NPM_PREPARE_PACKAGES()

