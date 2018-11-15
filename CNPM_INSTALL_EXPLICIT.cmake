set(
    CNPM_INSTALL_EXPLICIT_CURRENT_LIST_DIR
    "${CMAKE_CURRENT_LIST_DIR}"
)

# installs specified components next to the target. See also CNPM_INSTALL_EXPLICIT_ALL
#
# SUBPATH - allows to install components to the relative path to the target's path -
#       $<TARGET_FILE_DIR:${TARGET_NAME}>/${SUBPATH}. Doesn't have to start with slash.
#       For example, a developer wants to have a target binary and a folder 'lib'
#       with all runtime dependencies next to the binary. Then set this argument to
#       'lib' value.
macro(
    CNPM_INSTALL_EXPLICIT
)
    set(
        oneValueArgs
        TARGET_NAME
        SUBPATH
    )

    set(
        multiValueArgs
        COMPONENTS_TO_INSTALL
    )

    cmake_parse_arguments(
        CNPM_ARGS
        ""
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    if(CNPM_ARGS_UNPARSED_ARGUMENTS)
        message(
            FATAL_ERROR
            "CNPM_INSTALL_EXPLICIT: there are redundant arguments: '${CNPM_ARGS_UNPARSED_ARGUMENTS}'."
        )
    endif()

    add_custom_command(
        TARGET
            ${CNPM_ARGS_TARGET_NAME}
        POST_BUILD
        COMMAND
            "${CMAKE_COMMAND}" -DTARGET_FILE_PATH=$<TARGET_FILE_DIR:${CNPM_ARGS_TARGET_NAME}> -DTARGET_NAME=${CNPM_ARGS_TARGET_NAME} -P "${CNPM_INSTALL_EXPLICIT_CURRENT_LIST_DIR}/installHelper.cmake"
        WORKING_DIRECTORY
            "${CMAKE_CURRENT_BINARY_DIR}"
    )

    install(
        CODE
            "file(
                READ
                    \"${CMAKE_CURRENT_BINARY_DIR}/target_path-${CNPM_ARGS_TARGET_NAME}.txt\"
                    TARGET_PATH
            )"
    )

    set(
        NEWLINE_SYMBOL
        "\\n"
    )
    if(WIN32)
        set(
            NEWLINE_SYMBOL
            "\\r\\n"
        )
    endif()

    set(
        SUBPATH
        ""
    )
    if(DEFINED CNPM_ARGS_SUBPATH)
        set(
            SUBPATH
            "/${CNPM_ARGS_SUBPATH}"
        )
    endif()

    foreach(COMPONENT ${CNPM_ARGS_COMPONENTS_TO_INSTALL})
        install(
            CODE
                "execute_process(
                    COMMAND
                        \"${CMAKE_COMMAND}\" -DCMAKE_INSTALL_PREFIX:PATH=\${TARGET_PATH}${SUBPATH} -DCOMPONENT=${COMPONENT} -P \"${CMAKE_BINARY_DIR}/cmake_install.cmake\"
                    OUTPUT_VARIABLE
                        CNPM_STDOUTPUT
                )
                set(
                    CNPM_STDOUTPUT_ALL
                    \"\${CNPM_STDOUTPUT_ALL}${NEWLINE_SYMBOL}\${CNPM_STDOUTPUT}\"
                )"
        )
    endforeach()

    install(
        CODE
            "message(
                STATUS
                \"\${CNPM_STDOUTPUT_ALL}\"
            )"
    )
endmacro()

macro(
    CNPM_INSTALL_EXPLICIT_ALL
)
    set(
        oneValueArgs
        TARGET_NAME
        SUBPATH
    )

    cmake_parse_arguments(
        CNPM_ARGS
        ""
        "${oneValueArgs}"
        ""
        ${ARGN}
    )

    if(CNPM_ARGS_UNPARSED_ARGUMENTS)
        message(
            FATAL_ERROR
            "CNPM_INSTALL_EXPLICIT_ALL: there are redundant arguments: '${CNPM_ARGS_UNPARSED_ARGUMENTS}'."
        )
    endif()

    CNPM_INSTALL_EXPLICIT(
        TARGET_NAME
            ${CNPM_ARGS_TARGET_NAME}
        SUBPATH
            "${CNPM_ARGS_SUBPATH}"
        COMPONENTS_TO_INSTALL
            "CNPM_RUNTIME;CNPM_RESOURCE"
    )
endmacro()
