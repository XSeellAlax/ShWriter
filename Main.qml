import QtQuick
import QtQuick.Controls
// import QtQuick.
import QtQuick.Layouts
import QtQuick.Dialogs
import FileIO
//import QtQuick.Controls
import "./Qml"
// import "./ImageViewer/ImageViewer.qml"


ApplicationWindow {

    property string currentFilePath: ""
    width: 1100
    height: 600
    // visible: true
    id: root

    minimumWidth: 200
    minimumHeight: 100
    visible: true
    title: "ShCoder"
    // flags: Qt.Window | Qt.FramelessWindowHint

    FileIO {
        id: fileIO
    }


    // Menu Bar
    menuBar:
    MenuBar {
        Menu {
            title: qsTr("文件(&F)")
            MenuItem {
                text: qsTr("&打开...")
                action: readFile
            }
            MenuItem {
                text: qsTr("Open")
                onTriggered: {
                    var file_path = fileIO.getOpenFileName()
                    console.log(file_path)
                    image_centent.source = String(file_path)
                    imgView.visible = true
                    editor.visible = false

                }
            }
            MenuItem {
                text: qsTr("打开图片")
                action: openImageFolder
            }

            MenuItem {
                text: qsTr("&保存...")
                action: fileSvae
            }

            MenuItem {
                text: qsTr("&打开文件目录")
                action: openFloder
            }

            MenuItem {
                text: qsTr("&退出...")
                onTriggered: Qt.quit();
            }
        }
        Menu {
            height: 20
            title: "编辑"
        }

        Menu {
            title: qsTr("工具(&T)")

            MenuItem {
                text: qsTr("终端")
                action: terminalVisble
            }

            MenuItem {
                text: qsTr("工具栏")
                action: toolsVisble
            }

            MenuItem {
                text: qsTr("&New File")
            }

            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
        Menu {
            title: qsTr("调试(&D)")
            MenuItem {
                text: qsTr("&运行")
                action: run
            }
            MenuItem {
                text: qsTr("&New File")
            }

            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }

        Menu {
            title: "设置(&S)"
        }

        Menu {
            title: "帮助(&U)"
        }

    }

    // footer: FooterView {
    //     width: parent.width
    //     z: 999
    //     height: 20
    // }

    // action -----------------------------------------------
    Action {
        id: toolsVisble
        onTriggered:{
            tools.visible = !tools.visible
        }
    }

    Action {
        id: readFile
        onTriggered: {
            editor.readFile()
        }
    }

    Action {
        id: fileSvae
        onTriggered:{
            editor.save()
        }
    }

    Action {
        id: run
        onTriggered: {
            cmd.visible = true
            commandRunner.runCommand(editor.text)
        }
    }

    Action {
        id: terminalVisble
        onTriggered:{
            console.log(currentFilePath);
            cmd.visible = !cmd.visible
        }
    }

    Action {
        id: openFloder
        onTriggered: {
            currentFilePath = fileIO.getOpenFileName();
        }
    }

    Action {
        id: openImageFolder
        onTriggered: {
            image_view.open_image_folder()
        }
    }

    onCurrentFilePathChanged: {
        fileSystemView.setDir(currentFilePath);
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Stores the buttons that navigate the application.
        Sidebar {
            id: sidebar
            dragWindow: root
            Layout.preferredWidth: 50
            Layout.fillHeight: true
        }
        Rectangle {
            id: lineRect
            width: 1
            height: parent.height
        }

        // Allows resizing parts of the UI.
        SplitView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            // Customized handle to drag between the Navigation and the Editor.
            handle: Rectangle {
                implicitWidth: 5
                // color: SplitHandle.pressed ? Colors.color2 : Colors.background
                // border.color: SplitHandle.hovered ? Colors.color2 : Colors.background
                opacity: SplitHandle.hovered || navigationView.width < 15 ? 1.0 : 0.0

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 1400
                    }
                }
            }

            Rectangle {
                id: navigationView
                // color: Colors.surface1
                // color: "#171819"
                SplitView.preferredWidth: 200
                SplitView.fillHeight: true
                // The stack-layout provides different views, based on the
                // selected buttons inside the sidebar.


                StackLayout {
                    anchors.fill: parent
                    currentIndex: sidebar.currentTabIndex
                    // Shows the help text.
                    FileSystemView {
                        id: fileSystemView
                        // color: "#171819"
                        onFileClicked: path => editor.currFilePath = path
                        // visible: {
                        //     if(currentFilePath===""){
                        //         return false;
                        //     }else{
                        //         return true;
                        //     }
                        // }
                    }
                    ImageList {
                        id: image_list
                        model: image_view.image_model
                        delegate: image_view.image_delegate
                    }
                }
            }
            StackLayout {
                currentIndex: sidebar.currentTabIndex
                SplitView {
                    orientation: Qt.Vertical
                    SplitView.fillWidth: true
                    SplitView.fillHeight: true
                    SplitView {
                        SplitView.fillHeight: true
                        SplitView.minimumHeight: parent.height/3*2
    // 主Edit部分 -----------------------------------------------------------------------

                        ColumnLayout {
                            SplitView.minimumWidth: parent.width/4
                            SplitView.fillWidth: true
                            clip: true
                            TabBar {
                                id: tabBar
                                height: 20
                                TabButton {
                                    text: "Unint1"
                                }
                                Rectangle {
                                    Text {
                                        id: name
                                        text: qsTr("text")
                                    }
                                }

                                TabButton{
                                    text: "Unint2"
                                }
                            }
                            StackLayout {
                                currentIndex: tabBar.currentIndex
                                Editor {
                                    visible: true
                                    objectName: "textEditor"
                                    anchors.top: tabBar.bottom
                                    SplitView.minimumWidth: parent.width/4
                                    SplitView.fillWidth: true
                                    SplitView.fillHeight: true
                                    id: editor
                                }
                                Editor {
                                    visible: true
                                    objectName: "textEditor"
                                    anchors.top: tabBar.bottom
                                    SplitView.minimumWidth: parent.width/4
                                    SplitView.fillWidth: true
                                    SplitView.fillHeight: true
                                    // id: editor
                                }
                            }
                        }



                        Rectangle {
                            id: imgView
                            visible: false
                            color: "black"
                            SplitView.minimumWidth: parent.width/4
                            SplitView.fillWidth: true
                            ImageView{
                                anchors.fill: parent
                            }

                        }

                        Rectangle {
                            // color: "yellow"
                            id: tools

                            SplitView.minimumWidth: parent.width/8
                            visible: false
                        }
                    }

                    handle: Rectangle {
                        implicitHeight: 5
                        // color: SplitHandle.pressed ? Colors.color2 : Colors.background
                        // border.color: SplitHandle.hovered ? Colors.color2 : Colors.background
                        color: "#0078D7"
                        opacity: SplitHandle.hovered || navigationView.width < 15 ? 1.0 : 0.0

                        Behavior on opacity {
                            OpacityAnimator {
                                duration: 1400
                            }
                        }
                    }

                    TextArea {
                        id: cmd
                        SplitView.minimumHeight: parent.height/4
                        height: parent.height/4
    //                    color: "red"
                        background: Rectangle{
                            color: "green"
                        }

                        readOnly: true
                        visible: false
    //                    color: "white"
                        //text: "output: "
                    }
                }

                // SplitView {
                //     orientation: Qt.Vertical
                //     SplitView.fillWidth: true
                //     SplitView.fillHeight: true
                //     SplitView {
                //         SplitView.fillHeight: true
                //         SplitView.minimumHeight: parent.height/3 * 2
                //         ImageList {
                //             Spli
                //         }
                //     }
                // }
                ImageView {
                    id: image_view
                    anchors.fill: parent
                    // anchors.fill: parent
                    Rectangle {
                        anchors.fill: parent
                        color: "black"
                        opacity: 0.2
                        z: -1
                    }
                }
                // Rectangle {
                //     anchors.fill: parent
                //     color: "gray"
                //     opacity: 0.5

                // }
            }


        }
    }
    Connections {
        target: commandRunner
        onOutputReceived: {
            cmd.text = ""
            cmd.text = "Output: " + output + '\n'

        }
        onErrorOccurred: {
            cmd.text = "Error: " + error + '\n'
        }
    }

    Connections {
        target: image_list.open_image_bth
        onClicked:image_view.open_image_folder()
    }
}

