function(NPM_PREPARE_PACKAGE)
    set(
        oneValueArgs
        PACKAGE_NAME FORCE ROOT TMP ARCHIVE_TYPE
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
            "CNPM_PREPARE_PACKAGE: PACKAGE_NAME is a required argument."
        )
    endif()

    if(NPM_ARGS_UNPARSED_ARGUMENTS)
        message(
            FATAL_ERROR
            "CNPM_PREPARE_PACKAGE: there are redundant arguments: '${NPM_ARGS_UNPARSED_ARGUMENTS}'."
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

    set(
        TMP_OUTPUT_FILEPATH
        "${NPM_ARGS_TMP}/${NPM_ARGS_PACKAGE_NAME}.${ARCHIVE_TYPE}"
    )

    message(
        STATUS
        "OUTPUT_PATH = ${OUTPUT_PATH}; OUTPUT_FILEPATH = ${OUTPUT_FILEPATH}; TMP_OUTPUT_FILEPATH = ${TMP_OUTPUT_FILEPATH}"
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

    set(
        ADVICE_TEXT
        ""
    )

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
                    "${TMP_OUTPUT_FILEPATH}"
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

            # we're still alive so move the file
            file(
                RENAME
                ${TMP_OUTPUT_FILEPATH}
                ${OUTPUT_FILEPATH}
            )

            set(
                ADVICE_TEXT
                "The package has been recently downloaded. We recommend you to additionally check the package file on the server."
            )

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
            "${NPM_ARGS_TMP}"
        RESULT_VARIABLE
            EXTRACTING_STATUS
        OUTPUT_VARIABLE
            OUTPUT
        ERROR_VARIABLE
            ERROR
    )

    message(
        STATUS
        "stdout = ${OUTPUT}"
    )

    message(
        STATUS
        "stderr = ${ERROR}"
    )

    message(
        STATUS
        "after extracting; status = ${EXTRACTING_STATUS}"
    )

    # see cmake sources (Source/cmSystemTools.cxx +1483)
    string(
        FIND
        "${ERROR}"
        "cmake -E tar: error: "
        ERROR_INDEX
    )

    if(NOT EXTRACTING_STATUS EQUAL 0
        OR NOT ERROR_INDEX EQUAL -1
    )
        file(
            REMOVE
            "${OUTPUT_FILEPATH}"
        )

        message(
            FATAL_ERROR
            "CNPM_PREPARE_PACKAGE: Failed to extract corrupted package (${NPM_ARGS_PACKAGE_NAME})."
            " '${OUTPUT_FILEPATH}' was deleted."
            " ${ADVICE_TEXT}"
        )
    endif()

    # still alive so move the folder
    file(
        RENAME
        "${NPM_ARGS_TMP}/${NPM_ARGS_PACKAGE_NAME}"
        "${OUTPUT_PATH}"
    )
endfunction()
