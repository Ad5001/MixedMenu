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
    \qmltype MenuSeparator
    \inqmlmodule eu.ad5001.MixedMenu
    \brief Platform specific MenuBar.
    
    Either loads Qt's emulated one or the native one.
*/
Item {
    id: root
    
    property bool useNative: Qt.platform.os == "osx"
    property var trueItem: useNative ? nativeSeparator : controlsSeparator
    
    Native.MenuSeparator {
        id: nativeSeparator
        visible: root.visible && root.useNative
    }
    
    Controls.MenuSeparator {
        id: controlsSeparator
        visible: root.visible && !root.useNative
    }
}
