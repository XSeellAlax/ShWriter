import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    property bool ctrlPressed: false

    property real fontPointSize: 15

    property string currFilePath: ""

    property string text: edit.text


    Flickable {
        id: flick
        Layout.fillHeight: true
        Layout.fillWidth: true
        contentWidth: edit.paintedWidth
        contentHeight: edit.paintedHeight
        clip: true
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
            //font.pointSize: fontPointSize
            selectionColor: "#C3C3FF"
            cursorVisible: true
            //cursorDelegate: cursor_Delegate
            wrapMode: TextEdit.Wrap

            // onCursorRectangleChanged: {
            //     lineLight.y = cursorRectangle.y
            // }

            onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
         }
         // 滚动条
         ScrollBar.horizontal: ScrollBar {}
         ScrollBar.vertical: ScrollBar {}
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
}
