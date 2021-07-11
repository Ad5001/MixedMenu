# MixedMenu
Simple library for QML allowing the mixed use of Native Menus and QtQuick ones.    

It provides near drop-in replacements for QtQuick.Controls2 menus allowing to use the platform native ones on supported platforms like MacOSX.
Only required change:    

|QtQuick.Controls2/Qt.labs| > |eu.ad5001.MixedMenu                                     |
|-------------------------|---|--------------------------------------------------------|
|`icon.name: ...`         | > |`iconName: ...`                                         |
|`icon.source: ...`       | > |`iconSource: ...`                                       |
|`icon.color: ...`        | > |`iconColor: ...`                                        |
|`menuBar: MenuBar {}`    | > |`MenuBar { id: appMenu }`<br>`menuBar: appMenu.trueItem`|


Requires Qt version >5.12
