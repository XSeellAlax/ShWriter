/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
//import QtQuick.Window 6.2
//import QtQuick.Controls.Styles 6.1
//import UntitledProject9

Rectangle {
    id: rectangle
//    width: Constants.width
//    height: Constants.height
    color: "#225a81"
    border.color: "#69a2cc"
    state: "clicked"
    focus: false
    antialiasing: true
    states: [
        State {
            name: "clicked"
        }
    ]
    TextEdit {
        id: textEdit
        color: "#fefefe"
        text: "dawdawd\n\n"
        anchors.fill: parent
        font.letterSpacing: 1
        selectionColor: "#f3348295"
        textFormat: Text.MarkdownText
        persistentSelection: true
        selectByMouse: true
        overwriteMode: false
        cursorVisible: false
        font.wordSpacing: 1
        font.strikeout: false
        font.italic: false
        font.pointSize: 12
        font.bold: false
    }
}

