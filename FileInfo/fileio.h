#ifndef FILEIO_H
#define FILEIO_H
#include <QString>
#include <QFile>
class FileIO : public QObject
{
    Q_OBJECT
public:
    FileIO();
    ~FileIO();
    Q_INVOKABLE QString read();
    Q_INVOKABLE void save(QString context);
    Q_INVOKABLE void saveOther(QString context);
    Q_INVOKABLE QString updateText(const QString path);
    Q_INVOKABLE QString getFileName()
    {
        return _path;
    }
    Q_INVOKABLE QString getOpenFileName();
private:
    QString _path;
    QString _dir;
    QFile* file{};
};

#endif // FILEIO_H
