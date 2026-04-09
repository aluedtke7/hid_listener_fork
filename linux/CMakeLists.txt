cmake_minimum_required(VERSION 3.10)
set(PROJECT_NAME "hid_listener")
project(${PROJECT_NAME} LANGUAGES CXX)

set(PLUGIN_NAME "hid_listener_plugin")

find_package(X11 REQUIRED)

include_directories("${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}/include" "${CMAKE_CURRENT_SOURCE_DIR}/../shared")

add_library(${PLUGIN_NAME} SHARED
  "${CMAKE_CURRENT_SOURCE_DIR}/../shared/dart_api_dl.c"
  "hid_listener_plugin.cpp"
  "hid_listener_plugin_linux.cpp"
)

set_target_properties(${PLUGIN_NAME} PROPERTIES
  OUTPUT_NAME "hid_listener"
  POSITION_INDEPENDENT_CODE ON
  VISIBILITY_INLINES_HIDDEN OFF
)

# Don't hide symbols from dart_api_dl.c
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET default)

target_compile_options(${PLUGIN_NAME} PRIVATE -Wall -fPIC)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)

target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include"
  "${CMAKE_CURRENT_SOURCE_DIR}/../shared"
  ${X11_INCLUDE_DIR})

target_link_libraries(${PLUGIN_NAME} PRIVATE flutter ${X11_LIBRARIES} ${X11_Xi_LIB})

set(hid_listener_bundled_libraries "" PARENT_SCOPE)