import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {

    property alias outputModel: outputModel

    id: draggableOutput
    width: 300
    height: 200
//    color: "#666666"
    color: "black"
    border.color: "white"
    border.width: 5
//    radius: 8
    opacity: 0.9
    visible: true

    ListView {
        spacing: 10
//        anchors.fill: parent
        anchors.centerIn: parent
        anchors.leftMargin: 10
        width: parent.width - 10
        height: parent.height - 10
        model: ListModel {
            id: outputModel
        }
        id: terminalList
        delegate: Text {
            text: " "+ model.output
            color: model.type === "error" ? "red" : "#03A89E"
//            font.family: "Monospace"
            font.bold: true
            font.pixelSize: 15
        }
        clip: true
//        myList.positionViewAtIndex(myList.count - 1, ListView.Beginning)
//        footerPositioning:
    }

//    MouseArea {
//        anchors.fill: parent
//        drag.target: draggableOutput
//        drag.axis: Drag.XandYAxis
//    }
    Connections {
        target: commandRunner
        onOutputReceived: {
            outputModel.append({"output": output, "type": "output"});
//            terminalList.positionViewAtIndex(terminalList.count-1, ListView.Beginning)
//            positionViewAtIndex(myList.count - 1, ListView.Beginning)
        }
        onErrorOccurred: {
            outputModel.append({"output": error, "type": "error"});
//            terminalList.positionViewAtIndex(terminalList.count-1, ListView.Beginning)
//            terminalList.positionViewAtIndex(terminalList.count)
        }
    }
}


//import QtQuick
//import QtQuick.Controls
//import QtQuick.Layouts
//import QtQuick.Window 2.15

//Rectangle {
//    visible: true
//    width: 640
//    height: 480
//    property alias text: commandInput.text
////    title: "QML Command Runner"

//    ColumnLayout {
//        anchors.fill: parent
//        spacing: 20

//        TextArea {
//            id: commandInput
//            placeholderText: "Enter commands separated by semicolons..."
//            placeholderTextColor: "#888"  // 提示文字的颜色
//            Layout.fillWidth: true
//            height: 100
//            font.family: "Monospace"
//            font.pointSize: 12
//            padding: 12
//            color: "#333"  // 输入文字的颜色
//            background: Rectangle {
//                color: "#fff"  // 背景颜色
//                border.color: "#ccc"  // 边框颜色
//                border.width: 1
//                radius: 8
//            }
//        }

//        Button {
//            text: "Run Commands"
//            onClicked: {
//                commandRunner.runCommand(commandInput.text)  // 使用 TextArea 的文本作为命令
//            }
//            Layout.alignment: Qt.AlignHCenter
//        }
//    }

//    // 可拖动的浮动输出窗口
//     Rectangle {
//         id: draggableOutput
//         width: 300
//         height: 200
//         color: "#f0f0f0"
//         border.color: "#333"
//         border.width: 1
//         radius: 8
//         opacity: 0.9
//         visible: true

//         ListView {
//             anchors.fill: parent
//             model: ListModel {
//                 id: outputModel
//             }
//             delegate: Text {
//                 text: model.output
//                 color: model.type === "error" ? "red" : "black"
//                 font.family: "Monospace"
//             }
//             clip: true
//         }

//         MouseArea {
//             anchors.fill: parent
//             drag.target: draggableOutput
//             drag.axis: Drag.XandYAxis
//         }
//     }
//     Connections {
//         target: commandRunner
//         onOutputReceived: {
//             outputModel.append({"output": output, "type": "output"});
//         }
//         onErrorOccurred: {
//             outputModel.append({"output": error, "type": "error"});
//         }
//     }
//}
