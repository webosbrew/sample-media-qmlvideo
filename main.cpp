#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QtQml>

int main(int argc, char *argv[])
{
    // Seems useful on 4K TVs
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setApplicationName("org.webosbrew.sample.qmlvideo");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}