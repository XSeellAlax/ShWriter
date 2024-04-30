#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include "FileInfo/filerw.h"
#include "filesystemmodel.h"
#include <QIcon>
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QGuiApplication::setOrganizationName("QtProject");
    QGuiApplication::setApplicationName("File System Explorer");
    QGuiApplication::setApplicationVersion(QT_VERSION_STR);
    QGuiApplication::setWindowIcon(QIcon(":/qt/qml/FileSystemModule/icons/app_icon.svg"));
    QQmlApplicationEngine engine;
    qmlRegisterType<FileRW,1>("FileIO",1,0,"FileIO");
    const QUrl url(u"qrc:/ShellCoder/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);
    // engine.loadFromModule("FIleSystemMode","Main");

    return app.exec();
}
