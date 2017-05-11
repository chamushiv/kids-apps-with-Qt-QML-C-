#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include "mouseMemory.h"
#include "game.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QScopedPointer<MouseMemory> mouse (new MouseMemory);
    QScopedPointer<game> newGame (new game);
    QQmlApplicationEngine engine;

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    engine.rootContext()->setContextProperty("mouse",mouse.data());
    engine.rootContext()->setContextProperty("game",newGame.data());

    return app.exec();
}
