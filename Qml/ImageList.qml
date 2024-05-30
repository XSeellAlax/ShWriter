import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
Item {

    property alias model: folder.model
    property alias delegate: folder.delegate
    property alias open_image_bth: open_bth
    Column {
        anchors.fill: parent
        spacing: 10
        Rectangle {
            height: 1
            width: parent.width
        }

        Item{
            anchors.horizontalCenter: parent.horizontalCenter
            height: header.height
            width: parent.height
            Text {
                id: header
                height: 10
                text: qsTr("图片资源管理器")

                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Rectangle {
            width: parent.width
            height: 0.1
            color: "black"
        }


        Button{
            id: open_bth
            text: "打开文件夹"
            height: 25
            width: parent.width/8 * 7
            font.pixelSize: 15
            anchors.horizontalCenter: parent.horizontalCenter

            background: Rectangle {
                color: "#1874CD"
            }
            visible: folder.count === 0
        }

        Rectangle {
            width: parent.width - 10
            height: parent.height - 60
            border.color: "#1874CD"
            clip: true
            ListView{
                id: folder
                width: parent.width - 10
                height: parent.height - 10
                anchors.centerIn: parent
                spacing: 10
            }
        }
    }


}
