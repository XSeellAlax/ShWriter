cmake_minimum_required(VERSION 3.27)

project(ShellCoder VERSION 0.1 LANGUAGES CXX)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appShellCoder  main.cpp)

qt_add_qml_module(appShellCoder
    URI ShellCoder
    VERSION 1.0
    QML_FILES 
        Main.qml
        SOURCES
            filesystemmodel.h
            filesystemmodel.cpp
        QML_FILES Qml/Sidebar.qml Qml/Editor.qml Qml/Colors.qml
        QML_FILES Qml/WindowDragHandler.qml QMl/FileSystemView.qml Qml/MyMenu.qml Qml/MyMenuBar.qml
        # QML_FILES Qml/FileSystemView.qml Qml/MyMenu.qml Qml/MyMenuBar.qml Qml/WindowDragHandler.qml
        RESOURCES
            "icons/folder_closed.svg"
            "icons/folder_open.svg"
            "icons/generic_file.svg"
            "icons/globe.svg"
            "icons/info_sign.svg"
            "icons/light_bulb.svg"
            "icons/read.svg"
            "icons/resize.svg"
            "icons/qt_logo.svg"
            "icons/app_icon.svg"
        # URI FIleSystemMode
        #     VERSION 1.0

        QML_FILES Qml/Terminal.qml
        QML_FILES Qml/HandleView.qml    #     QML_FILES Qml/FileSystemView.qml Qml/MyMenu.qml Qml/MyMenuBar.qml Qml/WindowDragHandler.qml
        #     SOURCES filesystemmodel.h filesystemmodel.cpp
)
target_compile_features(appShellCoder PRIVATE cxx_std_20)

set_target_properties(appShellCoder PROPERTIES
    AUTORCC TRUE
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

add_subdirectory(FileInfo)
target_link_libraries(appShellCoder
    PRIVATE 
        Qt6::Quick
        FileInfo
)
# 设置单例类
set_source_files_properties(Qml/Colors.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
)

include(GNUInstallDirs)
install(TARGETS appShellCoder
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)























































#qt_add_executable(ShellCoder)  //Creates and finalizes an application target of a platform-specific type.
#This command performs the following tasks:
#    1. Create a CMake target of the appropriate type for the target platform.
#    2. Link the target to the Qt::Core library.
#    3. Handle finalization of the CMake target.



# qt_standard_project_setup()     #set(CMAKE_AUTOUIC ON)  set(CMAKE_AUTOMOC ON)

# @if %{HasTranslation}
# find_package(Qt6 REQUIRED COMPONENTS Core Quick LinguistTools)
# @else
# find_package(Qt6 REQUIRED COMPONENTS Core Quick)
# @endif

# target_sources(appShellCoder
#     PRIVATE
#         main.cpp
#         qml.qrc
#     @if %{HasTranslation}
#         %{TsFileName}
#     @endif
#         
#     PUBLIC
#         
# )

# qt_import_qml_plugins(ShellCoder)

















# cmake_minimum_required(VERSION 3.16)
# 
# project(ShellCoder VERSION 0.1 LANGUAGES CXX)
# 
# @if !true
# set(CMAKE_AUTOMOC ON)
# @endif
# set(CMAKE_CXX_STANDARD_REQUIRED ON)
# 
# find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
# 
# @if true
# @if false
# qt_standard_project_setup(REQUIRES 6.5)
# @else
# qt_standard_project_setup()
# @endif
# @endif
# 
# qt_add_executable(appShellCoder
#     main.cpp
# )
# 
# qt_add_qml_module(appShellCoder
#     URI ShellCoder
#     VERSION 1.0
#     QML_FILES Main.qml
# )
# 
# # Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# # If you are developing for iOS or macOS you should consider setting an
# # explicit, fixed bundle identifier manually though.
# set_target_properties(appShellCoder PROPERTIES
# #    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appShellCoder
#     MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
#     MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
#     MACOSX_BUNDLE TRUE
#     WIN32_EXECUTABLE TRUE
# )
# 
# target_link_libraries(appShellCoder
#     PRIVATE Qt6::Quick
# )
# 
# include(GNUInstallDirs)
# install(TARGETS appShellCoder
#     BUNDLE DESTINATION .
#     LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#     RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
# )
