import QtQuick
import QtQuick.Controls
// Application
import QtQuick.Dialogs
import QtQuick.Layouts
import Qt.labs.folderlistmodel
Item
{
    width: 800
    height: 480
    visible: true
    // menuBar: MenuBar {
    //     Menu {
    //         title: "文件"
    //         MenuItem{
    //             text: "Open"
    //             onTriggered: {
    //                 // floderdialog.open()
    //                 folderdialog.open()
    //             }
    //         }
    //     }
    //     Menu {
    //         title: "处理"
    //         MenuItem{
    //             text: "放大"
    //             onTriggered: {
    //                 image_content.width = image_content.width * 1.2
    //                 image_content.height = image_content.height * 1.2
    //                 // image_content.scale(0.8)
    //             }
    //         }
    //         MenuItem{
    //             text: "缩小"
    //             onTriggered: {
    //                 image_content.width = image_content.width * 0.8
    //                 image_content.height = image_content.height * 0.8
    //                 // image_content.scale(0.8)
    //             }
    //         }

    //         Menu {
    //             // Menu{
    //                 title: "格式转换"
    //                 MenuItem{
    //                     text: "铺满"
    //                     onTriggered: {
    //                         image_content.fillMode = Image.Stretch
    //                     }
    //                 }
    //                 MenuItem{
    //                     text: "等比例放大"
    //                     onTriggered: {
    //                         image_content.fillMode = Image.PreserveAspectFit
    //                     }
    //                 }
    //                 MenuItem{
    //                     text: "等比例切割"
    //                     onTriggered: {
    //                         image_content.fillMode = Image.PreserveAspectCrop
    //                     }
    //                 }
    //             // }
    //         }
    //         Menu{
    //             title: "旋转"
    //             MenuItem {
    //                 text: "复原"
    //                 onTriggered: {
    //                     image_content.rotation = 0
    //                 }
    //             }
    //             MenuItem {
    //                 text: "90度"
    //                 onTriggered: {
    //                     image_content.rotation += 90
    //                 }
    //             }

    //             MenuItem {
    //                 text: "180度"
    //                 onTriggered: {
    //                     image_content.rotation += 180
    //                 }
    //             }

    //             MenuItem {
    //                 text: "-90度"
    //                 onTriggered: {
    //                     image_content.rotation -= -90
    //                 }
    //             }
    //         }

    //     }
    // }


    Row {
        anchors.fill: parent
        ListView{
            id: folder
            width: 150
            height: parent.height
            spacing: 1
            // anchors.centerIn: parent
            model: foldermodel
            delegate: fileDelegate
        }
        Item {
            width: parent.width - folder.width
            height: parent.height
            Image {
                id: image_content
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                // fillMode: Image.PreserveAspectCrop
                // source:
                // anchors.fill: parent
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.RightButton | Qt.LeftButton
                    onClicked: {
                        if(mouse.button === Qt.RightButton){
                            contentMenu.popup()
                        }
                        console.log(parent.source)
                    }

                    onWheel: {
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
        }
    }

    FolderListModel
    {
        id: foldermodel
        folder: "~/Desktop"    //需要解析的文件夹
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
                width: folder.width
                height: 25
                // border.color: "black"
                Text {
                    text:  fileName //count 过滤后的文件个数
                    color: foldermodel.isFolder(index)? "red" : "blue" //判断是否文件夹
                    font.pixelSize: 10
                    anchors.centerIn: parent

                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        image_content.source = foldermodel.folder + "/" + fileName
                    }
                    onReleased: {
                        parent.color = "white"
                    }
                }
            }


        }

    FolderDialog {
        id: folderdialog
        currentFolder: "~/"
        onAccepted: {
            foldermodel.folder = folderdialog.currentFolder
        }
    }


    FileDialog {
        id: filedialog
        currentFolder: "~/"
        onAccepted: {
            image_content.source = filedialog.currentFile
            // image_content2.source = filedialog.currentFile
        }
    }

    Menu { // 右键菜单
            //title: "Edit"
            id: contentMenu

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
}


