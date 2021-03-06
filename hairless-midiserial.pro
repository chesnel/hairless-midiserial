#-------------------------------------------------
#
# Project created by QtCreator 2011-08-08T17:57:42
#
#-------------------------------------------------

QT       += core gui

TARGET = hairless-midiserial
TEMPLATE = app

DEFINES +=APPNAME=\"hairless-midiserial\"

DEFINES += VERSION=\\\"0.4\\\"

# Main Program

SOURCES += \
        main.cpp\
        mainwindow.cpp \
        src/Bridge.cpp \
    src/settingsdialog.cpp \
    src/aboutdialog.cpp \
    src/BlinkenLight.cpp

HEADERS  += \
    mainwindow.h \
    src/Bridge.h \
    src/Settings.h \
    src/settingsdialog.h \
    src/aboutdialog.h \
    src/BlinkenLight.h

FORMS += mainwindow.ui \
    src/settingsdialog.ui \
    src/aboutdialog.ui

# Universal binary for OS X

macx {
    CONFIG += ppc x86
}


# Static flags for windows

win32 {
  QMAKE_LFLAGS += -static -static-libgcc
}

# Icon stuff

win32 {
  RC_FILE = "images/icon.rc"
}
macx {
  ICON = "images/icon.icns"
}
# linux has no baked-in icon support, but we load a resource to use as a window icon

# qextserialport

HEADERS                 += qextserialport/qextserialport.h \
                          qextserialport/qextserialenumerator.h \
                          qextserialport/qextserialport_global.h
SOURCES                 += qextserialport/qextserialport.cpp

unix:SOURCES           += qextserialport/posix_qextserialport.cpp
unix:!macx:SOURCES     += qextserialport/qextserialenumerator_unix.cpp
macx {
  SOURCES          += qextserialport/qextserialenumerator_osx.cpp
  LIBS             += -framework IOKit -framework CoreFoundation
}

win32 {
  SOURCES          += qextserialport/win_qextserialport.cpp \
                      qextserialport/qextserialenumerator_win.cpp
  DEFINES          += WINVER=0x0501 # needed for mingw to pull in appropriate dbt business...probably a better way to do this
  LIBS             += -lsetupapi
}

# RtMidi

HEADERS +=    src/RtMidi.h \
              src/RtError.h \
              src/QRtMidiIn.h \

SOURCES +=    src/RtMidi.cpp \
              src/QRtMidiIn.cpp

linux-* { # linux doesn't get picked up, not sure what else to use
  DEFINES += __LINUX_ALSASEQ__
  CONFIG += link_pkgconfig x11
  PKGCONFIG += alsa
  LIBS += -lpthread
}
win32 {
  DEFINES += __WINDOWS_MM__
  LIBS += -lwinmm
}
macx {
    DEFINES += __MACOSX_CORE__
    LIBS += -framework \
        CoreMidi \
        -framework \
        CoreAudio \
        -framework \
        CoreFoundation
}

# PortLatency
SOURCES += src/PortLatency.cpp
HEADERS += src/PortLatency.h
linux-* {
   SOURCES += src/PortLatency_linux.cpp
}
win32 {
   SOURCES += src/PortLatency_win32.cpp
}
macx {
   SOURCES += src/PortLatency_osx.cpp
}

# Resources

RESOURCES += \
    resources.qrc
