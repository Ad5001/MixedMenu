# MixedMenu
Simple library for QML allowing the mixed use of Native Menus and QtQuick ones.    
---
It provides near drop-in replacements for QtQuick.Controls 2 menus making use of the platform native ones on supported platforms like MacOSX.    
It can be used for MenuBars, as well as context menus.   

# Switching from QtQuick.Controls 2

## Add MixedMenu as QML module
The first thing you need to do is to add MixedMenu to your QML Import Path.   
To do so, follow these steps:
1. Go into a QML Import path directory in your project (or Qt's main QML import path).
2. Create an "eu" directory, within an "ad5001" directory should be created.
3. Go into the "ad5001" folder
4. Install MixedMenu there.
    - If you're using Git as version control, you can use `git submodule add https://git.ad5001.eu/Ad5001/MixedMenu`.
    - Otherwise, simply clone the repository using `git clone https://git.ad5001.eu/Ad5001/MixedMenu`.
    - Or download the archive from [here](https://git.ad5001.eu/Ad5001/MixedMenu/archive/main.zip).


## Code changes
When switching from QtQuick.Controls 2 to MixedMenu, the following changes need to be made to your Menu code:    

|QtQuick.Controls2/Qt.labs            | > |eu.ad5001.MixedMenu                                     |
|-------------------------------------|---|--------------------------------------------------------|
|`import import QtQuick.Controls 2.12`| > |`import eu.ad5001.MixedMenu 1.0`                        |
|`icon.name: ...`                     | > |`iconName: ...`                                         |
|`icon.source: ...`                   | > |`iconSource: ...`                                       |
|`icon.color: ...`                    | > |`iconColor: ...`                                        |
|`menuBar: MenuBar {}`                | > |`MenuBar { id: appMenu }`<br>`menuBar: appMenu.trueItem`|


## Requirements
MixedMenu requires Qt version >5.12 with QML support enabled.
