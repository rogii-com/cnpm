macro(CNPM_PREPARE_PACKAGES)
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

    cmake_parse_arguments(
        NPM_ARGS
        ""
        ""
        "DEFAULT_REPOSITORY_URLS"
        ${ARGN}
    )

    if(NPM_ARGS_UNPARSED_ARGUMENTS)
        message(
            FATAL_ERROR
            "CNPM_PREPARE_PACKAGES: there are redundant arguments: '${NPM_ARGS_UNPARSED_ARGUMENTS}'."
        )
    endif()

    if(CNPM_REPOSITORY_URLS)
        set(
            ${P}REPOSITORY_URLS
            "${CNPM_REPOSITORY_URLS};${NPM_ARGS_DEFAULT_REPOSITORY_URLS}"
        )
    else()
        set(
            ${P}REPOSITORY_URLS
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
        CNPM_REPOSITORY_URLS
        CACHE
    )

    message(
        STATUS
        "REPOSITORY_URLS = ${${P}REPOSITORY_URLS}"
    )

    # optional args
    set(
        ${P}FORCE
        FALSE
    )
    if(CNPM_FORCE)
        set(
            ${P}FORCE
            TRUE
        )
        unset(
            CNPM_FORCE
            CACHE
        )
    endif()

    set(
        ${P}ROOT
        "${CMAKE_BINARY_DIR}/3rd_party"
    )
    if(CNPM_ROOT)
        file(
            TO_CMAKE_PATH
            "${CNPM_ROOT}"
            ${P}ROOT
        )
    else()
        if(DEFINED ENV{CNPM_ROOT})
            file(
                TO_CMAKE_PATH
                "$ENV{CNPM_ROOT}"
                ${P}ROOT
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
            ${${P}ROOT}/tmp-${${P}TMP}
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

    file(
        MAKE_DIRECTORY
        ${${P}TMP}
    )

    set(
        ${P}ONLY
        FALSE
    )
    if(CNPM_ONLY)
        set(
            ${P}ONLY
            TRUE
        )
        unset(
            CNPM_ONLY
            CACHE
        )
    endif()

    set(
        ${P}INDEX
        0
    )
    while(${${P}INDEX} LESS ${NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_COUNT})
        list(
            GET
                NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_NAMES
                ${${P}INDEX}
                ${P}NAME
        )

        list(
            GET
                NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_VERSIONS
                ${${P}INDEX}
                ${P}VERSION
        )

        list(
            GET
                NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_ARCHITECTURES
                ${${P}INDEX}
                ${P}ARCHITECTURE
        )

        list(
            GET
                NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_NUMBERS
                ${${P}INDEX}
                ${P}BUILD
        )

        set(
            ${P}TAG
            ""
        )

        list(
            LENGTH
                NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_TAGS
                ${P}TAGS_COUNT
        )
        if(${P}TAGS_COUNT GREATER 0)
            list(
                GET
                    NPM_4D2BB0BB_9AFC_4A44_B81A_8F025831AC8C_TAGS
                    ${${P}INDEX}
                    ${P}TAG
            )
        endif()

        message(
            STATUS
            "NAME = ${${P}NAME}; VERSION = ${${P}VERSION}; ARCHITECTURE = ${${P}ARCHITECTURE}; BUILD = ${${P}BUILD}; TAG = ${${P}TAG}"
        )

        NPM_GENERATE_PACKAGE_NAME(
            ${P}PACKAGE_NAME
            ${${P}NAME}
            ${${P}VERSION}
            ${${P}ARCHITECTURE}
            ${${P}BUILD}
            "${${P}TAG}"
        )

        NPM_PREPARE_PACKAGE(
            PACKAGE_NAME
                ${${P}PACKAGE_NAME}
            REPOSITORY_URLS
                ${${P}REPOSITORY_URLS}
            FORCE
                ${${P}FORCE}
            ROOT
                ${${P}ROOT}
            TMP
                ${${P}TMP}
            ARCHIVE_TYPE
                7z
        )

        # yes, we strictly bound to NPM_PREPARE_PACKAGE.
        # Frankly speaking the function is an internal one is not intended
        # to be used by users
        include("${${P}ROOT}/${${P}PACKAGE_NAME}/package.cmake")

        MATH(
            EXPR
                ${P}INDEX
                "${${P}INDEX} + 1"
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

    if(${P}ONLY)
        return()
    endif()
endmacro()
