#include <QDebug>
#include <QMap>
#include "game.h"

game::game(QObject *parent) : QObject(parent)
{
    currentLoc = 1;
    list1 << "In Front of Computer" << "On the Road" <<"You are in the Desert" << "You are near a building"
     << "You are in a valley" << "You are in the forest";
    list2 << "/files/images/computer.png" << "/files/images/road.png" << "/files/images/dessert.png"
         << "/files/images/city.png" << "/files/images/valley.png" << "/files/images/forest.png";

    map1["W"] = 2;
    map1["E"] = 3;
    map1["S"] = 4;
    map1["N"] = 5;
    map2["N"] = 5;
    map3["W"] = 1;
    map4["N"] = 1;
    map4["W"] = 2;
    map5["W"] = 2;
    map5["S"] = 1;
}

QString game::setText(int loc)
{
    qDebug() << "loc text " << loc;
    if(currentLoc != loc){
        return list1.at(loc);
    }
    else
        return "You cannot go in that direction !";
}

QString game::setLocation(int loc, QString currentImg)
{
     qDebug() << "loc Loc " << loc;
    if(currentLoc !=loc) {
        currentLoc = loc;
        return list2.at(loc);}
    else return currentImg;
}

int game::findLoc(int loc, QString direction)
{
    qDebug() << "CurrentLoc " << loc;
    switch (loc){
        case 1:
            tempMap = map1;
            break;
        case 2:
            tempMap = map2;
            break;
        case 3:
            tempMap = map3;
            break;
        case 4:
            tempMap = map4;
            break;
        case 5:
            tempMap = map5;
            break;
        default:
            qDebug() << "Weird behaviour";
            break;
    }


    QMap<char, int>::iterator i;
    if(tempMap.contains(direction))
        return tempMap.value(direction);
    return loc;


}
