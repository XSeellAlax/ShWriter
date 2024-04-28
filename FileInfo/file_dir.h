#ifndef FILE_DIR_H
#define FILE_DIR_H
#include <QDir>
class File_Dir : public QObject
{
    Q_OBJECT
public:

    File_Dir(){}
    Q_INVOKABLE bool open();
    Q_INVOKABLE QStringList getDirFile();
    // Q_INVOKABLE
private:
    QString _path;
    QDir dir;
};

#endif // FILE_DIR_H
