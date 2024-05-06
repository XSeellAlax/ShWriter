// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import LineNumberModel
import FileIO
// import "Qml/lineNumbermodel"
pragma ComponentBehavior: Bound

// This is the text editor that displays the currently open file, including
// their corresponding line numbers.
Rectangle {
    id: root
    // required property string currentFilePath
    // required property bool showLineNumbers
    property alias text: textArea
    property int currentLineNumber: -1
    property int rowHeight: Math.ceil(fontMetrics.lineSpacing)
    property bool ctrlPressed: false
    //--------------------------------------------
    property string fontFamily: "Consolas"
    property int fontPointSize: 15
    property color background: "#4B4A4A"
    // property alias readOnly: edit.readOnly
    // property alias edit: edit
    property color selectonColor:"#0078D7"
    property alias textDocument: textArea.textDocument
    property string currFilePath : ""

    color: Colors.background

    onWidthChanged: textArea.update()
    onHeightChanged: textArea.update()


    // LineNumberModel {
    //     id: lineNumberModel
    // }

    //  文件读取
    FileIO {
        id: fileIO
    }
    focus: true
    RowLayout {
        anchors.fill: parent
        // We use a flickable to synchronize the position of the editor and
        // the line numbers. This is necessary because the line numbers can
        // extend the available height.

        LineNumberArea {
            id: lineNumbers

            // Calculate the width based on the logarithmic scale.
            Layout.preferredWidth: fontMetrics.averageCharacterWidth
                * (Math.floor(Math.log10(textArea.lineCount)) + 1) + 10
            Layout.fillHeight: true
            Layout.fillWidth: false

            interactive: false
            contentY: editorFlickable.contentY
            visible: true//textArea.text !== "" && root.showLineNumbers
            lineCount: textArea.text===""?0:textArea.lineCount
            font: textArea.font
            // font: textArea.font
        }

        // Flickable {
        //     id: lineNumbers

            // Calculate the width based on the logarithmic scale.
            // Layout.preferredWidth: fontMetrics.averageCharacterWidth
            //     * (Math.floor(Math.log10(textArea.lineCount)) + 1) + 10
            // Layout.fillHeight: true
            // Layout.fillWidth: false

            // interactive: false
            // contentY: editorFlickable.contentY
            // visible: true//textArea.text !== "" && root.showLineNumbers

        //     Column {
        //         anchors.fill: parent
        //         Repeater {
        //             id: repeatedLineNumbers

        //             model: LineNumberModel {
        //                 lineCount: textArea.text===""?0:textArea.lineCount
        //             }

        //             delegate: Item {
        //                 required property int index

        //                 width: parent.width * 1.5
        //                 height: root.rowHeight
        //                 Text {
        //                     id: numbers

        //                     text: parent.index + 1

        //                     width: parent.width
        //                     height: parent.height
        //                     horizontalAlignment: Text.AlignHCenter
        //                     verticalAlignment: Text.AlignVCenter

        //                     color: (root.currentLineNumber === parent.index)
        //                             ? Colors.iconIndicator : Qt.darker(Colors.text, 2)
        //                     font: textArea.font
        //                 }
        //                 Rectangle {
        //                     id: indicator

        //                     anchors.left: numbers.right
        //                     width: 1
        //                     height: parent.height
        //                     color: Qt.darker(Colors.text, 3)
        //                 }
        //             }
        //         }
        //     }
        // }

        Flickable {
            id: editorFlickable

            property alias textArea: textArea

            // We use an inline component to customize the horizontal and vertical
            // scroll-bars. This is convenient when the component is only used in one file.
            component MyScrollBar: ScrollBar {
                id: scrollBar
                background: Rectangle {
                    implicitWidth: scrollBar.interactive ? 8 : 4
                    implicitHeight: scrollBar.interactive ? 8 : 4

                    opacity: scrollBar.active && scrollBar.size < 1.0 ? 1.0 : 0.0
                    color: Colors.background
                    Behavior on opacity {
                        OpacityAnimator {
                            duration: 500
                        }
                    }
                }
                contentItem: Rectangle {
                    implicitWidth: scrollBar.interactive ? 8 : 4
                    implicitHeight: scrollBar.interactive ? 8 : 4
                    opacity: scrollBar.active && scrollBar.size < 1.0 ? 1.0 : 0.0
                    color: Colors.color1
                    Behavior on opacity {
                        OpacityAnimator {
                            duration: 1000
                        }
                    }
                }
            }

            Layout.fillHeight: true
            Layout.fillWidth: true
            ScrollBar.horizontal: MyScrollBar {}
            ScrollBar.vertical: MyScrollBar {}

            boundsBehavior: Flickable.StopAtBounds

            TextArea.flickable: TextArea {
                id: textArea
                anchors.fill: parent

                focus: false
                topPadding: 0
                leftPadding: 10

                text: FileSystemModel.readFile(root.currentFilePath)
                tabStopDistance: fontMetrics.averageCharacterWidth * 4

                cursorVisible: true
                cursorDelegate: cursorDelegate
                font.pointSize: fontPointSize
                font.family: fontFamily
                // Grab the current line number from the C++ interface.
                // onCursorPositionChanged: {
                //     root.currentLineNumber = FileSystemModel.currentLineNumber(
                //         textArea.textDocument, textArea.cursorPosition)
                // }

                color: Colors.textFile
                selectedTextColor: Colors.textFile
                selectionColor: Colors.selection

                textFormat: TextEdit.PlainText
                renderType: Text.QtRendering
                selectByMouse: true
                antialiasing: true
                background: null
            }

            FontMetrics {
                id: fontMetrics
                font: textArea.font
            }
        }
    }

    //文本光标
    Component {
        id: cursorDelegate
        Rectangle {
            id: cursor
            color: "gray"
            width: 3;
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

    function readFile()
    {
        textArea.text = "";
        textArea.text = fileIO.read();
        console.log("文件读取成功");
        console.log(fileIO.getFileName())
    }
    function updateText()
    {
        textArea.text = "";
        textArea.text = fileIO.updateText(currFilePath);
        // console.log();
        console.log(fileIO.getFilePath() + "读取成功")
    }

    function clear()
    {
        textArea.text = "";
    }

    function save()
    {
        var context = textArea.text;
        fileIO.save(context);
        console.log(fileIO.getFilePath()+"保存成功");

    }
}
