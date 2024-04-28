cmake_minimum_required(VERSION 3.27)

project(ShWriter VERSION 0.1 LANGUAGES CXX)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appShWriter  main.cpp)

qt_add_qml_module(appShWriter
    URI ShWriter
    VERSION 1.0
    QML_FILES
    TextEdit/TextEditor.qml
        TextEdit/Colors.qml
        TextEdit/TextEditor.qml
        Bar/Sidebar.qml
        Main.qml
        QML_FILES Config/Config.qml
        RESOURCES pic.qrc
        # QML_FILES textEdit/TextMenu.
    # SOURCES /Images/
)

target_compile_features(appShWriter PRIVATE cxx_std_20)

set_target_properties(appShWriter PROPERTIES
    AUTORCC TRUE
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appShWriter
    PRIVATE 
        Qt6::Quick
        # Qt6::Core
        # Qt6::Gui
        # Qt6::Widgets
        FileInfo

        # MyWidget
)

include(GNUInstallDirs)
install(TARGETS appShWriter
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

add_subdirectory(FileInfo)
# add_subdirectory(MyWidget)
# add_subdirectory(MyWidget)

