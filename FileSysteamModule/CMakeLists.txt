# ccmake_minimum_required(VERSION 3.10)

project(FileSysteamModule)

qt_add_library(FileSysteamModule SHARED
    filesystemmodel.h
    filesystemmodel.cpp
)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets)

target_link_libraries(FileSysteamModule
    # Qt6::Core
    # Qt6::Gui
    Qt6::Widgets
    Qt6::Quick
)
