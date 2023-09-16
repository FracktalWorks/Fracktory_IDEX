# Copyright (c) 2018 Ultimaker B.V.
# Cura is released under the terms of the LGPLv3 or higher.

from UM.Application import Application
from UM.Logger import Logger
from UM.i18n import i18nCatalog
from PyQt5.QtCore import pyqtSlot, pyqtProperty
catalog = i18nCatalog("cura")

from cura.Machines.ContainerTree import ContainerTree
from cura.CuraApplication import CuraApplication
from cura.MachineAction import MachineAction
from UM.PluginRegistry import PluginRegistry

""" Fetch materials from active BCN3D Printer and auto select them in the Material Selector """
class SyncMaterialsMachineAction(MachineAction):
    def __init__(self, application: CuraApplication):
        super().__init__("SyncMaterials", catalog.i18nc("@action", "Sync Materials"))
        self._application = application
        self._open_as_dialog = False
        self._testing = True

        """ Detect login change to update user printers """        
        self.bcn3dApiPlugin = PluginRegistry.getInstance().getPluginObject("BCN3DApi")
        self.bcn3dApiPlugin.authService.authStateChanged.connect(self._onLoginStateChanged)
   
    @pyqtSlot()
    def execute(self):
        super().execute()
        self.syncActivePrinterMaterials()
    
    @pyqtProperty(bool, constant = True)
    def visible(self) -> bool:
        return self._testing or CuraApplication.getInstance().getCuraAPI().account.isLoggedIn and Application.getInstance().getGlobalContainerStack().getMetaDataEntry("serial_number")

    def _onLoginStateChanged(self, logged_in: bool) -> None:
        Logger.info(f"_onLoginStateChanged")
        self.syncActivePrinterMaterials()

    def syncActivePrinterMaterials(self):
        if self.visible:
            self.machine_manager = self._application.getMachineManager()

            # Fetch materials
            materials = self.fetchMaterials()

            # Set materials
            for m in materials:
                Logger.info(m)
                Logger.info(m.guid)
                self.setMaterialByGUID(m.pos, m.guid)
    
    def fetchMaterials(self):
        if self._testing:
            ext0 = type('ext1', (object,), {'pos': 0, 'guid': '7cc772d4-7d43-4092-98ad-bd6bdbe26565'})() #Black PLA
            ext1 = type('ext2', (object,), {'pos': 1, 'guid': '7cc772d4-7d43-4092-98ad-bd6bdbe26565'})() #Black PLA
            materials = [ext0, ext1]
        else:
            serial_number_active_printer = Application.getInstance().getGlobalContainerStack().getMetaDataEntry("serial_number")
            materials = self._data_api_service.fetchMaterials(serial_number_active_printer) # [{pos: 0, guid: 123}, {pos:1, guid: 456}]
        return materials
    
    def setMaterialByGUID(self, position: str, material_GUID: str) -> bool:
        Logger.info(f"setMaterialByGUID")

        if self.machine_manager._global_container_stack is None:
            return False

        machine_definition_id = self.machine_manager._global_container_stack.definition.id
        position = str(position)
        extruder_stack = self.machine_manager._global_container_stack.extruderList[int(position)]
        nozzle_name = extruder_stack.variant.getName()

        materials = ContainerTree.getInstance().machines[machine_definition_id].variants[nozzle_name].materials
       
        for m in materials.items():
            material_node = m[1]
            if material_node.guid == material_GUID:
                Logger.info(f"changed material")
                self.machine_manager.setMaterial(position, material_node)
                return True
        return False