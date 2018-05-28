function(
    NPM_GENERATE_PACKAGE_NAME
    RESULT_VARIABLE
    NAME
    VERSION
    ARCHITECTURE
    BUILD_NUMBER
    TAG
)
    set(
        PACKAGE_NAME
        "${NAME}-${VERSION}-${ARCHITECTURE}-${BUILD_NUMBER}${TAG}"
    )

    string(
        TOLOWER
            "${PACKAGE_NAME}"
            LOWERED_PACKAGE_NAME
    )

    set(
        ${RESULT_VARIABLE}
        "${LOWERED_PACKAGE_NAME}"
        PARENT_SCOPE
    )
endfunction()
