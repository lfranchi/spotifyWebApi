
find_path(LIBMYSQLCLIENT_INCLUDE_DIR mysql_time.h PATH_SUFFIXES mysql)
find_library(LIBMYSQLCLIENT_LIBRARY NAMES mysqlclient mysqlclient_r)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(mysqlclient DEFAULT_MSG LIBMYSQLCLIENT_LIBRARY LIBMYSQLCLIENT_INCLUDE_DIR)
set(LIBMYSQLCLIENT_LIBRARIES ${LIBMYSQLCLIENT_LIBRARY})
mark_as_advanced(LIBMYSQLCLIENT_LIBRARY LIBMYSQLCLIENT_INCLUDE_DIR)

if(LIBMYSQLCLIENT_LIBRARY AND LIBMYSQLCLIENT_INCLUDE_DIR)
   set(LIBMYSQLCLIENT_FOUND TRUE)
endif()