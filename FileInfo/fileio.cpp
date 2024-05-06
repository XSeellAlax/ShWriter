#include "fileio.h"
#include <QFileDialog>
#include <QTextStream>
FileIO::FileIO()
{
    _path = "";
    file = new QFile;
}
FileIO::~FileIO()
{
    delete file;
}
QString FileIO::read()
{
    _path = QFileDialog::getOpenFileName();
    if(_path.isEmpty())
    {
        return "";
    }
    QString context;
    file->setFileName(_path);
    if(file->open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QTextStream in{file};
        if(file->size() <= 200'000)
        {
            context = in.readAll();
        }else{
            while(in.atEnd()){
                context += in.readLine();
            }
        }
    }
    file->close();
    return context;
}

void FileIO::save(const QString context)
{
    if(_path.isEmpty())
        _path = QFileDialog::getOpenFileName();

    file->setFileName(_path);
    if(file->open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QTextStream out{file};
        out << context;
    }
    file->close();

}

void FileIO::saveOther(const QString context)
{
    // if(_path.isEmpty())
    _path = QFileDialog::getOpenFileName();

    file->setFileName(_path);
    if(file->open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QTextStream out{file};
        out << context;
    }
    file->close();
}

QString FileIO::updateText(const QString path)
{
    _path = path;
    if(_path.isEmpty())
    {
        return "";
    }
    QString context;
    file->setFileName(_path);
    if(file->open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QTextStream in{file};
        if(file->size() <= 200'000)
        {
            context = in.readAll();
        }else{
            while(in.atEnd()){
                context += in.readLine();
            }
        }
    }
    file->close();
    return context;
}

QString FileIO::getOpenFileName()
{
    auto path = QFileDialog::getExistingDirectory();
    return path;
}
