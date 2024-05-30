// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import FileSystemModule
// import Colors
Rectangle {
    id: root

    property alias currentTabIndex: topBar.currentIndex
    required property ApplicationWindow dragWindow
    readonly property int tabBarSpacing: 10
    color: "#282421"

    component SidebarEntry: Button {
        id: sidebarButton

        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true

        icon.color: down || checked ? "#1874CD" : "gray"
        icon.width: 27
        icon.height: 27

        topPadding: 0
        rightPadding: 0
        bottomPadding: 0
        leftPadding: 0
        background: null

        Rectangle {
            id: indicator

            anchors.verticalCenter: parent.verticalCenter
            x: 2
            width: 4
            height: sidebarButton.icon.height * 1.2

            visible: sidebarButton.checked
            // color: Colors.color1
        }
    }

    // TabBar is designed to be horizontal, whereas we need a vertical bar.
    // We can easily achieve that by using a Container.
    component TabBar: Container {
        id: tabBarComponent

        Layout.fillWidth: true
        Layout.fillHeight: false

        // ButtonGroup ensures that only one button can be checked at a time.
        ButtonGroup {
            buttons: tabBarComponent.contentChildren

            // We have to manage the currentIndex ourselves, which we do by setting it to the index
            // of the currently checked button. We use setCurrentIndex instead of setting the
            // currentIndex property to avoid breaking bindings. See "Managing the Current Index"
            // in Container's documentation for more information.
            onCheckedButtonChanged: tabBarComponent.setCurrentIndex(
                Math.max(0, buttons.indexOf(checkedButton)))
        }

        contentItem: ColumnLayout {
            spacing: tabBarComponent.spacing
            Repeater {
                model: tabBarComponent.contentModel
            }
        }
    }

    ColumnLayout {
        anchors.fill: root
        anchors.topMargin: root.tabBarSpacing
        anchors.bottomMargin: root.tabBarSpacing

        spacing: root.tabBarSpacing
        TabBar {
            id: topBar

            spacing: root.tabBarSpacing
            // Shows help text when clicked.
            SidebarEntry {
                id: infoTab
                icon.source: "../icons/read.svg"/*"../icons/brands-app-store-ios.svg"*/
                checkable: true
                checked: true
            }

            // Shows the file system when clicked.
            SidebarEntry {
                id: filesystemTab

                icon.source: "../icons/image_mini.svg"
                checkable: true
            }
        }

        // This item acts as a spacer to expand between the checkable and non-checkable buttons.
        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            // Make the empty space drag our main window.
            WindowDragHandler {
                dragWindow: root.dragWindow
            }
        }

        TabBar {
            id: bottomBar

            spacing: root.tabBarSpacing
            // Opens the Qt website in the system's web browser.
            SidebarEntry {
                id: qtWebsiteButton
                icon.source: "../icons/settings.svg"
                checkable: false
                onClicked: fontDialog.visible = !fontDialog.visible
                    /*Qt.openUrlExternally("https://www.qt.io/")*/
            }

            // Opens the About Qt Window.
            SidebarEntry {
                id: aboutQtButton

                icon.source: "../icons/play.svg"
                checkable: false
                onClicked: {
                    cmd.visible = true
                    commandRunner.runCommand(editor.text)
                }
            }

            SidebarEntry {
                id: runButton

                icon.source: "../icons/bug.svg"
                checkable: false
                onClicked: {
                    cmd.visible = true
                    commandRunner.runCommand(editor.text)
                }
            }
        }
    }

    // About {
    //     id: aboutQtWindow
    //     visible: false
    // }
}
