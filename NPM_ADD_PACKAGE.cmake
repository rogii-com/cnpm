# yes, all info is stored in global vars...
set(
    NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_NAMES
    ""
)

set(
    NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_VERSIONS
    ""
)

set(
    NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_ARCHITECTURES
    ""
)

set(
    NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_NUMBERS
    ""
)

set(
    NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_TAGS
    ""
)

function(
    NPM_ADD_PACKAGE
)
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

    if(
        NOT NPM_ARGS_NAME
        OR NOT NPM_ARGS_VERSION
    )
        message(
            FATAL_ERROR
            "NPM_ADD_PACKAGE: NAME and VERSION are required arguments."
        )
    endif()

    if(NPM_ARGS_UNPARSED_ARGUMENTS)
        message(
            FATAL_ERROR
            "NPM_ADD_PACKAGE: there are redundant arguments: '${NPM_ARGS_UNPARSED_ARGUMENTS}'."
        )
    endif()

    if(NPM_ARGS_ARCHITECTURE)
        set(
            ARCH
            "${NPM_ARGS_ARCHITECTURE}"
        )
    else()
        set(
            ARCH
            "x86"
        )

        if(${CMAKE_SIZEOF_VOID_P} EQUAL 8)
            set(
                ARCH
                "amd64"
            )
        endif()
    endif()

    set(
        BUILD
        0
    )
    if(NPM_ARGS_BUILD_NUMBER)
        set(
            BUILD
            "${NPM_ARGS_BUILD_NUMBER}"
        )
    endif()

    set(
        TAG
        ""
    )
    if(NPM_ARGS_TAG)
        set(
            TAG
            "${NPM_ARGS_TAG}"
        )
    endif()

    set(
        COUNT
        0
    )
    if(DEFINED NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_COUNT)
        set(
            COUNT
            ${NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_COUNT}
        )
    endif()

    if(COUNT GREATER 0)
        set(
            NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_NAMES
            "${NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_NAMES};${NPM_ARGS_NAME}"
            PARENT_SCOPE
        )
    else()
        set(
            NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_NAMES
            "${NPM_ARGS_NAME}"
            PARENT_SCOPE
        )
    endif()

    if(COUNT GREATER 0)
        set(
            NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_VERSIONS
            "${NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_VERSIONS};${NPM_ARGS_VERSION}"
            PARENT_SCOPE
        )
    else()
        set(
            NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_VERSIONS
            "${NPM_ARGS_VERSION}"
            PARENT_SCOPE
        )
    endif()

    if(COUNT GREATER 0)
        set(
            NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_ARCHITECTURES
            "${NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_ARCHITECTURES};${ARCH}"
            PARENT_SCOPE
        )
    else()
        set(
            NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_ARCHITECTURES
            "${ARCH}"
            PARENT_SCOPE
        )
    endif()

    if(COUNT GREATER 0)
        set(
            NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_NUMBERS
            "${NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_NUMBERS};${BUILD}"
            PARENT_SCOPE
        )
    else()
        set(
            NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_NUMBERS
            "${BUILD}"
            PARENT_SCOPE
        )
    endif()

    if(COUNT GREATER 0)
        set(
            NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_TAGS
            "${NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_TAGS};${TAG}"
            PARENT_SCOPE
        )
    else()
        set(
            NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_TAGS
            "${TAG}"
            PARENT_SCOPE
        )
    endif()

    math(
        EXPR
            COUNT
            "${COUNT} + 1"
    )
    set(
        NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_COUNT
        ${COUNT}
        PARENT_SCOPE
    )
endfunction()
