from . import BCN3DResources

from UM.i18n import i18nCatalog
i18n_catalog = i18nCatalog("uranium")

def getMetaData():
    return {}


def register(app):
    return {"extension": BCN3DResources.BCN3DResources()}