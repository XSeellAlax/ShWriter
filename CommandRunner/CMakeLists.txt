# ccmake_minimum_required(VERSION 3.10)

project(CommandRunner)

qt_add_library(CommandRunner SHARED
    commandrunner.h
    commandrunner.cpp
)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets)

target_link_libraries(CommandRunner
    Qt6::Widgets
    Qt6::Quick
)
