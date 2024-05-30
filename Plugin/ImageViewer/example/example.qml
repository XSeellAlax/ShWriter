import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import ImageViewer
import "../"
Window {
    width: 640
    height: 400
    visible: true
    title: qsTr("Example Project")

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

    // SplitView {
    //     Layout.fillWidth: true
    //     Layout.fillHeight: true
    //     // Customized handle to drag between the Navigation and the Editor.
    //     handle: Rectangle {
    //         implicitWidth: 5
    //         opacity: SplitHandle.hovered || navigationView.width < 15 ? 1.0 : 0.0

    //         Behavior on opacity {
    //             OpacityAnimator {
    //                 duration: 1400
    //             }
    //         }
    //     }
    //     Rectangle {
    //         id: navigationView
    //         SplitView.preferredWidth: 200
    //         SplitView.fillHeight: true

    //         ImageList {
    //             id: image_list
    //             model: image_view.image_model
    //             delegate: image_view.image_delegate
    //         }
    //     }
    //     ImageViewer {
    //         id: image_view
    //         SplitView.minimumWidth: parent.width/2
    //         SplitView.fillHeight: true
    //             // anchors.fill: parent
    //         Rectangle {
    //             anchors.fill: parent
    //             color: "black"
    //             opacity: 0.2
    //             z: -1
    //         }
    //     }
    // }
    Connections {
        target: image_list.open_image_bth
        function onClicked(){
            image_view.open_image_folder()
        }
    }
}
