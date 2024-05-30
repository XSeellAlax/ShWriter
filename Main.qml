import QtQuick
import QtQuick.Controls
// import QtQuick.
import QtQuick.Layouts
import QtQuick.Dialogs
import FileIO
import QtQuick.Controls.Basic
import "./Qml"
import QtQuick.Window
import ImageViewer
// import "./ImageView/ImageViewControls.qml"
ApplicationWindow {

    property string currentFilePath: ""

    width: 1100
    height: 600
    id: root

    minimumWidth: 200
    minimumHeight: 100
    visible: true
    title: "ShCoder"


    FileIO {
        id: fileIO
    }


// -----------------------------------Menu Bar-----------------------------
    menuBar:
    MenuBar {
        Menu {
            title: qsTr("文件(&F)")
            MenuItem {
                text: qsTr("&打开...")
                action: readFile
            }
            MenuItem {
                text: qsTr("Open")
                onTriggered: {
                    var file_path = fileIO.getOpenFileName()
                    console.log(file_path)
                    image_centent.source = String(file_path)
                    imgView.visible = true
                    editor.visible = false

                }
            }
            MenuItem {
                text: qsTr("打开图片")
                action: openImageFolder
            }

            MenuItem {
                text: qsTr("&保存...")
                action: fileSvae
            }

            MenuItem {
                text: qsTr("&打开文件目录")
                action: openFloder
            }

            MenuItem {
                text: qsTr("&退出...")
                onTriggered: Qt.quit();
            }
        }
        Menu {
            height: 20
            title: "编辑(&E)"
        }

        Menu {
            title: qsTr("工具(&T)")

            MenuItem {
                text: qsTr("终端")
                action: terminalVisble
            }

            MenuItem {
                text: qsTr("工具栏")
                action: toolsVisble
            }

            MenuItem {
                text: qsTr("&New File")
            }

            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
        Menu {
            title: qsTr("调试(&D)")
            MenuItem {
                text: qsTr("&运行")
                action: run
            }
            MenuItem {
                text: qsTr("&New File")
            }

            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }

        Menu {
            title: "设置(&S)"
        }

        Menu {
            title: "帮助(&U)"
        }

    }
    // action -----------------------------------------------
    Action {
        id: toolsVisble
        onTriggered:{
            tools.visible = !tools.visible
        }
    }

    Action {
        id: readFile
        onTriggered: {
            editor.readFile()
            currentFilePath = editor.currFilePath
        }
    }

    Action {
        id: fileSvae
        onTriggered:{
            editor.save()
        }
    }

    Action {
        id: run
        onTriggered: {
            cmd.visible = !cmd.visible
            commandRunner.runCommand(editor.text)
        }
    }

    Action {
        id: terminalVisble
        onTriggered:{
            console.log(currentFilePath);
            cmd.visible = !cmd.visible
        }
    }

    Action {
        id: openFloder
        onTriggered: {
            currentFilePath = fileIO.getOpenFileName();
        }
    }

    Action {
        id: openImageFolder
        onTriggered: {
            image_view.open_image_folder()
        }
    }

    onCurrentFilePathChanged: {
        fileSystemView.setDir(currentFilePath);
    }
    // ImageViewControls {
    //     id: controls
    //     anchors.left: parent.left
    //     anchors.top: parent.top
    //     anchors.margins: 20
    //     width: 100
    //     height: 100
    // }


    RowLayout {
        anchors.fill: parent
        spacing: 0
        clip: true

        // Stores the buttons that navigate the application.
        Sidebar {
            id: sidebar
            dragWindow: root
            Layout.preferredWidth: 50
            Layout.fillHeight: true
        }
        Rectangle {
            id: lineRect
            width: 1
            height: parent.height
        }
        // Allows resizing parts of the UI.
        SplitView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            // Customized handle to drag between the Navigation and the Editor.
            handle: Rectangle {
                implicitWidth: 5
                // color: SplitHandle.pressed ? Colors.color2 : Colors.background
                // border.color: SplitHandle.hovered ? Colors.color2 : Colors.background
                opacity: SplitHandle.hovered || navigationView.width < 15 ? 1.0 : 0.0

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 1400
                    }
                }
            }

            Rectangle {
                id: navigationView
                // color: Colors.surface1
                // color: "#171819"
                SplitView.preferredWidth: 200
                SplitView.fillHeight: true
                // The stack-layout provides different views, based on the
                // selected buttons inside the sidebar.


                StackLayout {
                    anchors.fill: parent
                    currentIndex: sidebar.currentTabIndex
                    // Shows the help text.
                    FileSystemView {
                        id: fileSystemView
                        // color: "#171819"
                        onFileClicked: path => editor.currFilePath = path
                        // visible: {
                        //     if(currentFilePath===""){
                        //         return false;
                        //     }else{
                        //         return true;
                        //     }
                        // }
                    }
                    ImageList {
                        id: image_list
                        model: image_view.image_model
                        delegate: image_view.image_delegate
                    }
                }
            }
            StackLayout {
                currentIndex: sidebar.currentTabIndex
//---------------------------------第一部分----------------------------------------------
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
                            // color: "yellow"
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
//                        SplitView.maximumHeight: parent.height/3 * 2
//                        SplitView.fillHeight: true
                    }

//--------------------------------------------第二部分-------------------------------------------------
                ImageViewer {
                    id: image_view
                    // anchors.fill: parent
                    Rectangle {
                        anchors.fill: parent
                        color: "black"
                        opacity: 0.2
                        z: -1
                    }
                }
            }


        }
    }

    //设置对话框
    SettingView {
        id: fontDialog
        visible: false
    }
    //信号连接
//    Connections {
//        target: commandRunner
//        function onOutputReceived() {
//            cmd.text = ""
//            cmd.text = "Output: " + output + '\n'

//        }
//        function onErrorOccurred() {
//            cmd.text = "Error: " + error + '\n'
//        }
//    }

    Connections {
        target: image_list.open_image_bth
        function onClicked(){
            image_view.open_image_folder()
        }
    }
    Connections {
        target: fileSystemView.open_shell_folder
        function onClicked() {

            fileSystemView.setDir(fileIO.getOpenFolder())

        }
    }
//    Connections {
//        target: commandRunner
//        function onOutputReceived(){
////            outputModel.append("output: ")
//            cmd.outputModel.append({"output": output, "type": "output"});
//        }
//        function onErrorOccurred() {
////            outputModel.append("output: ")
//            cmd.outputModel.append({"output": error, "type": "error"});
//        }
//    }

}

