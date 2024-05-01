import QtQuick
import QtQuick.Controls
// import QtQuick.
import QtQuick.Layouts
import QtQuick.Dialogs
import FileIO
//import ShellCoder
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
                text: qsTr("&Change")
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
                    Text {
                        text: qsTr("This example shows how to use and visualize the file system.\n\n"
                                 + "Customized Qt Quick Components have been used to achieve this look.\n\n"
                                 + "You can edit the files but they won't be changed on the file system.\n\n"
                                 + "Click on the folder icon to the left to get started.")
                        wrapMode: TextArea.Wrap
                        color: Colors.text
                    }
                    FileSystemView {
                        id: fileSystemView
                        color: Colors.surface1
                        onFileClicked: path => editor.currFilePath = path
                        visible: {
                            if(currentFilePath===""){
                                return false;
                            }else{
                                return true;
                            }
                        }
                    }
                }
            }

            SplitView {
                orientation: Qt.Vertical
                SplitView.fillWidth: true
                SplitView.fillHeight: true
                SplitView {
                    SplitView.fillHeight: ture
                    SplitView.minimumHeight: parent.height/3*2
                    Editor {
                        id: editor
                        SplitView.minimumWidth: parent.width/4
                        SplitView.fillWidth: true
                        // height: parent.height/2
                    }
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

                Terminal {
                    id: cmd
                    SplitView.minimumHeight: parent.height/4
                    height: parent.height/4
                    // SplitView.maximumHeight: parent.height/2
                    // SplitView.fillWidth: true
                    // color: "lightgray"
                    // Label {
                    //     text: "Terminal"
                    //     anchors.centerIn: parent
                    // }
                    visible: true
                }
            }
        }
    }
}
