#
# ARGV0 - list of URL of repositories where a package
#   will be downloaded from.
# ARGV1 (NAME) - name of a package to prepare.
# ARGV2 (VERSION) - version of the package.
# ARGV3 (optional) - explicitly specified architecture.
#       By default used one determined with help of CMAKE_SIZEOF_VOID_P.
# ARGV4 (optional) - explicitly specified build number of the package.
#       The default value is 0.
# ARGV5 (optional) - explicitly specified tag. A tag is an
#       arbitrary string of characters. Usually contains some
#       metainformation about package (for example, a compiler
#       the package was built with (msvc14/msvs15); or
#       branch name (master)). The default value is an empty string.
# ARGV6 (optional) - name of a variable where to store the status
#       code
#
# Status (error) codes:
#       0 - success
#       1 - SET_ARCHITECTURE failed
#
function(
    NPM_PREPARE_PACKAGE
)
    set(
        oneValueArgs
        PACKAGE_NAME FORCE ROOT ARCHIVE_TYPE
    )

    set(
        multiValueArgs
        REPOSITORY_URLS
    )

    cmake_parse_arguments(
        NPM_ARGS
        ""
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    # required args
    if(NOT NPM_ARGS_PACKAGE_NAME)
        message(
            FATAL_ERROR
            "NPM_PREPARE_PACKAGE: PACKAGE_NAME is a required argument."
        )
    endif()

    if(NPM_ARGS_UNPARSED_ARGUMENTS)
        message(
            FATAL_ERROR
            "NPM_PREPARE_PACKAGE: there are redundant arguments: '${NPM_ARGS_UNPARSED_ARGUMENTS}'."
        )
    endif()

    message(
        STATUS
        "ARGV = ${ARGV}"
    )


    # optional args
    set(
        FORCE
        FALSE
    )
    if(NPM_ARGS_FORCE)
        set(
            FORCE
            TRUE
        )
    endif()

    set(
        ROOT
        "${CMAKE_BINARY_DIR}/3rd_party"
    )
    if(NPM_ARGS_ROOT)
        set(
            ROOT
            "${NPM_ARGS_ROOT}"
        )
        # TODO: remove redundant '/' from the end
    endif()

    set(
        ARCHIVE_TYPE
        7z
    )
    if(NPM_ARGS_ARCHIVE_TYPE)
        set(
            ARCHIVE_TYPE
            ${NPM_ARGS_ARCHIVE_TYPE}
        )
    endif()

    set(
        OUTPUT_PATH
        "${ROOT}/${NPM_ARGS_PACKAGE_NAME}"
    )

    set(
        OUTPUT_FILEPATH
        "${ROOT}/${NPM_ARGS_PACKAGE_NAME}.${ARCHIVE_TYPE}"
    )

    message(
        STATUS
        "OUTPUT_PATH = ${OUTPUT_PATH}; OUTPUT_FILEPATH = ${OUTPUT_FILEPATH}"
    )

    if(FORCE)
        file(
            REMOVE
            "${OUTPUT_FILEPATH}"
        )
        file(
            REMOVE_RECURSE
            "${OUTPUT_PATH}/"
        )
    endif()

    if(EXISTS "${OUTPUT_PATH}/")
        return()
    endif()

    if(NOT EXISTS "${OUTPUT_FILEPATH}")
        foreach(
            REPOSITORY
            ${NPM_ARGS_REPOSITORY_URLS}
        )
            set(
                INPUT_PATH
                "${REPOSITORY}/${NPM_ARGS_PACKAGE_NAME}.${ARCHIVE_TYPE}"
            )

            message(
                STATUS
                "INPUT_PATH = ${INPUT_PATH}"
            )

            file(
                DOWNLOAD
                    ${INPUT_PATH}
                    "${OUTPUT_FILEPATH}"
                SHOW_PROGRESS
                STATUS
                    DOWNLOAD_STATUS
                TIMEOUT
                    1800
            )

            list(
                GET
                    DOWNLOAD_STATUS
                    0
                    DOWNLOAD_STATUS_CODE
            )

            message(
                STATUS
                "DOWNLOAD_STATUS = ${DOWNLOAD_STATUS}"
            )

            if(NOT DOWNLOAD_STATUS_CODE EQUAL 0)
                # currently (3.9.5) cmake -E tar ... doesn't fail
                # if an archive has zero-length and cannot be extracted
                file(
                    REMOVE
                    "${OUTPUT_FILEPATH}"
                )
                continue()
            endif()

            break()
        endforeach()
    endif()

    message(
        STATUS
        "after foreach; ${ROOT}/; ${CMAKE_COMMAND}; ${OUTPUT_FILEPATH}"
    )

    execute_process(
        COMMAND
            "${CMAKE_COMMAND}" -E tar xvf "${OUTPUT_FILEPATH}"
        WORKING_DIRECTORY
            "${ROOT}/"
        RESULT_VARIABLE
            EXTRACTING_STATUS
    )

    message(
        STATUS
        "after extracting"
    )

    if(NOT EXTRACTING_STATUS EQUAL 0)
        message(
            FATAL_ERROR
            "NPM_PREPARE_PACKAGE: Failed to extract a package (${NPM_ARGS_PACKAGE_NAME}); status = ${EXTRACTING_STATUS}"
        )
    endif()
endfunction()
