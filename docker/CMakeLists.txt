cmake_minimum_required(VERSION 3.21.0)

project(server-tcp VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_CXX_STANDARD 20)

include(CTest)
enable_testing()

include_directories(
    "/home/vcpkg/installed/x64-linux/include"
)

link_directories(
    "/home/vcpkg/installed/x64-linux/lib"
)

add_executable(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/src/app.cpp)

find_package(Boost REQUIRED COMPONENTS thread)
target_link_libraries(${PROJECT_NAME} PRIVATE Boost::boost Boost::thread)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})

set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})

include(CPack)
