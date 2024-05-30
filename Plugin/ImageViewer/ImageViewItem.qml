import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
// import ImageViewer
// import "../"
Rectangle {
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
        ImageViewer {
            id: image_view
            SplitView.fillHeight: true
            SplitView.minimumWidth: parent.width / 2
        }
    }

    Connections {
        target: image_list.open_image_bth
        function onClicked(){
            image_view.open_image_folder()
        }
    }
}
