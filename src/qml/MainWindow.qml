/*
 * This file is part of system-settings
 *
 * (c) 2013 Simon Busch <morphis@gravedo.de>
 *
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 3, as published
 * by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranties of
 * MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
 * PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.0

Window {
    id: window

    width: 320
    height: 480
    visible: true

    PortsHeader {
        id: header

        anchors.top: parent.top

        title: "System Settings"
        icon: "qrc:///qml/icon.png"
        taglines: [
            "Ye gods, look at all those options!",
            "46% more wub-wub than last year's Settings.",
            "For all your tinkering needs.",
            "Customizable? Customizable.",
            "E pluribus unum.",
            "Schmettings.",
            "This is where the options live, get you some!"
        ]
    }

    ListModel {
        id: settingsModel

        /* NOTE: Make sure you add new items below correctly ordered! Otherwise the
           sectioning will not work propably as ListView expects and ordered list by
           section */

        ListElement {
            title: "WiFi"
            category: "Connectivity"
            componentName: "WiFiPage"
        }

        ListElement {
            title: "Bluetooth"
            category: "Connectivity"
            componentName: "BluetoothPage"
        }

        ListElement {
            title: "Cellular"
            category: "Connectivity"
            componentName: "CellularPage"
        }

        ListElement {
            title: "About"
            category: "General"
            componentName: "AboutPage"
        }

        ListElement {
            title: "Screen & Lock"
            category: "General"
            componentName: "ScreenAndLockPage"
        }

        ListElement {
            title: "Date & Time"
            category: "General"
            componentName: "DateAndTimePage"
        }

        ListElement {
            title: "Developer Options"
            category: "General"
            componentName: "DeveloperOptionsPage"
        }
    }


    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "qrc:///qml/images/bg.png"
        z: -1
        fillMode: Image.Tile
    }

    StackView {
        id: pageStack

        width: parent.width
        anchors.top: header.bottom
        anchors.bottom: parent.bottom

        initialItem: Item {
            id: mainPage

            Flickable {
                anchors.fill: parent
                ListView {
                    id: settingsList

                    anchors.fill: parent

                    model: settingsModel
                    delegate: Rectangle {
                        width: mainPage.width
                        height: 44
                        color: "#333333"
                        Text {
                            text: title
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            font.pixelSize: 18
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Rectangle {
                            width: parent.width
                            height: 1
                            color: "black"
                            anchors.bottom: parent.bottom
                        }
                    }

                    section.property: "category"
                    section.criteria: ViewSection.FullString
                    section.delegate: Rectangle {
                        width: settingsList.width
                        height: 30
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "#777" }
                            GradientStop { position: 1.0; color: "#555" }
                        }
                        Text {
                            text: section
                            font.bold: true
                            font.pixelSize: 14
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            color: "white"
                            verticalAlignment: Text.AlignVCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
}
