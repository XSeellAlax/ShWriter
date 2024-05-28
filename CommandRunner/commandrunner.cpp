#include "commandrunner.h"

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
    process->start(command);
}
