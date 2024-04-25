import QtQuick
import QtQuick.Controls

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("★ShWrite★")
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
//                onTriggered: function(){
//                    mainEdit.bgColor = "red"
//                }

//                onTriggered:mainEdit.bgColor = "red"

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

//    WriteEdit{
//        anchors.fill: parent
//        id: mainEdit;
//    }
    CustomTextEditor{
        anchors.fill: parent
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
