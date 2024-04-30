#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include "FileInfo/filerw.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<FileRW,1>("FileIO",1,0,"FileIO");
    const QUrl url(u"qrc:/ShellCoder/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
