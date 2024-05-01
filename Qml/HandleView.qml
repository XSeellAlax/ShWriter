import QtQuick

Rectangle {

    property alias implicitHeight: implicitHeight
    property alias implicitWidth: implicitWidth
    color: SplitHandle.pressed ? Colors.color2 : Colors.background
    border.color: SplitHandle.hovered ? Colors.color2 : Colors.background
    opacity: SplitHandle.hovered || navigationView.width < 15 ? 1.0 : 0.0

    Behavior on opacity {
            OpacityAnimator {
                duration: 1400
            }
        }
}
