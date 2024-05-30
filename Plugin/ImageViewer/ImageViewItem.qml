
import QtQuick
import QtQuick.Controls
// Application
import QtQuick.Dialogs
import QtQuick.Layouts
import Qt.labs.folderlistmodel
Item
{

    property alias image_model: foldermodel
    property alias image_delegate: fileDelegate
    width: 800
    height: 480
    visible: true

    Image {
        id: image_content
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        // fillMode: Image.PreserveAspectCrop
//         source: "~/腾讯c++技能树.jpg"
        // anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.RightButton | Qt.LeftButton
            onClicked: function(mouse){
                if(mouse.button === Qt.RightButton){
                    contentMenu.popup()
                }
                console.log(parent.source)
                console.log(foldermodel.folder)
            }
            onWheel: function(wheel){
                if(wheel.modifiers & Qt.ControlModifier){
                    if(wheel.angleDelta.y > 0){
                        image_sacle(1.1)
                        // console.log("放大")
                    }else{
                        image_sacle(0.9)
                        // console.log("缩小")
                    }
                }
            }
        }
    }

    FolderListModel
    {
        id: foldermodel
        // folder: Qt.platform.os == "linux" ? "file:///root/" : "C:\Users\wp\Desktop\ImageViewer\database"
            //需要解析的文件夹
        showDirs: false         //是否显示文件夹。默认为真
        showDotAndDotDot: false //如果为真，"." and ".."目录被包含在model中，否则被排除。默认为假
        nameFilters: ["*.jpg","*.png","*.jpeg"]  //筛选过滤作用，注意的是目录不会被过滤排除
        sortField: FolderListModel.Type //设置排序模式,是一个枚举值，下面进行讲解
        showOnlyReadable: true
        sortReversed: false      //如果为真，逆转排序顺序。默认为假
    }


    Component {

            id: fileDelegate
            Rectangle {
                // width: 100
                width: parent.width - 20
                height: 20
                RowLayout{
                    spacing: 10
                    width: parent.width
                    height: parent.height - 0.1
                    Rectangle {
                        width: 20
                        height: 20
                        // color: "#D8BFD8"
                        IconImage {
                            id: icons
                            source: "qrc:/icons/image_mini.svg"
                            anchors.fill: parent
                        }

                        // Image {
                        //     id: icons
                        //     // source: ":/icons/image_mini.svg"
                        //     source: "qrc:/icons/image_mini.svg"
                        //     // source: qurl(":/icons/image_mini.svg")

                        //     anchors.fill: parent
                        // }
                    }
                    Item {
                        width: parent.width - 20
                        height: parent.height
                        Text {
                            text:  fileName //count 过滤后的文件个数
                            // width: parent.width
                            // color: foldermodel.isFolder(index)? "red" : "blue" //判断是否文件夹
                            color: "gray"
                            font.pixelSize: 12
                            clip: true
                            font.bold: true
                            anchors.left: parent.left

                        }
                    }
                }

                Rectangle {
                    color: "black"
                    width: parent.width
                    height: 0.1
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        image_content.source = foldermodel.folder + "/" + fileName
                        console.log(Qt.platform.os)

                    }
                    onReleased: {
                        parent.color = "white"
                    }
                }
            }


        }

    FolderDialog {
        id: folderdialog
        currentFolder: Qt.platform.os == "linux" ? "file:///~/" : "~/"
        // folder:""
        // currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        onAccepted: {
            foldermodel.folder = folderdialog.selectedFolder
            console.log(folderdialog.selectedFolder)
            // console.log("123: " + folderdialog.currentFolder)
        }
    }

    Menu { // 右键菜单
            //title: "Edit"
            id: contentMenu

            MenuItem{
                text: "打开文件"
                onTriggered: {
                    folderdialog.open()
                }
            }
            MenuItem{
                text: "清空"
                onTriggered: {
                    image_model.removeRows(1,image_model.rowCount())
                    console.log("清空" + image_model)


                }
            }

            MenuItem{
                text: "放大"
                onTriggered: {
                    image_content.width = image_content.width * 1.2
                    image_content.height = image_content.height * 1.2
                    // image_content.scale(0.8)
                }
            }
            MenuItem{
                text: "缩小"
                onTriggered: {
                    image_content.width = image_content.width * 0.8
                    image_content.height = image_content.height * 0.8
                    // image_content.scale(0.8)
                }
            }

            Menu {
                // Menu{
                    title: "格式转换"
                    MenuItem{
                        text: "铺满"
                        onTriggered: {
                            image_content.fillMode = Image.Stretch
                        }
                    }
                    MenuItem{
                        text: "等比例放大"
                        onTriggered: {
                            image_content.fillMode = Image.PreserveAspectFit
                        }
                    }
                    MenuItem{
                        text: "等比例切割"
                        onTriggered: {
                            image_content.fillMode = Image.PreserveAspectCrop
                        }
                    }
                // }
            }
            Menu{
                title: "旋转"
                MenuItem {
                    text: "复原"
                    onTriggered: {
                        image_content.rotation = 0
                    }
                }
                MenuItem {
                    text: "90度"
                    onTriggered: {
                        image_content.rotation += 90
                    }
                }

                MenuItem {
                    text: "180度"
                    onTriggered: {
                        image_content.rotation += 180
                    }
                }

                MenuItem {
                    text: "-90度"
                    onTriggered: {
                        image_content.rotation -= -90
                    }
                }
            }
    }
    function image_sacle(del){
        image_content.width *= del
        image_content.height *= del
    }

    function open_image_folder(){
        folderdialog.open()
    }
}


