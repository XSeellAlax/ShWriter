import QtQuick
import QtQuick.Controls
// import QtQuick.
import QtQuick.Layouts
import "./TextEdit"
import "./Bar"

ApplicationWindow {
    width: 1100
    height: 600
    visible: true
    id: root
    title: qsTr("★ShWrite★")
    color: "#222436"
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
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
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
                implicitWidth: 1
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
                    ListView
                    {
                        id: list
                        ListModel {
                            ListElement {
                                name: "Bill Smith"
                                number: "555 3264"
                            }
                            ListElement {
                                name: "John Brown"
                                number: "555 8426"
                            }
                            ListElement {
                                name: "Sam Wise"
                                number: "555 0473"
                            }
                        }
                    }
                }
            }


            // The main view that contains the editor.
            TextEditor {
                id: editor
                // showLineNumbers: root.showLineNumbers
                // currentFilePath: root.currentFilePath
                SplitView.fillWidth: true
                SplitView.fillHeight: true
            }
        }
    }
}
