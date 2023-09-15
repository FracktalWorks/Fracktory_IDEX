// Copyright (c) 2018 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.10
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import UM 1.2 as UM
import UM 1.3 as UMPU
import Cura 1.0 as Cura

Item
{
    id: recommendedSimplyPrintSetup

    height: childrenRect.height + 2 * padding

    property Action configureSettings

     // Set the current mode index to the value that is stored in the preferences or Recommended mode otherwise.
    property int currentTabIndex:
    {
        return 0
    }

    property bool settingsEnabled: Cura.ExtruderManager.activeExtruderStackId || extrudersEnabledCount.properties.value == 1
    property real padding: UM.Theme.getSize("thick_margin").width

    UMPU.TabRow
    {
        id: recommendedTabBar

        anchors
        {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: parent.padding
        }

        UMPU.TabRowButton
        {
            text: "Quality"
            onClicked:
            {
                onClicked: currentTabIndex = 0
            }
        }
        UMPU.TabRowButton
        {
            text: "Structure"
            onClicked:
            {
                onClicked: currentTabIndex = 1
            }
        }

    }
    Column
    {
        spacing: UM.Theme.getSize("wide_margin").height

        visible: currentTabIndex == 0

        anchors
        {
            left: parent.left
            right: parent.right
            //top: parent.top
            top: Cura.MachineManager.activeMachine.definition.name == "Omega I60" ? recommendedTabBar.bottom : parent.top
            margins: parent.padding
        }

        // TODO
        property real firstColumnWidth: Math.round(width / 3)

        RecommendedQualityProfileSelector
        {
            width: parent.width
            // TODO Create a reusable component with these properties to not define them separately for each component
            labelColumnWidth: parent.firstColumnWidth
        }

        RecommendedSupportSelector
        {
            width: parent.width
            // TODO Create a reusable component with these properties to not define them separately for each component
            labelColumnWidth: parent.firstColumnWidth
        }

        RecommendedAdhesionSelector
        {
            width: parent.width
            // TODO Create a reusable component with these properties to not define them separately for each component
            labelColumnWidth: parent.firstColumnWidth
        }
    }

    Column
    {
        spacing: UM.Theme.getSize("wide_margin").height

        visible: currentTabIndex == 1

        anchors
        {
            left: parent.left
            right: parent.right
            //top: parent.top
            top: Cura.MachineManager.activeMachine.definition.name == "Omega I60" ? recommendedTabBar.bottom : parent.top
            margins: parent.padding
        }

        // TODO
        property real firstColumnWidth: Math.round(width / 3)

        RecommendedInfillDensitySelector
        {
            width: parent.width
            // TODO Create a reusable component with these properties to not define them separately for each component
            labelColumnWidth: parent.firstColumnWidth
        }

        OmegaRecommendedInfillPatternSelector
        {
            width: parent.width
            // TODO Create a reusable component with these properties to not define them separately for each component
            labelColumnWidth: parent.firstColumnWidth
            visible : Cura.MachineManager.activeMachine.definition.name == "Omega I60"
        }

        OmegaWallLineCount
        {
            width: parent.width
            // TODO Create a reusable component with these properties to not define them separately for each component
            labelColumnWidth: parent.firstColumnWidth
            visible : Cura.MachineManager.activeMachine.definition.name == "Omega I60"
        }

        OmegaTopLayers
        {
            width: parent.width
            // TODO Create a reusable component with these properties to not define them separately for each component
            labelColumnWidth: parent.firstColumnWidth
            visible : Cura.MachineManager.activeMachine.definition.name == "Omega I60"
        }

        OmegaBottomLayers
        {
            width: parent.width
            // TODO Create a reusable component with these properties to not define them separately for each component
            labelColumnWidth: parent.firstColumnWidth
            visible : Cura.MachineManager.activeMachine.definition.name == "Omega I60"
        }
    }

    UM.SettingPropertyProvider
    {
        id: extrudersEnabledCount
        containerStack: Cura.MachineManager.activeMachine
        key: "extruders_enabled_count"
        watchedProperties: [ "value" ]
        storeIndex: 0
    }
}
