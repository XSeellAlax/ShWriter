import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import FileIO
Item {


    property bool ctrlPressed: false

    property real fontPointSize: 15

    property string currFilePath: ""
    FileIO {
        id: fileIO
    }

    RowLayout {
        anchors.fill: parent
        Flickable {
            id: lineNumber
            Layout.preferredWidth: fontMetrics.averageCharacterWidth
                * (Math.floor(Math.log10(edit.lineCount)) + 1) + 20
            height: root.height;
            contentHeight: column.height
            contentY: flick.contentY
            Layout.fillHeight: true

            Column {
                id: column
                anchors.fill: parent
                Repeater
                {
                    id: lineNumbers
                    model: edit.lineCount
                    delegate: Rectangle
                    {
                        width: parent.width - 10
                        y: index * (edit.paintedHeight / edit.lineCount)
                        color: "white"

                        Label {
                            id: number
                            text: index + 1
                            font: edit.font
                            width: parent.width
                            height: parent.height
                            color: "green"
                            // verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignRight
                        }
                        Rectangle {
                            width: 10
                            // z: 1
                            height: number.height
                            anchors.right: parent.right
                            visible: true
                            color: "black"
                        }
                    }
                }
            }
        }

        Flickable {
             id: flick
             Layout.fillHeight: true
             Layout.fillWidth: true
             contentWidth: edit.paintedWidth
             contentHeight: edit.paintedHeight
             clip: true
            anchors {
                left: lineNumber.right
            }
             function ensureVisible(r)
             {
                 if (contentX >= r.x)
                     contentX = r.x;
                 else if (contentX+width <= r.x+r.width)
                     contentX = r.x+r.width-width;
                 if (contentY >= r.y)
                     contentY = r.y;
                 else if (contentY+height <= r.y+r.height)
                     contentY = r.y+r.height-height;
             }
            // 文本编辑器
            TextEdit {
                id: edit
                // property int cursorY: 0
                width: flick.width
                height: flick.height
                focus: true
                font.pointSize: fontPointSize
                selectionColor: "#C3C3FF"
                cursorVisible: true
                cursorDelegate: cursor_Delegate
                wrapMode: TextEdit.Wrap

                onCursorPositionChanged: {
                    // console.log(cursorRectangle.y)
                    // cursorY = cursorRectangle.y
                    lineLight.y = cursorRectangle.y
                }
                onFontChanged: {
                    lineLight.y = cursorRectangle.y
                }

                // onCursorRectangleChanged: {
                //     lineLight.y = cursorRectangle.y
                // }

                Rectangle {
                    id: lineLight
                    width: parent.width
                    height: edit.paintedHeight/edit.lineCount
                    y: cursorY
                    color: "yellow"
                    opacity: 0.2
                    z: -1
                }

                onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
             }
             // 滚动条
             ScrollBar.horizontal: ScrollBar {}
             ScrollBar.vertical: ScrollBar {}
         }

        FontMetrics {
            id: fontMetrics
            font: edit.font
        }
    }

    // Ctrl + 滚轮: 放大缩小

    MouseArea {
        anchors {
            fill: parent
        }
        id: mouse
        propagateComposedEvents: true
        onClicked: mouse.accepted = false;
        onPressed: mouse.accepted = false;
        onReleased: mouse.accepted = false;
        onDoubleClicked: mouse.accepted = false;
        onPositionChanged: mouse.accepted = false;
        onPressAndHold: mouse.accepted = false;
        cursorShape: Qt.IBeamCursor
        onWheel:
        wheel=>{
            var datl = wheel.angleDelta.y / 120
            if (datl>0 && ctrlPressed) {
                fontPointSize += 1
            } else if (datl<0 && ctrlPressed) {
                fontPointSize -= 1
            }
            wheel.accepted = false
        }
    }
    Keys.onPressed:
    event=>{
        if(event.modifiers === Qt.ControlModifier) {
            ctrlPressed = true
        }
        event.accepted = false
    }
    Keys.onReleased:
    event=>{
        if(!(event.modifiers&Qt.ControlModifier)) {
            ctrlPressed = false
        }
        event.accepted = false
    }



    //文本光标--------------------------------------------------------------
    Component {
        id: cursor_Delegate
        Rectangle {
            id: cursor
            color: "gray"
            width: 10;
            height: 5
            SequentialAnimation {
                running: true;
                loops: ColorAnimation.Infinite
                NumberAnimation {
                    easing {
                        type: Easing.InQuint
                    }
                    property: "opacity"
                    target: cursor; from: 1.0; to: 0.0; duration: 800;
                }
                NumberAnimation {
                    easing {
                        type: Easing.InQuint
                    }
                    property: "opacity"
                    target: cursor;
                    from: 0.0;
                    to: 1.0;
                    duration: 800;
                }
            }
            Behavior on x {
                SpringAnimation { spring: 3; damping: 0.2  }
            }
            Behavior on y {
                SpringAnimation { spring: 3; damping: 0.2 }
            }
        }
    }

    onCurrFilePathChanged: {
        updateText();
    }

// 其他函数-------------------------------------------
    function lineNumberWidth(count)
    {
        var res = 20;
        while(count){
            res += 10;
            count /= 10;
        }
        return res;
    }

    function readFile()
    {
        edit.text = "";
        edit.text = fileIO.read();
        console.log("文件读取成功");
        console.log(fileIO.getFileName())
    }
    function updateText()
    {
        edit.text = "";
        edit.text = fileIO.updateText(currFilePath);
        // console.log();
        // console.log(fileIO.getFilePath() + "读取成功")
    }

    function clear()
    {
        edit.text = "";
    }

    function save()
    {
        var context = edit.text;
        fileIO.save(context);
        console.log(fileIO.getFilePath()+"保存成功");

    }
}
