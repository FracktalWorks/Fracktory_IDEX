// Copyright (c) 2020 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.10
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.3 as Controls2

import UM 1.2 as UM
import Cura 1.0 as Cura



Item
{
    id: enableSupportRow
    height: childrenRect.height

    property real labelColumnWidth: Math.round(width / 3)

    property var isCurrentItemActivated:
    {
        var model= CuraApplication.getExtrudersModel()
        var material = CuraApplication.getMaterialManagementModel()
        return base.currentItem.root_material_id == root_material_id
    }

    Cura.IconWithText
    {
        id: infillPatternSelectorRowTitle
        anchors.top: parent.top
        anchors.left: parent.left
        visible: enableSupportCheckBox.visible
        source: UM.Theme.getIcon("big_category_infill")
        text: catalog.i18nc("@label", "Fill Pattern")
        font: UM.Theme.getFont("medium")
        width: labelColumnWidth
    } 

    Item
    {
        id: infillSliderContainer
        height: childrenRect.height

        anchors
        {
            left: infillPatternSelectorRowTitle.right
            right: parent.right
            verticalCenter: infillPatternSelectorRowTitle.verticalCenter
        }

        property var selectedOptionIndex: 0
        property var infillPattern: UM.SettingPropertyProvider {
            containerStackId: Cura.MachineManager.activeStackId
            key: "infill_pattern"
            watchedProperties: ["value"]
            storeIndex: 0
        }

        ListModel {
            id : cbItemsModel
            ListElement { text: "Grid"; value : "grid" }
            ListElement { text: "Lines"; value : "lines" }
            ListElement { text: "Triangles"; value : "triangles" }
            ListElement { text: "Tri-Hexagon"; value : "trihexagon" }
            ListElement { text: "Cubic"; value : "cubic" }
            ListElement { text: "Cubic Subdivision"; value : "cubicsubdiv" }
            ListElement { text: "Octet"; value : "tetrahedral" }
            ListElement { text: "Quarter Cubic"; value : "quarter_cubic" }
            ListElement { text: "Concentric"; value : "concentric" }
            ListElement { text: "Zig Zag"; value : "zigzag" }
            ListElement { text: "Cross"; value : "cross" }
            ListElement { text: "Cross 3D"; value : "cross_3d" }
            ListElement { text: "Gyroid"; value : "gyroid" }
        }

        ComboBox {
            id : comboElement
            currentIndex: {
                var index = 0
                for (var i = 0; i < cbItemsModel.count; i++)
                {
                    if (cbItemsModel.get(i).value == infillPattern.properties.value)
                    {
                        return i
                    }
                }  
                return index
            }
            model: cbItemsModel
            onCurrentIndexChanged: {
                Cura.MachineManager.setSettingForAllExtruders("infill_pattern", "value", String(cbItemsModel.get(currentIndex).value))
            }
        }

        UM.SettingPropertyProvider
        {
            id: infillPattern
            containerStackId: Cura.MachineManager.activeStackId
            key: "infill_pattern"
            watchedProperties: ["value"]
            storeIndex: 0
        }
    }

}