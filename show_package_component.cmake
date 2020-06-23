include(${CMAKE_CURRENT_LIST_DIR}/CNPM_ADD_PACKAGE2.cmake)

if(IS_ABSOLUTE ${FILEPATH})
    include(${FILEPATH})
else()
    include(${CMAKE_CURRENT_LIST_DIR}/${FILEPATH})
endif()

