/*
 * This file is part of system-settings
 *
 * Copyright (C) 2013 Canonical Ltd.
 *
 * Contact: Alberto Mardegan <alberto.mardegan@canonical.com>
 *
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 3, as published
 * by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranties of
 * MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
 * PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "debug.h"
#include "utils.h"

#include <QGuiApplication>
#include <QProcessEnvironment>
#include <QQmlContext>
#include <QUrl>
#include <QQuickView>
#include <QtQml>
#include <QQmlApplicationEngine>

using namespace SystemSettings;

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);

    /* read environment variables */
    QProcessEnvironment environment = QProcessEnvironment::systemEnvironment();
    if (environment.contains(QLatin1String("SS_LOGGING_LEVEL"))) {
        bool isOk;
        int value = environment.value(
            QLatin1String("SS_LOGGING_LEVEL")).toInt(&isOk);
        if (isOk)
            setLoggingLevel(value);
    }

    /* Parse the commandline options to see if we've been given a panel to load,
     * and other options for the panel.
     */
    QString defaultPlugin;
    QVariantMap pluginOptions;
    parsePluginOptions(app.arguments(), defaultPlugin, pluginOptions);

    QQmlApplicationEngine engine;
    QObject::connect(&engine, SIGNAL(quit()), &app, SLOT(quit()),
                     Qt::QueuedConnection);
    qmlRegisterType<QAbstractItemModel>();
    engine.rootContext()->setContextProperty("defaultPlugin", defaultPlugin);
    engine.rootContext()->setContextProperty("pluginOptions", pluginOptions);
    engine.load (QUrl("qrc:///qml/MainWindow.qml"));

    return app.exec();
}
