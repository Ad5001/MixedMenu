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
import QtQuick.Controls 2.12 as Controls
import Qt.labs.platform 1.1 as Native

/*!
    \qmltype Action
    \inqmlmodule eu.ad5001.MixedMenu
    \brief Platform specific Action.
    
    Either loading native menu or Qt's one.

*/
Item {
    id: root
    
    signal triggered()
    signal toggled()
    
    property bool useNative: Qt.platform.os == "osx"
    property var trueItem: useNative ? nativeAction : controlsAction
    
    property alias checkable: controlsAction.checkable
    property alias checked: controlsAction.checked
    property alias enabled: controlsAction.enabled
    property alias shortcut: controlsAction.shortcut
    property alias text: controlsAction.text
    property alias iconName: controlsAction.icon.name
    property alias iconSource: controlsAction.icon.source
    property alias iconColor: controlsAction.icon.color
    
    Native.MenuItem {
        id: nativeAction
        checkable: controlsAction.checkable
        checked: controlsAction.checked
        enabled: controlsAction.enabled
        text: controlsAction.text
        shortcut: controlsAction.shortcut
        onTriggered: root.triggered()
    }
    
    Controls.Action {
        id: controlsAction
        onTriggered: root.triggered()
        onToggled: root.toggled()
    }
    
    Component.onCompleted: {
        // Forwarding to MenuBar. Little hack to make Action shortcuts work properly, because otherwise, they would not trigger
        if(shortcut != 0) {
            console.log("Adding shortcut for", text, "with shortcut", shortcut)
            parent.parent.addShortcut(shortcut, root.triggered)
        }
    }
    
    /*!
        \qmlmethod void Action::toggle()
        Toggles the \c checked state to its opposite state.
    */
    function toggle(){
        root.trueItem.toggle()
    }
}
