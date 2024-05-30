#ifndef IMAGEVIEWER_H
#define IMAGEVIEWER_H

#include <QtQuick/QQuickPaintedItem>

class ImageViewer : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT
    Q_DISABLE_COPY(ImageViewer)
public:
    explicit ImageViewer(QQuickItem *parent = nullptr);
    void paint(QPainter *painter) override;
    ~ImageViewer() override;
};

#endif // IMAGEVIEWER_H
