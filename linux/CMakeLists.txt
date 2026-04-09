cmake_minimum_required(VERSION 3.10)
set(PROJECT_NAME "hid_listener")
project(${PROJECT_NAME} LANGUAGES CXX)

set(PLUGIN_NAME "hid_listener_plugin")

find_package(X11 REQUIRED)

# Get absolute path to shared folder
get_filename_component(SHARED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../shared" ABSOLUTE)

include_directories("${CMAKE_CURRENT_SOURCE_DIR}" "${SHARED_DIR}")

add_library(${PLUGIN_NAME} SHARED
  "hid_listener_plugin.cpp"
  "hid_listener_plugin_linux.cpp"
)

set_target_properties(${PLUGIN_NAME} PROPERTIES
  OUTPUT_NAME "hid_listener"
  POSITION_INDEPENDENT_CODE ON
)

target_compile_options(${PLUGIN_NAME} PRIVATE -Wall -fPIC)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)

target_include_directories(${PLUGIN_NAME} PUBLIC
  "${CMAKE_CURRENT_SOURCE_DIR}/include"
  "${SHARED_DIR}"
  ${X11_INCLUDE_DIR})

target_link_libraries(${PLUGIN_NAME} PRIVATE flutter ${X11_LIBRARIES} ${X11_Xi_LIB})

set(hid_listener_bundled_libraries "" PARENT_SCOPE)