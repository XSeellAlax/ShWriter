#include "file_dir.h"

// file_dir::file_dir() {}
#include <QFileDialog>
bool ::File_Dir::open()
{
    _path = QFileDialog::getOpenFileName();
    dir.setPath(_path);
    if(dir.exists()==true){
        return true;
    }else{
        return false;
    }
}


QStringList File_Dir::getDirFile()
{
    return dir.entryList();
}
