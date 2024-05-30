import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item {
    SplitView {
        anchors.fill: parent
        id: mainItem
        Rectangle {
            id: navigationView
            // color: Colors.surface1
            // color: "#171819"
            SplitView.preferredWidth: 200
            SplitView.fillHeight: true
            FileSystemView {
                id: fileSystemView
                // color: "#171819"
                anchors.fill: parent
                onFileClicked: path => editor.currFilePath = path
                visible: true
                // visible: {
                //     if(currentFilePath===""){
                //         return false;
                //     }else{
                //         return true;
                //     }
                // }
            }
        }
        SplitView {
            orientation: Qt.Vertical
            SplitView.fillWidth: true
            SplitView.fillHeight: true
            SplitView {
                SplitView.fillHeight: true
                SplitView.minimumHeight: parent.height/3*2
// 主Edit部分 -----------------------------------------------------------------------
                Editor {
                    visible: true
                    objectName: "textEditor"
                    width: parent.width
                    height: parent.height
                    SplitView.minimumWidth: parent.width/4
                    SplitView.fillWidth: true
                    SplitView.fillHeight: true
                    id: editor
                }

// 工具栏部分 -----------------------------------------------------------------------------
                Rectangle {
                    id: tools
                    SplitView.minimumWidth: parent.width/8
                    visible: false
                }
            }
//------------------------------------handle部分---------------------------------------------
            handle: Rectangle {
                implicitHeight: 5
                // color: SplitHandle.pressed ? Colors.color2 : Colors.background
                // border.color: SplitHandle.hovered ? Colors.color2 : Colors.background
                color: "#0078D7"
                opacity: SplitHandle.hovered || navigationView.width < 15 ? 1.0 : 0.0

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 1400
                    }
                }
            }
//------------------------------------------终端部分----------------------------------------------

            Terminal {
                id: cmd
                SplitView.minimumHeight: parent.height/4
                visible: false
            }
        }
    }

    function toolsVisble(){
        tools.visible = !tools.visible
    }
    function readFile(){
        editor.readFile()
        currentFilePath = editor.currFilePath
    }
    function saveFile(){
        editor.save()
    }
    function runFile(){
        cmd.visible = true
        commandRunner.runCommand(editor.text)
    }
    function terminalVisble(){
        cmd.visible = !cmd.visible
    }
    function setDir(dirPath){
        fileSystemView.setDir(dirPath)
    }

    Connections {
        target: fileSystemView.open_shell_folder
        function onClicked() {

            fileSystemView.setDir(fileIO.getOpenFolder())

        }
    }
}
