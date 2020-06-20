macro(
    NPM_PREPARE_PACKAGES
)
    if(DEFINED P)
        set(
            CNPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_OLD_P
            "${P}"
        )
    endif()

    set(
        P
        "CNPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_"
    )

    set(
        oneValueArgs
    )

    set(
        multiValueArgs
        DEFAULT_REPOSITORY_URLS
    )

    cmake_parse_arguments(
        NPM_ARGS
        ""
        "${oneValueArgs}"
        "${multiValueArgs}"
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

    foreach(${P}INDEX RANGE 2)
        string(
            TIMESTAMP
            ${P}TIMESTAMP
            "%s"
        )

        string(
            RANDOM
            RANDOM_SEED
            ${${P}TIMESTAMP}
            ${P}TMP
        )

        set(
            ${P}TMP
            ${ROOT}/tmp-${${P}TMP}
        )

        if(NOT EXISTS ${${P}TMP})
            break()
        endif()

        unset(${P}TMP)
    endforeach()

    if(NOT DEFINED ${P}TMP)
        message(
            FATAL_ERROR
            "CNPM_PREPARE_PACKAGES: failed to create temporary subfolder in the root after several attempts."
            " Please try again later."
        )
    endif()

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
            TMP
                ${${P}TMP}
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

    file(
        REMOVE_RECURSE
        ${${P}TMP}
    )

    if(DEFINED CNPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_OLD_P)
        set(
            P
            "${CNPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_OLD_P}"
        )
    endif()

    if(ONLY)
        return()
    endif()
endmacro()
