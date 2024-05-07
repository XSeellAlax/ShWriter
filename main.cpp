#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "FileInfo/fileio.h"
#include "FileSysteamModule/filesystemmodel.h"
//#include "linenumbermodel.h"
#include "CommandRunner/commandrunner.h"
#include "syntaxhighlighter/highlighter.h"
#include <QIcon>
#include <QQuickTextDocument>

template <class T> T childObject(QQmlApplicationEngine& engine,
              const QString& objectName,
              const QString& propertyName)
{
    QList<QObject*> rootObjects = engine.rootObjects();
    foreach (QObject* object, rootObjects)
    {
        QObject* child = object->findChild<QObject*>(objectName);
        if (child != 0)
        {
            std::string s = propertyName.toStdString();
            QObject* object = child->property(s.c_str()).value<QObject*>();
            Q_ASSERT(object != 0);
            T prop = dynamic_cast<T>(object);
            Q_ASSERT(prop != 0);
            return prop;
        }
    }
    return (T) 0;
}
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QGuiApplication::setOrganizationName("QtProject");
    QGuiApplication::setApplicationName("ShCoder");
    QGuiApplication::setApplicationVersion(QT_VERSION_STR);
    QGuiApplication::setWindowIcon(QIcon("../icons/app_icon.svg"));
    QQmlApplicationEngine engine;

    CommandRunner commandRunner;

    qmlRegisterType<FileIO,1>("FileIO",1,0,"FileIO");
    qmlRegisterType<FileSystemModel,1>("FileSystemModule",1,0,"FileSystemModule");
    //qmlRegisterType<LineNumberModel,1>("LineNumberModel",1,0,"LineNumberModel");

    engine.rootContext()->setContextProperty("commandRunner", &commandRunner);
    // engine.rootContext()->se

    const QUrl url(u"qrc:/ShellCoder/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    // engine.l
    engine.load(url);


    QQuickTextDocument* doc = childObject<QQuickTextDocument*>(engine, "textEditor", "textDocument");
    Q_ASSERT(doc != 0);

    Highlighter* highlight = new Highlighter(doc->textDocument());
    int ret = app.exec();
    delete highlight;
    return ret;
}
