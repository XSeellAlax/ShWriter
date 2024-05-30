import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
// import ImageViewer
// import "../"
Rectangle{
    width: 640
    height: 400
    visible: true
    // title: qsTr("Example Project")

    SplitView {
        anchors.fill: parent
        Layout.fillHeight: true
        Layout.fillWidth: true
        orientation: Qt.Horizontal

        ImageList {
            SplitView.fillHeight: true
            SplitView.preferredWidth: 200
            id: image_list
            model: image_view.image_model
            delegate: image_view.image_delegate
        }

        handle: Rectangle {
            implicitWidth: 2
            // color: SplitHandle.pressed ? Colors.color2 : Colors.background
            // border.color: SplitHandle.hovered ? Colors.color2 : Colors.background
            opacity: SplitHandle.hovered || image_list.width > 15 ? 1.0 : 0.0
            color: "gray"
            Behavior on opacity {
                OpacityAnimator {
                    duration: 1400
                }
            }
        }

        ImageViewItem {
            id: image_view
            SplitView.fillHeight: true
            SplitView.minimumWidth: parent.width / 2
            Rectangle {
                anchors.fill: parent
                color: "gray"
                opacity: 0.2
                z: -1
            }
        }
    }



    Connections {
        target: image_list.open_image_bth
        function onClicked(){
            image_view.open_image_folder()
        }
    }
}

