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
    \qmltype MenuBar
    \inqmlmodule eu.ad5001.MixedMenu
    \brief Platform specific MenuBar.
    
    Either loading native menu or Qt's one.

*/
Item {
    id: root
    
    property bool useNative: Qt.platform.os == "osx"
    property var trueItem: useNative ? nativeMenuBar : controlsMenuBar
    
    Native.MenuBar {
        id: nativeMenuBar
    }
    
    Controls.MenuBar {
        id: controlsMenuBar
    }
    
    Component.onCompleted: { // Adding items to the menu
        for(var i = 0; i < root.children.length; i++) {
            var item = root.children[i]
            if(item instanceof Menu) {
                addMenu(item)
            }
        }
    }
    
    /*!
        \qmlmethod void MenuBar::addMenu(Menu menu)
        Adds a \a menu to end of the menubar.
    */
    function addMenu(menu){
        root.trueItem.addMenu(menu.trueItem)
    }
    
    /*!
        \qmlmethod void MenuBar::insertMenu(index, Menu menu)
        Inserts a \a menu at the specified \a index in the menubar.
    */
    function insertMenu(index, menu){
        root.trueItem.insertMenu(index, menu.trueItem)
    }
    
    /*!
        \qmlmethod void MenuBar::removeMenu(Menu menu)
        Removes a \a menu from the menubar.
    */
    function removeMenu(menu){
        root.trueItem.removeMenu(menu.trueItem)
    }
    
    /*!
        \qmlmethod void MenuBar::clear()
        Removes all menus from the menubar.
    */
    function clear(){
        root.trueItem.clear()
    }
    
    /*!
        \qmlmethod void MenuBar::addShortcut(keysequence sequence, var trigger)
        Little hack to make Action shortcuts work properly.
    */
    function addShortcut(sequence, trigger) {
        var newShortcut = Qt.createQmlObject(`
        import QtQuick 2.12; 
        Shortcut {
            context: Qt.ApplicationShortcut
        }`, root, "shortcut" + sequence);
        newShortcut.sequence = sequence
        newShortcut.activated.connect(trigger)
    }
}
