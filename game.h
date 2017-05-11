#ifndef GAME_H
#define GAME_H

#include <QObject>
#include <QList>
#include <QDebug>
#include <QMap>
class game : public QObject
{
    Q_OBJECT
public:
    explicit game(QObject *parent = 0);
    QList<QString> list1, list2;
    QMap<QString, int> map1, map2, map3, map4, map5, tempMap;
    Q_INVOKABLE int findLoc(int loc, QString direction);
    Q_INVOKABLE QString setText(int loc);
    Q_INVOKABLE QString setLocation(int loc, QString currentImg);
    int currentLoc;

signals:

public slots:
};

#endif // GAME_H
