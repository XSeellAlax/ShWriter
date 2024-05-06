import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import "./"
import FileIO
import LineNumberModel
import QtQuick.Dialogs
Item {
    id: root
    property string fontFamily: "Consolas"
    property int fontPointSize: 15
    property color background: "#4B4A4A"
    property alias readOnly: edit.readOnly
    property alias edit: edit
    property color selectonColor:"#0078D7"
    property alias textDocument: edit.textDocument
    property string currFilePath : ""

    Rectangle {
        color: "#222436"
        anchors.fill: parent
    }
    onCurrFilePathChanged: {
        // fileIO.open("")
        // updateText();
        fileIOScript.sentMessage();
    }

    //  文件读取
    FileIO {
        id: fileIO
    }

    Flickable {
        id: flick
        focus: false
        anchors {
            fill: parent
        }

        contentWidth: parent.width

        contentHeight: edit.paintedHeight + 5
        clip: true
        boundsBehavior:Flickable.StopAtBounds
        function ensureVisible(r) {
           if (contentX >= r.x)
               contentX = r.x;
           else if (contentX+width <= r.x+r.width)
               contentX = r.x+r.width-width;
           if (contentY >= r.y)
               contentY = r.y;
           else if (contentY+height <= r.y+r.height)
               contentY = r.y+r.height-height + 10;
        }

        Rectangle {
            id: textBg // 文本背景
            z: 0
            width: parent.width
            height: panding.contentHeight
            // color: "#4B4A4A"
            color: background
            // color: Config.background
            opacity: 0.8
            radius: 4
            // Behavior on width {
            //    NumberAnimation { duration: 1000; easing.type: Easing.OutElastic }
            // }
            // Behavior on height {
            //    NumberAnimation { duration: 1000; easing.type: Easing.OutElastic }
            // }
        }
        Column{
            id:lineNumberLabel
            anchors {
                left: parent.left
            }
            Repeater {
               model: edit.lineCount;
               Rectangle {
                   width: lineNumberWidth(edit.lineCount)*1.8
                   height: panding.contentHeight
                   color: "#292828"
                   // color: Qt.light("#0078D7")
                   // color: "white"
                   Text {
                       id:showLineNumber
                       anchors{
                           bottom:parent.bottom
                           bottomMargin: 1
                           horizontalCenter: parent.horizontalCenter
                       }
                       text:index + 1
                       color: "white"
                       // color: "#0078D7"
                       anchors.margins: 10
                       // font.bold: bold
                       font.pointSize: fontPointSize
                       // font.family: fontFamily
                   }
                   Rectangle {
                       id: indicator

                       anchors.right: parent.right
                       width: 1
                       height: parent.height
                       color: Qt.darker("#292828",3)
                   }
               }
            }
        }
        TextEdit{
            id: panding
            visible: false
            font.pointSize: fontPointSize
            font.family: fontFamily
            anchors.margins: 10

        }
        //  主文本编辑器
        TextEdit {
            property bool ctrlPressed: false
            anchors {
                left:lineNumberLabel.right
                leftMargin: 10
            }
            id: edit
            color: "white"
            readOnly: root.readOnly
            selectByMouse: true
            // tabStopDistance: 20
            activeFocusOnPress: true
            focus: true
            clip: true
            selectionColor: selectonColor
            wrapMode: TextEdit.WordWrap
            // leftPadding: 5
            // topPadding: 0.5

            font.pointSize: fontPointSize
            font.family: fontFamily
            width: flick.width - 10
            height: edit.contentHeight > flick.height ?
                        edit.contentHeight : flick.height
            anchors.margins: 10
            cursorVisible: true
            cursorDelegate: cursorDelegate
            // onPaintedWidthChanged: {
            //     textBg.width = edit.paintedWidth + 10
            // }
            // onCursorPositionChanged: {
            //     console.log(cursorPosition)
            //     textBg.y = edit.cursorPosition * panding.height
            // }

            onPaintedHeightChanged: {
                textBg.height = edit.paintedHeight + 1

                // textBg.y = edit.cursorPosition.y
            }
            //
            onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
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
                    if (datl>0 && edit.ctrlPressed) {
                        fontPointSize += 1
                    } else if (datl<0 && edit.ctrlPressed) {
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
        }
        ScrollIndicator.horizontal: ScrollIndicator { }
        ScrollIndicator.vertical: ScrollIndicator { }
    }

    //文本光标
    Component {
        id: cursorDelegate
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
    function lineNumberWidth(lineCount) {
        var width = 1;
        var space = 0;
        while(lineCount >= 10) {
           lineCount /= 10;
           ++width;
        }
        return space = width * fontPointSize
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
        console.log(fileIO.getFilePath() + "读取成功")
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

