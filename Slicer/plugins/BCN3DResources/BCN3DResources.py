from UM.Extension import Extension
import xml.etree.cElementTree as ET

""" This class would check for 'BCN3D Resources' updates to download them into files """
class BCN3DResources(Extension):
    def __init__(self) -> None:
        super().__init__()
        self._materials_path = "resources/materials/"
        self._material_manuacturer = "BCN3D Technologies"
        self.material_name = "example-material"
        self.fetch_materials()
        
    def fetch_materials(self):
        fdmmaterial = ET.Element("fdmmaterial")

        metadata = ET.SubElement(fdmmaterial, "metadata")
        ET.SubElement(fdmmaterial, "properties")

        ET.SubElement(metadata, "field1", name="blah").text = "some value1"
        ET.SubElement(metadata, "field2", name="asdfasd").text = "some vlaue2"

        tree = ET.ElementTree(fdmmaterial)
        # Only on Python 3.9
        #ET.indent(tree, space="\t", level=0) 
        tree.write(self._materials_path + self._material_manuacturer +"/"+ self.material_name + ".xml")
        #