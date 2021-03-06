#-------------------------------------------------------------------------------------------
# Intel compiler options
#-------------------------------------------------------------------------------------------

# Diagnostic flags
target_compile_options(${PROJECT_NAME} PRIVATE
    -w3 -Wall -Wremarks -Wcheck -Weffc++
    -Wuninitialized -Wdeprecated -Wpointer-arith

    # Suppress warnings
    -diag-disable=383,869,1011,1418,1419,2012,2013,2015,2021,2304,11074,11076
)

# Compiler flags
target_compile_options(${PROJECT_NAME} PRIVATE
    -no-intel-extensions
    $<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics> -ffunction-sections -fdata-sections
)

# Optional flags
if(NOT ENABLE_RTTI)
    target_compile_options(${PROJECT_NAME} PRIVATE -fno-rtti)
endif()

if(NOT ENABLE_EXCEPTIONS)
    target_compile_options(${PROJECT_NAME} PRIVATE -fno-exceptions)
endif()

#-------------------------------------------------------------------------------------------
# Link options
#-------------------------------------------------------------------------------------------

# Linker flags
target_link_options(${PROJECT_NAME} PRIVATE -no-intel-extensions
    # Warnings
    -Wl,--warn-common
    -Wl,--warn-alternate-em

    # Common
    -Wl,-O3
    -Wl,--relax
    -Wl,--as-needed
    -Wl,--gc-sections
    -Wl,--no-undefined
    -Wl,--no-allow-shlib-undefined
    -Wl,--check-sections

    # Build type RelWithDebInfo
    $<$<CONFIG:RelWithDebInfo>:
        -Wl,--discard-all
        -Wl,--compress-debug-sections=zlib
    >

    # Build type Release, MinSizeRel
    $<$<OR:$<CONFIG:Release>,$<CONFIG:MinSizeRel>>:
        -Wl,--discard-all
        -Wl,--strip-all
    >
)

# Libraries linking
if(LINK_LIB_INTEL)
    target_link_libraries(${PROJECT_NAME} PRIVATE -static-intel)
endif()

if(LINK_LIB_GCC)
    target_link_libraries(${PROJECT_NAME} PRIVATE -static-libgcc)
endif()

if(LINK_LIB_STDCPP)
    target_link_libraries(${PROJECT_NAME} PRIVATE -static-libstdc++)
endif()

if(LINK_LIB_C)
    target_link_libraries(${PROJECT_NAME} PRIVATE c)
endif()

if(LINK_LIB_M)
    target_link_libraries(${PROJECT_NAME} PRIVATE m)
endif()

if(LINK_LIB_DL)
    target_link_libraries(${PROJECT_NAME} PRIVATE ${CMAKE_DL_LIBS})
endif()
