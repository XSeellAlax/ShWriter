#include "commandrunner.h"
#include <QDebug>

CommandRunner::CommandRunner(QObject *parent) : QObject(parent)
{
}

void CommandRunner::runCommand(const QString &command)
{

    QProcess *process = new QProcess(this);
    connect(process, &QProcess::readyReadStandardOutput, [this, process]() {
        emit outputReceived(process->readAllStandardOutput());
    });
    connect(process, &QProcess::readyReadStandardError, [this, process]() {
        emit errorOccurred(process->readAllStandardError());
    });

    // 处理多个命令
    process->start("bash", QStringList() << "-c" << command);
    qDebug() << "hello world";
}
