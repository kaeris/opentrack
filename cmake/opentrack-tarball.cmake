string(TIMESTAMP filename-date "%Y%m%d")
set(filename-ostype ${CMAKE_SYSTEM_NAME})
get_git_head_revision(filename-branch_0 filename-hash_0)
if(filename-hash_0)
    string(SUBSTRING "${filename-hash_0}" 0 7 filename-hash)
endif()
string(REPLACE "refs/heads/" "" filename-branch_1 "${filename-branch_0}")
string(REPLACE "/" "-" filename-branch "${filename-branch_1}")
set(filename_0 "${OPENTRACK_COMMIT}")
set(filename_1)
if (NOT OPENTRACK_TAG_EXACT STREQUAL OPENTRACK_COMMIT)
    string(TIMESTAMP filename_1 "-%Y%m%d%H%M%S")
endif()
set(filename "${CMAKE_BINARY_DIR}/${filename_0}${filename_1}.zip")

add_custom_target(tarball-real)
add_custom_target(tarball-real2)
add_custom_command(TARGET tarball-real COMMAND cmake -P ${CMAKE_SOURCE_DIR}/cmake/tarball.cmake)

add_custom_command(TARGET tarball-real2 COMMAND /usr/bin/env sh
    "${CMAKE_SOURCE_DIR}/make-tar.sh" "${CMAKE_INSTALL_PREFIX}"
    "${filename}" "${CMAKE_BINARY_DIR}")
add_custom_target(tarball DEPENDS tarball-real)
