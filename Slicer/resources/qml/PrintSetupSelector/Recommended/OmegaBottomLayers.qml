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


    Cura.IconWithText
    {
        id: infillPatternSelectorRowTitle
        anchors.top: parent.top
        anchors.left: parent.left
        visible: enableSupportCheckBox.visible
        source: UM.Theme.getIcon("bottom_layers")
        text: "Bottom Layers "
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

        Rectangle
        {
            id : rectangle

            
            TextField
            {
                anchors
                {
                    verticalCenter: parent.verticalCenter
                }

                id: input
                validator: IntValidator {bottom: 1; top: 10;}    
                text: bottomLayers.properties.value

                onTextChanged: {
                    bottomLayers.setPropertyValue("value", input.text)
                }

                Binding
                {
                    target: input
                    property: "text"
                    value:
                    {
                        return bottom_layers.properties.value
                    }
                    when: !input.activeFocus
                }

            }

            Label
            {
                anchors
                {
                    right: input.right
                    rightMargin: Math.round(UM.Theme.getSize("setting_unit_margin").width)
                    verticalCenter: input.verticalCenter
                }

                text: {
                    if(bottomLayers.properties.value == 1){
                        return "layer"
                    }
                    return "layers"
                }
                //However the setting value is aligned, align the unit opposite. That way it stays readable with right-to-left languages.
                horizontalAlignment:  Text.AlignLeft
                textFormat: Text.PlainText
                renderType: Text.NativeRendering
                color: UM.Theme.getColor("setting_unit")
                font: UM.Theme.getFont("default")
            }

           property var bottom_layers : UM.SettingPropertyProvider
            {
                id: bottomLayers
                containerStackId: Cura.MachineManager.activeStackId
                key: "bottom_layers"
                watchedProperties: ["value"]
                storeIndex: 0
            }
          
        }
    }

}