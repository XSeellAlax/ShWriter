// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
// import FileSystemModule

Rectangle {
    id: root

    property alias currentTabIndex: topBar.currentIndex
    required property ApplicationWindow dragWindow
    readonly property int tabBarSpacing: 10

    color: "#090A0C"

    component SidebarEntry: Button {
        id: sidebarButton

        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true

        icon.color: down || checked ? "#D5B35D" : "#383737"
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
            color: "#A7B464"
        }
    }

    // TabBar is designed to be horizontal, whereas we need a vertical bar.
    // We can easily achieve that by using a Container.
    component TabBar: Container {
        id: tabBarComponent

        Layout.fillWidth: true
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
                icon.source: "/images/icons/light_bulb.svg"
                checkable: true
                checked: true
            }

            // Shows the file system when clicked.
            SidebarEntry {
                id: filesystemTab

                icon.source: "/images/icons/read.svg"
                checkable: true
            }
        }

        // This item acts as a spacer to expand between the checkable and non-checkable buttons.
        // Item {
        //     Layout.fillHeight: true
        //     Layout.fillWidth: true

        //     // Make the empty space drag our main window.
        //     WindowDragHandler {
        //         dragWindow: root.dragWindow
        //     }
        // }

        TabBar {
            id: bottomBar

            spacing: root.tabBarSpacing
            // Opens the Qt website in the system's web browser.
            SidebarEntry {
                id: qtWebsiteButton
                // icon.source:
                icon.source: "/images/icons/globe.svg"
                // icon.source: "/images/icons/globe.svg"
                checkable: false
                onClicked: Qt.openUrlExternally("https://www.qt.io/")
            }

            // Opens the About Qt Window.
            SidebarEntry {
                id: aboutQtButton

                icon.source: "/images/icons/info_sign.svg"
                checkable: false
                onClicked: aboutQtWindow.visible = !aboutQtWindow.visible
            }
        }
    }

    // About {
    //     id: aboutQtWindow
    //     visible: false
    // }
}
