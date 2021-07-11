/**
 * MixedMenu - Simple library for QML allowing the mixed use of Native Menus and QtQuick ones.
 * Copyright (C) 2021  Ad5001 <mail@ad5001.eu>
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.12
import QtQml 2.12
import QtQuick.Controls 2.12 as Controls
import Qt.labs.platform 1.1 as Native

/*!
    \qmltype MenuItem
    \inqmlmodule eu.ad5001.MixedMenu
    \brief Platform specific MenuItem.
    
    Either loading native menu or Qt's one.

*/
Item {
    id: root
    
    signal triggered()
    
    property bool useNative: Qt.platform.os == "osx"
    property var trueItem: useNative ? nativeMenuItem : controlsMenuItem
    
    property bool checkable: false
    property bool checked: false
    property bool enabled: true
    property font font: trueItem.font
    property string text: ""
    property alias iconName: controlsMenuItem.icon.name
    property alias iconSource: controlsMenuItem.icon.source
    property alias iconColor: controlsMenuItem.icon.color
    
    Native.MenuItem {
        id: nativeMenuItem
        checkable: root.checkable
        checked: root.checked
        enabled: root.enabled
        text: root.text
        visible: root.visible && root.useNative
        onTriggered: root.triggered()
    }
    
    Controls.MenuItem {
        id: controlsMenuItem
        checkable: root.checkable
        checked: root.checked
        enabled: root.enabled
        text: root.text
        visible: root.visible && !root.useNative
        height: visible ? implicitHeight : 0
        onTriggered: root.triggered()
    }
    
    /*!
        \qmlmethod void MenuItem::toggle()
        Toggles the \c checked state to its opposite state.
    */
    function toggle(){
        root.trueItem.toggle()
    }
}
