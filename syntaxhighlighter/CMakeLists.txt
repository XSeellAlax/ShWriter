# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

#cmake_minimum_required(VERSION 3.16)
project(Syntaxhighlighter)


find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets)

qt_add_library(Syntaxhighlighter SHARED
    highlighter.cpp highlighter.h
)
target_link_libraries(Syntaxhighlighter
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
)

# project(FileSysteamModule)

# qt_add_library(FileSysteamModule SHARED
#     filesystemmodel.h
#     filesystemmodel.cpp
# )

# find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets)
# find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets)

# target_link_libraries(FileSysteamModule

#     Qt6::Widgets
#     Qt6::Quick
# )

