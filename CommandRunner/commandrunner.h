#ifndef COMMANDRUNNER_H
#define COMMANDRUNNER_H

#include <QObject>
#include <QProcess>

class CommandRunner : public QObject
{
    Q_OBJECT
public:
    explicit CommandRunner(QObject *parent = nullptr);

signals:
    void outputReceived(const QString &output);
    void errorOccurred(const QString &error);

public slots:
    void runCommand(const QString &command);
};

#endif // COMMANDRUNNER_H
