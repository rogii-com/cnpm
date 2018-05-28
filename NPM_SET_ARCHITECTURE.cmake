#
# ARGV0 (ARCHITECTURE) - name of a variable where the result
#       string will be stored.
# ARGV1 (optional) - explicitly specify architecture.
# ARGV2 (optional) - contains the status code.
#
# Status (error) codes:
#   0 - success
#   1 - architecture '${ARGV1}' is not supported
#
function(
    NPM_SET_ARCHITECTURE
    ARCHITECTURE
)
    if(${ARGC} GREATER 2)
        set(
            ${ARGV2}
            0
        )
    endif()

    if(${ARGC} LESS 2)
        # TODO: use CMAKE_SIZEOF_VOID_P
        set(
            ${ARCHITECTURE}
            x86
            PARENT_SCOPE
        )

        return()
    endif()

    string(
        TOLOWER
            ${ARGV1}
            DESIRED_ARCHITECTURE
    )

    if(
        NOT (${DESIRED_ARCHITECTURE} STREQUAL "x86")
        AND NOT (${DESIRED_ARCHITECTURE} STREQUAL "amd64")
        AND NOT (${DESIRED_ARCHITECTURE} STREQUAL "noarch")
    )
        if(${ARGC} LESS 3)
            return()
        endif()

        set(
            ${ARGV2}
            1
        )

        return()
    endif()

    set(
        ${ARCHITECTURE}
        ${DESIRED_ARCHITECTURE}
        PARENT_SCOPE
    )
endfunction()
