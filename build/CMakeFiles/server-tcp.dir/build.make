# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "/home/angga/Documents/LEN/ngerjain-project/batch 1/server-tcp"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "/home/angga/Documents/LEN/ngerjain-project/batch 1/server-tcp/build"

# Include any dependencies generated for this target.
include CMakeFiles/server-tcp.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/server-tcp.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/server-tcp.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/server-tcp.dir/flags.make

CMakeFiles/server-tcp.dir/src/app.cpp.o: CMakeFiles/server-tcp.dir/flags.make
CMakeFiles/server-tcp.dir/src/app.cpp.o: ../src/app.cpp
CMakeFiles/server-tcp.dir/src/app.cpp.o: CMakeFiles/server-tcp.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/home/angga/Documents/LEN/ngerjain-project/batch 1/server-tcp/build/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/server-tcp.dir/src/app.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/server-tcp.dir/src/app.cpp.o -MF CMakeFiles/server-tcp.dir/src/app.cpp.o.d -o CMakeFiles/server-tcp.dir/src/app.cpp.o -c "/home/angga/Documents/LEN/ngerjain-project/batch 1/server-tcp/src/app.cpp"

CMakeFiles/server-tcp.dir/src/app.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/server-tcp.dir/src/app.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "/home/angga/Documents/LEN/ngerjain-project/batch 1/server-tcp/src/app.cpp" > CMakeFiles/server-tcp.dir/src/app.cpp.i

CMakeFiles/server-tcp.dir/src/app.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/server-tcp.dir/src/app.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "/home/angga/Documents/LEN/ngerjain-project/batch 1/server-tcp/src/app.cpp" -o CMakeFiles/server-tcp.dir/src/app.cpp.s

# Object files for target server-tcp
server__tcp_OBJECTS = \
"CMakeFiles/server-tcp.dir/src/app.cpp.o"

# External object files for target server-tcp
server__tcp_EXTERNAL_OBJECTS =

server-tcp: CMakeFiles/server-tcp.dir/src/app.cpp.o
server-tcp: CMakeFiles/server-tcp.dir/build.make
server-tcp: /opt/vcpkg/installed/x64-linux/debug/lib/libboost_thread.a
server-tcp: /opt/vcpkg/installed/x64-linux/debug/lib/libboost_atomic.a
server-tcp: /opt/vcpkg/installed/x64-linux/debug/lib/libboost_chrono.a
server-tcp: /opt/vcpkg/installed/x64-linux/debug/lib/libboost_date_time.a
server-tcp: /opt/vcpkg/installed/x64-linux/debug/lib/libboost_container.a
server-tcp: /opt/vcpkg/installed/x64-linux/debug/lib/libboost_regex.a
server-tcp: /opt/vcpkg/installed/x64-linux/debug/lib/libboost_exception.a
server-tcp: /opt/vcpkg/installed/x64-linux/debug/lib/libboost_system.a
server-tcp: CMakeFiles/server-tcp.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="/home/angga/Documents/LEN/ngerjain-project/batch 1/server-tcp/build/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable server-tcp"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/server-tcp.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/server-tcp.dir/build: server-tcp
.PHONY : CMakeFiles/server-tcp.dir/build

CMakeFiles/server-tcp.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/server-tcp.dir/cmake_clean.cmake
.PHONY : CMakeFiles/server-tcp.dir/clean

CMakeFiles/server-tcp.dir/depend:
	cd "/home/angga/Documents/LEN/ngerjain-project/batch 1/server-tcp/build" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" "/home/angga/Documents/LEN/ngerjain-project/batch 1/server-tcp" "/home/angga/Documents/LEN/ngerjain-project/batch 1/server-tcp" "/home/angga/Documents/LEN/ngerjain-project/batch 1/server-tcp/build" "/home/angga/Documents/LEN/ngerjain-project/batch 1/server-tcp/build" "/home/angga/Documents/LEN/ngerjain-project/batch 1/server-tcp/build/CMakeFiles/server-tcp.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : CMakeFiles/server-tcp.dir/depend

