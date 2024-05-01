#ifndef FILERW_H
#define FILERW_H
// #include <fstream>
#include <QFile>
#include <QString>
#include <QFileDialog>
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
    Q_INVOKABLE bool open(QString pathName);
    Q_INVOKABLE void saveFile(QString text);
    Q_INVOKABLE QString getFilePath(){
        return _path;
    }

    Q_INVOKABLE QString getOpenFileName(){
        auto dir = QFileDialog::getExistingDirectory();
        return dir;
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
