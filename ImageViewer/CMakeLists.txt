
project(ImageViewer)


find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_add_library(ImageViewer SHARED
    # highlighter.cpp highlighter.h
    ImageViewer.qml
)
target_link_libraries(ImageViewer
    Qt6::Quick
)
