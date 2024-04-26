import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./textEdit"


ApplicationWindow {
    width: 1100
    height: 600
    visible: true
    id: root
    title: qsTr("★ShWrite★")
    // flags: Qt.ForegroundRole
    color: "#222436"
    menuBar: MenuBar {
        Menu {
            title: qsTr("文件")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                text: qsTr("&New File")
                onTriggered: fileDialog.open()
            }

            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
        Menu {
            title: qsTr("工具")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
                Image {

                    source: ":icon/image/.1.png"
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
            title: qsTr("偏好")
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

    }

    // CustomTextEditor{
    //     anchors.fill: parent
    // }

    // Set up the layout of the main components in a row:
    // [ Sidebar, Navigation, Editor ]
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

        // Allows resizing parts of the UI.
        SplitView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            // Customized handle to drag between the Navigation and the Editor.
            handle: Rectangle {
                implicitWidth: 5
                color: SplitHandle.pressed ? Colors.color2 : Colors.background
                border.color: SplitHandle.hovered ? Colors.color2 : Colors.background
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
                color: "#171819"
                SplitView.preferredWidth: 100
                SplitView.fillHeight: true
                // The stack-layout provides different views, based on the
                // selected buttons inside the sidebar.
                StackLayout {
                    anchors.fill: parent
                    currentIndex: sidebar.currentTabIndex

                    // Shows the help text.
                    // Text {
                    //     text: qsTr("Click on the folder icon to the left to get started.")
                    //     wrapMode: TextArea.Wrap
                    //     color: Colors.text
                    // }

                    // Shows the files on the file system.
                    // FileSystemView {
                    //     id: fileSystemView
                    //     color: Colors.surface1
                    //     onFileClicked: path => root.currentFilePath = path
                    // }
                }
            }

            // The main view that contains the editor.
            CustomTextEditor {
                id: editor
                // showLineNumbers: root.showLineNumbers
                // currentFilePath: root.currentFilePath
                SplitView.fillWidth: true
                SplitView.fillHeight: true
            }
        }
    }

    Dialog{
        id: fileDialog
        Text {
            id: name
            text: qsTr("text")
        }
        anchors.centerIn: parent
        width: parent.width/5
        height: parent.height/4
    }
}
