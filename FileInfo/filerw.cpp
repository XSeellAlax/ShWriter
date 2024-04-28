#include "filerw.h"
#include <iostream>
// #include <QFileDialog>
#include <QFileDialog>
#include <QDebug>
#include <QByteArray>

void show()
{
    std::cout << "hello world. " << std::endl;
}

bool FileRW::atEnd()
{
    return file.atEnd();
}

// bool File::read()
bool FileRW:: open()
{
    _path = QFileDialog::getOpenFileName();
    qDebug() << "new";
    if(_path.isEmpty()==false)
    {
        this->file.setFileName(_path);
        file.open(QIODevice::ReadOnly);
        return true;
    }
    return false;
}

QString FileRW::readline()
{
    if(file.isOpen()==false){
        file.open(QIODevice::ReadOnly);
    }
    if(file.atEnd()==true)
        file.close();
    return file.readLine();
}

void FileRW::saveFile(QString text)
{
    if(file.isOpen()==true)
        file.close();
    if(_path.isEmpty()==true)
    {
        _path = QFileDialog::getOpenFileName();
    }else{
        file.setFileName(_path);
        bool bth = file.open(QIODevice::WriteOnly);
        // QByteArray context;
        // file.write(text);
        if(bth)
            file.write(text.toUtf8());
    }
    file.close();

}
/*
QString FileRW::readFile()
{
    _path = QFileDialog::getOpenFileName();
    qDebug() << "new";
    QByteArray context;
    if(_path.isEmpty()==false)
    {
        QFile file(_path);
        file.open(QIODevice::ReadOnly);
        context = file.readLine();
        while(file.atEnd()==false)
        {
            context += file.readLine();
        }
        // ui->textEdit->setText(context);
        file.close();

    }
    return QString(context);
}*/

// QString FileRW::readLine()
// {
//     if(_path.isEmpty()==false)
//     {
//         QString line = file.readLine();
//     }
// }
