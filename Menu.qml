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
    \qmltype Menu
    \inqmlmodule eu.ad5001.MixedMenu
    \brief Platform specific Menu.
    
    Either loading native menu or Qt's one.

*/
Item {
    id: root
    
    signal aboutToShow()
    signal aboutToHide()
    
    property bool useNative: Qt.platform.os == "osx"
    property var trueItem: useNative ? nativeMenu : controlsMenu
    
    property bool enabled: true
    property string title: ""
    property int count: 0
    property font font: root.trueItem.font
    
    Native.Menu {
        id: nativeMenu
        enabled: root.enabled
        title: root.title
        onAboutToShow: root.aboutToShow()
        onAboutToHide: root.aboutToHide()
    }
    
    Controls.Menu {
        id: controlsMenu
        enabled: root.enabled
        title: root.title
        onAboutToShow: root.aboutToShow()
        onAboutToHide: root.aboutToHide()
    }
    
    Component.onCompleted: { // Adding items to the menu
        for(var i = 0; i < root.children.length; i++) {
            var item = root.children[i]
            if(item instanceof MenuSeparator || item instanceof MenuItem) {
                addItem(item)
            } else if(item instanceof Action) {
                addAction(item)
            } else if(item instanceof Menu) {
                addMenu(item)
            }
        }
    }
    
    /*!
        \qmlmethod void Menu::addAction(Action action)
        Adds an \a action to end of the menu.
    */
    function addAction(action){
        if(root.useNative){
            nativeMenu.addItem(action.trueItem) // Is a MenuItem, Action being unavailable for Qt.labs
        } else {
            controlsMenu.addAction(action.trueItem)
        }
        root.count++
    }
    
    /*!
        \qmlmethod void Menu::addItem(MenuItem item)
        Adds an \a item to end of the menu.
    */
    function addItem(item){
        root.trueItem.addItem(item.trueItem)
        root.count++
    }
    
    /*!
        \qmlmethod void Menu::addMenu(Menu submenu)
        Adds a \a submenu to end of the menu.
    */
    function addMenu(submenu){
        root.trueItem.addMenu(submenu.trueItem)
        root.count++
    }
    
    /*!
        \qmlmethod void Menu::insertAction(index, Action action)
        Inserts an \a action at the specified \a index in the menu.
    */
    function insertAction(index, action){
        if(root.useNative){
            nativeMenu.insertItem(index, action.trueItem) // Is a MenuItem, Action being unavailable for Qt.labs
        } else {
            controlsMenu.insertAction(index, action.trueItem)
        }
        root.count++
    }
    
    /*!
        \qmlmethod void Menu::insertItem(index, MenuItem item)
        Inserts an \a item at the specified \a index in the menu.
    */
    function insertItem(index, item){
        root.trueItem.insertItem(index, item.trueItem)
        root.count++
    }
    
    /*!
        \qmlmethod void Menu::insertMenu(index, Menu submenu)
        Inserts a \a submenu at the specified \a index in the menu.
    */
    function insertMenu(index, submenu){
        root.trueItem.insertMenu(index, submenu.trueItem)
        root.count++
    }
    
    /*!
        \qmlmethod void Menu::removeAction(Action action)
        Removes an \a action to from the menu.
    */
    function removeAction(action){
        if(root.useNative){
            nativeMenu.removeItem(action.trueItem) // Is a MenuItem, Action being unavailable for Qt.labs
        } else {
            controlsMenu.removeAction(action.trueItem)
        }
        root.count--
    }
    
    /*!
        \qmlmethod void Menu::removeMenu(MenuItem item)
        Removes an \a item from the menu.
    */
    function removeItem(item){
        root.trueItem.removeItem(submenu.item)
        root.count--
    }
    
    /*!
        \qmlmethod void Menu::removeMenu(Menu submenu)
        Removes a \a submenu from the menu.
    */
    function removeMenu(submenu){
        root.trueItem.removeMenu(submenu.trueItem)
        root.count--
    }
    
    /*!
        \qmlmethod void Menu::clear()
        Removes all items from the menu.
    */
    function clear(){
        root.trueItem.clear()
        root.count = 0
    }
    
    /*!
        \qmlmethod void Menu::close()
        Closes the menu.
    */
    function close(){
        root.trueItem.close()
    }
    
    /*!
        \qmlmethod void Menu::open()
        Opens the menu at the mouse's position
    */
    function open(){
        if(root.useNative){
            nativeMenu.open()
        } else {
            controlsMenu.popup()
        }
    }
}
