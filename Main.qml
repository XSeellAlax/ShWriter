import QtQuick
import QtQuick.Controls
// import QtQuick.
import QtQuick.Layouts
import QtQuick.Dialogs
import FileIO

import "./Qml"
ApplicationWindow {

    property string currentFilePath: ""
    width: 1100
    height: 600
    // visible: true
    id: root
    // color: "#222436"
    minimumWidth: 200
    minimumHeight: 100
    visible: true
    // color: Colors.background
    // flags: Qt.Window | Qt.FramelessWindowHint
    // title: qsTr("File System Explorer Example")
    FileIO {
        id: fileIO
    }
    menuBar:
    MenuBar {
        Menu {
            title: qsTr("文件(&F)")
            MenuItem {
                text: qsTr("&打开...")
                onTriggered: {
                    editor.readFile()
                }
                // source.ic
            }
            MenuItem {
                text: qsTr("&保存...")
                onTriggered:{
                    editor.save()
                }
            }

            MenuItem {
                text: qsTr("&打开文件目录")
                onTriggered: {
                    currentFilePath = fileIO.getOpenFileName();
                    // var dir = fileIO.getOpenFileName();
                    // fileSystemView.setDir(dir)
                }
            }

            MenuItem {
                text: qsTr("&退出...")
                onTriggered: Qt.quit();
            }
        }
        Menu {
            title: "编辑"
        }

        Menu {
            title: qsTr("工具(&T)")

            MenuItem {
                text: qsTr("终端")
                onTriggered:{
                    console.log(currentFilePath);
                    cmd.visible = !cmd.visible
                }
            }

            MenuItem {
                text: qsTr("工具栏")
                onTriggered:{
                    tools.visible = !tools.visible
                }

                Image {

                    // source: ":icon/image/.1.png"
                }
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
                onTriggered: {
                    cmd.visible = true
                    commandRunner.runCommand(editor.text)
                }
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
                SplitView.preferredWidth: 100
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
                    Text {
                        text: qsTr("This example shows how to use and visualize the file system.\n\n"
                                 + "Customized Qt Quick Components have been used to achieve this look.\n\n"
                                 + "You can edit the files but they won't be changed on the file system.\n\n"
                                 + "Click on the folder icon to the left to get started.")
                        wrapMode: TextArea.Wrap
                        color: "#D4BE98"
                    }
                }
            }

            SplitView {
                orientation: Qt.Vertical
                SplitView.fillWidth: true
                SplitView.fillHeight: true
                SplitView {
                    SplitView.fillHeight: true
                    SplitView.minimumHeight: parent.height/3*2
// 主Edit部分 -----------------------------------------------------------------------
                    Editor {
                        SplitView.minimumWidth: parent.width/4
                        SplitView.fillWidth: true
                        id: editor
                    }

                    // Item {
                    //     SplitView.minimumWidth: parent.width/4
                    //     SplitView.fillWidth: true
                    //     id: mainEditView
                    //     // TabBar {
                    //     //     id: editBar
                    //     //     width: parent.width
                    //     //     z : 5
                    //     //     // model: 5
                    //     //     Repeater {
                    //     //         model: 5
                    //     //         delegate: TabButton{
                    //     //             text: editor.currFilePath==""?"新文件":editor.currFilePath
                    //     //         }
                    //     //     }

                    //     // }
                    //     // StackLayout {
                    //     //     anchors.top: editBar.bottom
                    //     //     width: parent.width
                    //     //     height: parent.height - editBar.height
                    //     //     currentIndex: editBar.currentIndex
                    //     //     Repeater{
                    //     //         model: 5
                    //     //         delegate: TextEditor {
                    //     //             id: editor
                    //     //             anchors.fill: parent
                    //     //         }
                    //     //     }
                    //     // }

                    //     // TextEditor {
                    //     //     id: editor
                    //     //     // activeFocus: true
                    //     //     SplitView.minimumWidth: parent.width/4
                    //     //     SplitView.fillWidth: true
                    //     //     // height: parent.height/2
                    //     // }

                    // }
                    Rectangle {
                        // color: "yellow"
                        id: tools
                        Label {
                            text: "工具栏"
                            anchors.centerIn: parent
                        }

                        SplitView.minimumWidth: parent.width/8

                        // SplitView.fillWidth: true
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
                    readOnly: true
                    visible: false
//                    color: "white"
                    //text: "output: "
                }
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
}
