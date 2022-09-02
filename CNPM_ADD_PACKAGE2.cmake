function(CNPM_ADD_PACKAGE)
    set(
        oneValueArgs
        NAME VERSION ARCHITECTURE BUILD_NUMBER TAG
    )

    cmake_parse_arguments(
        NPM_ARGS
        ""
        "${oneValueArgs}"
        ""
        ${ARGN}
    )

    string(
        TOUPPER
            "${SHOW_ARGUMENT}"
            SHOW_ARGUMENT
    )
    IF (NOT DEFINED SEARCH)
    foreach(argument ${oneValueArgs})
        if(argument STREQUAL SHOW_ARGUMENT)
            execute_process(
                COMMAND
                    ${CMAKE_COMMAND}
                    -E
                    echo_append
                    "${NPM_ARGS_${SHOW_ARGUMENT}}"
                WORKING_DIRECTORY
                    ${CMAKE_CURRENT_LIST_DIR}
            )

            return()
        endif()
    endforeach()

    message(
        FATAL_ERROR
        "Unknown argument name: '${SHOW_ARGUMENT}'"
    )
    else()
        string(
            TOUPPER
                "${SEARCH}"
                SEARCH
        )
        string(
            TOUPPER
                "${NPM_ARGS_NAME}"
                PACKAGE_NAME
        )
        if("${PACKAGE_NAME}" STREQUAL SEARCH) 
        execute_process(
            COMMAND
                ${CMAKE_COMMAND}
                    -E
                    echo_append
                    "${NPM_ARGS_${SHOW_ARGUMENT}}"
                    WORKING_DIRECTORY
                    ${CMAKE_CURRENT_LIST_DIR}
                )
            return()
        endif()
    endif()
endfunction()

