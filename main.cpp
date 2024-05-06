#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include "FileInfo/fileio.h"
#include "FileSysteamModule/filesystemmodel.h"
//#include "linenumbermodel.h"
#include <QIcon>
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QGuiApplication::setOrganizationName("QtProject");
    QGuiApplication::setApplicationName("File System Explorer");
    QGuiApplication::setApplicationVersion(QT_VERSION_STR);
    QGuiApplication::setWindowIcon(QIcon(":/qt/qml/FileSystemModule/icons/app_icon.svg"));
    QQmlApplicationEngine engine;


    qmlRegisterType<FileIO,1>("FileIO",1,0,"FileIO");
    qmlRegisterType<FileSystemModel,1>("FileSystemModule",1,0,"FileSystemModule");
    //qmlRegisterType<LineNumberModel,1>("LineNumberModel",1,0,"LineNumberModel");


    const QUrl url(u"qrc:/ShellCoder/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    // engine.l
    engine.load(url);


    return app.exec();
}
