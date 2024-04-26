#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "FileInfo/file.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ShWriter", "Main");
    show();
    // std::cout << "hello world. " << std::endl;
    return app.exec();
}
