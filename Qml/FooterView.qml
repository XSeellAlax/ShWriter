import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item {
    id: foot_view

    RowLayout {
        spacing: 10
        Rectangle {
            width: parent.width / 8
            height: parent.height
        }

        Rectangle {
            width: parent.width/8 * 7
            height: parent.height
            color: "#1874CD"
            Text {
                id: name
                text: qsTr("text")
            }
        }
    }


}
