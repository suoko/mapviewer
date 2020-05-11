TARGET = mapviewer
TEMPLATE = app

QT += qml network quick positioning location
SOURCES += main.cpp

# Workaround for QTBUG-38735
QT_FOR_CONFIG += location-private
#qtConfig(geoservices_mapboxgl): QT += sql
#qtConfig(geoservices_osm): QT += concurrent

RESOURCES += \
    mapviewer.qrc

OTHER_FILES +=mapviewer.qml \
    clickable.json \
    mapviewer.apparmor \
    mapviewer.desktop \
    manifest.json \
    helper.js \
    map/MapComponent.qml \
    map/MapSliders.qml \
    map/Marker.qml \
    map/CircleItem.qml \
    map/RectangleItem.qml \
    map/PolylineItem.qml \
    map/PolygonItem.qml \
    map/ImageItem.qml \
    map/MiniMap.qml \
    menus/ItemPopupMenu.qml \
    menus/MainMenu.qml \
    menus/MapPopupMenu.qml \
    menus/MarkerPopupMenu \
    forms/Geocode.qml \
    forms/GeocodeForm.ui.qml\
    forms/Message.qml \
    forms/MessageForm.ui.qml \
    forms/ReverseGeocode.qml \
    forms/ReverseGeocodeForm.ui.qml \
    forms/RouteCoordinate.qml \
    forms/Locale.qml \
    forms/LocaleForm.ui.qml \
    forms/RouteAddress.qml \
    forms/RouteAddressForm.ui.qml \
    forms/RouteCoordinateForm.ui.qml \
    forms/RouteList.qml \
    forms/RouteListDelegate.qml \
    forms/RouteListHeader.qml

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

UBUNTU_TOUCH {
    message("building for Ubuntu Touch")
    target.path = /

    # figure out the current build architecture
    CLICK_ARCH=$$system(dpkg-architecture -qDEB_HOST_ARCH)

    # substitute the architecture in the manifest file
    QMAKE_SUBSTITUTES += $$PWD/manifest.json.in
    manifest.files = manifest.json
    manifest.path = /
    INSTALLS += manifest


    click_files.path = /
    click_files.files = manifest.json mapviewer.apparmor mapviewer.desktop

    logo.path = /assets
    logo.files = $$PWD/logo.svg

    INSTALLS+=click_files logo
}


target.path = $$PWD/
INSTALLS += target
