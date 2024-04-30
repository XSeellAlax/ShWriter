#ifndef FILERW_H
#define FILERW_H
// #include <fstream>
#include <QFile>
#include <QString>
// #include <QQmlEngine>
class FileRW : public QObject
{
    Q_OBJECT
    // QML_ELEMENT
// private:

public:
    // Q_INVOKABLE QString readFile();
    Q_INVOKABLE QString readline();
    Q_INVOKABLE bool atEnd();
    Q_INVOKABLE bool open();
    Q_INVOKABLE void saveFile(QString text);
    Q_INVOKABLE QString getFilePath(){
        return _path;
    }
    // ~FileRW();
    // Q_INVOKABLE QString getFilePath();

private:
    QString _path;
    QFile file;
    QString readLine();
};

extern void show();
#endif
