macro(
    NPM_PREPARE_PACKAGES
)
    set(
        oneValueArgs
        DEFAULT_REPOSITORY_URLS
    )

    cmake_parse_arguments(
        NPM_ARGS
        ""
        "${oneValueArgs}"
        ""
        ${ARGN}
    )

    if(NPM_ARGS_UNPARSED_ARGUMENTS)
        message(
            FATAL_ERROR
            "NPM_PREPARE_PACKAGES: there are redundant arguments: '${NPM_ARGS_UNPARSED_ARGUMENTS}'."
        )
    endif()

    if(NPM_REPOSITORY_URLS)
        set(
            REPOSITORY_URLS
            "${NPM_REPOSITORY_URLS};${NPM_ARGS_DEFAULT_REPOSITORY_URLS}"
        )
    else()
        set(
            REPOSITORY_URLS
            "${NPM_ARGS_DEFAULT_REPOSITORY_URLS}"
        )
    endif()

    unset(
        NPM_ARGS_UNPARSED_ARGUMENTS
    )

    unset(
        NPM_ARGS_DEFAULT_REPOSITORY_URLS
    )

    unset(
        NPM_REPOSITORY_URLS
        CACHE
    )

    message(
        STATUS
        "REPOSITORY_URLS = ${REPOSITORY_URLS}"
    )

    # optional args
    set(
        FORCE
        FALSE
    )
    if(NPM_FORCE)
        set(
            FORCE
            TRUE
        )
        unset(
            NPM_FORCE
            CACHE
        )
    endif()

    set(
        ROOT
        "${CMAKE_BINARY_DIR}/3rd_party"
    )
    if(NPM_ROOT)
        file(
            TO_CMAKE_PATH
            "${NPM_ROOT}"
            ROOT
        )
    else()
        if(DEFINED ENV{NPM_ROOT})
            file(
                TO_CMAKE_PATH
                "$ENV{NPM_ROOT}"
                ROOT
            )
        endif()
    endif()
    # TODO: remove redundant '/' from the end

    set(
        ONLY
        FALSE
    )
    if(NPM_ONLY)
        set(
            ONLY
            TRUE
        )
        unset(
            NPM_ONLY
            CACHE
        )
    endif()

    set(
        INDEX
        0
    )
    while(${INDEX} LESS ${NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_COUNT})
        list(
            GET
                NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_NAMES
                ${INDEX}
                NAME
        )

        list(
            GET
                NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_VERSIONS
                ${INDEX}
                VERSION
        )

        list(
            GET
                NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_ARCHITECTURES
                ${INDEX}
                ARCHITECTURE
        )

        list(
            GET
                NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_NUMBERS
                ${INDEX}
                BUILD
        )

        set(
            TAG
            ""
        )

        list(
            LENGTH
                NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_TAGS
                TAGS_COUNT
        )
        if(TAGS_COUNT GREATER 0)
            list(
                GET
                    NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_TAGS
                    ${INDEX}
                    TAG
            )
        endif()

        message(
            STATUS
            "NAME = ${NAME}; VERSION = ${VERSION}; ARCHITECTURE = ${ARCHITECTURE}; BUILD = ${BUILD}; TAG = ${TAG}"
        )

        NPM_GENERATE_PACKAGE_NAME(
            PACKAGE_NAME
            ${NAME}
            ${VERSION}
            ${ARCHITECTURE}
            ${BUILD}
            "${TAG}"
        )

        NPM_PREPARE_PACKAGE(
            PACKAGE_NAME
                ${PACKAGE_NAME}
            REPOSITORY_URLS
                ${REPOSITORY_URLS}
            FORCE
                ${FORCE}
            ROOT
                ${ROOT}
            ARCHIVE_TYPE
                7z
        )

        # yes, we strictly bound to NPM_PREPARE_PACKAGE.
        # Frankly speaking the function is an internal one is not intended
        # to be used by users
        include(
            "${ROOT}/${PACKAGE_NAME}/package.cmake"
        )

        MATH(
            EXPR
                INDEX
                "${INDEX} + 1"
        )
    endwhile()

    if(ONLY)
        return()
    endif()
endmacro()
