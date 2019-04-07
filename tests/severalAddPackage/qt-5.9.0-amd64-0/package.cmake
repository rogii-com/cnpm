add_executable(
    Qt5::package_cmake
    IMPORTED
)

set_target_properties(
    Qt5::package_cmake
    PROPERTIES
        IMPORTED_LOCATION
            "${CMAKE_CURRENT_LIST}"
)

install(
    FILES
        $<TARGET_FILE:Qt5::package_cmake>
    DESTINATION
        .
    COMPONENT
        CNPM_RESOURCE
)
