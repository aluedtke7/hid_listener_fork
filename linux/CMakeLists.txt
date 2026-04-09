# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

# Project-level configuration.
set(PROJECT_NAME "hid_listener")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed.
set(PLUGIN_NAME "hid_listener_plugin")

# Define the plugin library target. Its name must not be changed (see comment
# on PLUGIN_NAME above).
#
# Any new source files that you add to the plugin should be added here.

find_package(X11 REQUIRED)

add_library(${PLUGIN_NAME} SHARED
  "hid_listener_plugin.cpp"
  "hid_listener_plugin_linux.cpp"
)

set_target_properties(${PLUGIN_NAME} PROPERTIES OUTPUT_NAME "hid_listener")

# Ensure position-independent code for dynamic linking
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Force -fPIC flag for C and C++
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")

apply_standard_settings(${PLUGIN_NAME})

# Symbols are hidden by default to reduce the chance of accidental conflicts
# between plugins. This should not be removed; any symbols that should be
# exported should be explicitly exported with the FLUTTER_PLUGIN_EXPORT macro.
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)

# Source include directories and library dependencies. Add any plugin-specific
# dependencies here.
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include"
  ${X11_INCLUDE_DIR})
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter ${X11_LIBRARIES} ${X11_Xi_LIB})

# List of absolute paths to libraries that should be bundled with the plugin.
# This list could contain prebuilt libraries, or libraries created by an
# external build triggered from this build file.
set(hid_listener_bundled_libraries
  ""
  PARENT_SCOPE
)
