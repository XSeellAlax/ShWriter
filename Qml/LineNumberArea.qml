import QtQuick
import QtQuick.Controls
import LineNumberModel

Flickable
{
    id: root
    property int rowHeight: Math.ceil(fontMetrics.lineSpacing)
    property var font: ""
    property alias lineCount: lineNumberModel.lineCount
    Column
    {
        Repeater{
            id: repeatedLineNumbers
            model: LineNumberModel{
                id: lineNumberModel
                lineCount: 10
            }
            delegate: Item {
                required property int index;

                width: parent.width * 1.5
                height: root.rowHeight
                Text {
                    id: numbersText
                    text: parent.index + 1
                    font: font
                    width: parent.width
                    height: parent.height
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                }

                Rectangle {
                    id: indicator

                    anchors.left: numbers.right
                    height: parent.height
                    width: 1
                    color: "blue"
                }
            }
        }
    }
}
