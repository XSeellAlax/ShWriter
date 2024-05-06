# ccmake_minimum_required(VERSION 3.10)

project(FileInfo)

qt_add_library(FileInfo SHARED
    # filerw.h
    # filerw.cpp
    fileio.h fileio.cpp
    # file_dir.h file_dir.cpp
)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets)

target_link_libraries(FileInfo
    # Qt6::Core
    # Qt6::Gui
    Qt6::Widgets
    # Qt6::Quick
)
