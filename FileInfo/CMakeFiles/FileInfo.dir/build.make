# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.27

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
CMAKE_SOURCE_DIR = /run/media/root/Software/Public/Project/ShWriter

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /run/media/root/Software/Public/Project/ShWriter

# Include any dependencies generated for this target.
include FileInfo/CMakeFiles/FileInfo.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include FileInfo/CMakeFiles/FileInfo.dir/compiler_depend.make

# Include the progress variables for this target.
include FileInfo/CMakeFiles/FileInfo.dir/progress.make

# Include the compile flags for this target's objects.
include FileInfo/CMakeFiles/FileInfo.dir/flags.make

FileInfo/CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.o: FileInfo/CMakeFiles/FileInfo.dir/flags.make
FileInfo/CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.o: FileInfo/FileInfo_autogen/mocs_compilation.cpp
FileInfo/CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.o: FileInfo/CMakeFiles/FileInfo.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/run/media/root/Software/Public/Project/ShWriter/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object FileInfo/CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.o"
	cd /run/media/root/Software/Public/Project/ShWriter/FileInfo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT FileInfo/CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.o -MF CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.o.d -o CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.o -c /run/media/root/Software/Public/Project/ShWriter/FileInfo/FileInfo_autogen/mocs_compilation.cpp

FileInfo/CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.i"
	cd /run/media/root/Software/Public/Project/ShWriter/FileInfo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /run/media/root/Software/Public/Project/ShWriter/FileInfo/FileInfo_autogen/mocs_compilation.cpp > CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.i

FileInfo/CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.s"
	cd /run/media/root/Software/Public/Project/ShWriter/FileInfo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /run/media/root/Software/Public/Project/ShWriter/FileInfo/FileInfo_autogen/mocs_compilation.cpp -o CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.s

FileInfo/CMakeFiles/FileInfo.dir/filerw.cpp.o: FileInfo/CMakeFiles/FileInfo.dir/flags.make
FileInfo/CMakeFiles/FileInfo.dir/filerw.cpp.o: FileInfo/filerw.cpp
FileInfo/CMakeFiles/FileInfo.dir/filerw.cpp.o: FileInfo/CMakeFiles/FileInfo.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/run/media/root/Software/Public/Project/ShWriter/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object FileInfo/CMakeFiles/FileInfo.dir/filerw.cpp.o"
	cd /run/media/root/Software/Public/Project/ShWriter/FileInfo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT FileInfo/CMakeFiles/FileInfo.dir/filerw.cpp.o -MF CMakeFiles/FileInfo.dir/filerw.cpp.o.d -o CMakeFiles/FileInfo.dir/filerw.cpp.o -c /run/media/root/Software/Public/Project/ShWriter/FileInfo/filerw.cpp

FileInfo/CMakeFiles/FileInfo.dir/filerw.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/FileInfo.dir/filerw.cpp.i"
	cd /run/media/root/Software/Public/Project/ShWriter/FileInfo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /run/media/root/Software/Public/Project/ShWriter/FileInfo/filerw.cpp > CMakeFiles/FileInfo.dir/filerw.cpp.i

FileInfo/CMakeFiles/FileInfo.dir/filerw.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/FileInfo.dir/filerw.cpp.s"
	cd /run/media/root/Software/Public/Project/ShWriter/FileInfo && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /run/media/root/Software/Public/Project/ShWriter/FileInfo/filerw.cpp -o CMakeFiles/FileInfo.dir/filerw.cpp.s

# Object files for target FileInfo
FileInfo_OBJECTS = \
"CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.o" \
"CMakeFiles/FileInfo.dir/filerw.cpp.o"

# External object files for target FileInfo
FileInfo_EXTERNAL_OBJECTS =

FileInfo/libFileInfo.so: FileInfo/CMakeFiles/FileInfo.dir/FileInfo_autogen/mocs_compilation.cpp.o
FileInfo/libFileInfo.so: FileInfo/CMakeFiles/FileInfo.dir/filerw.cpp.o
FileInfo/libFileInfo.so: FileInfo/CMakeFiles/FileInfo.dir/build.make
FileInfo/libFileInfo.so: /usr/lib/libQt6Quick.so.6.5.2
FileInfo/libFileInfo.so: /usr/lib/libQt6QmlModels.so.6.5.2
FileInfo/libFileInfo.so: /usr/lib/libQt6Qml.so.6.5.2
FileInfo/libFileInfo.so: /usr/lib/libQt6Network.so.6.5.2
FileInfo/libFileInfo.so: /usr/lib/libQt6OpenGL.so.6.5.2
FileInfo/libFileInfo.so: /usr/lib/libQt6Gui.so.6.5.2
FileInfo/libFileInfo.so: /usr/lib/libQt6Core.so.6.5.2
FileInfo/libFileInfo.so: /usr/lib/libGLX.so
FileInfo/libFileInfo.so: /usr/lib/libOpenGL.so
FileInfo/libFileInfo.so: FileInfo/CMakeFiles/FileInfo.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/run/media/root/Software/Public/Project/ShWriter/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX shared library libFileInfo.so"
	cd /run/media/root/Software/Public/Project/ShWriter/FileInfo && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/FileInfo.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
FileInfo/CMakeFiles/FileInfo.dir/build: FileInfo/libFileInfo.so
.PHONY : FileInfo/CMakeFiles/FileInfo.dir/build

FileInfo/CMakeFiles/FileInfo.dir/clean:
	cd /run/media/root/Software/Public/Project/ShWriter/FileInfo && $(CMAKE_COMMAND) -P CMakeFiles/FileInfo.dir/cmake_clean.cmake
.PHONY : FileInfo/CMakeFiles/FileInfo.dir/clean

FileInfo/CMakeFiles/FileInfo.dir/depend:
	cd /run/media/root/Software/Public/Project/ShWriter && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /run/media/root/Software/Public/Project/ShWriter /run/media/root/Software/Public/Project/ShWriter/FileInfo /run/media/root/Software/Public/Project/ShWriter /run/media/root/Software/Public/Project/ShWriter/FileInfo /run/media/root/Software/Public/Project/ShWriter/FileInfo/CMakeFiles/FileInfo.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : FileInfo/CMakeFiles/FileInfo.dir/depend
