package com.example.flutter_caminhadas_maps

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class CaminhadasWidget : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.caminhadas_widget).apply {
                // Ao tocar no widget, abre o app
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java
                )
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                setTextViewText(R.id.tv_titulo, widgetData.getString("w_titulo", "Caminhadas"))
                setTextViewText(R.id.tv_distancia, widgetData.getString("w_distancia", "--"))
                setTextViewText(R.id.tv_detalhes, widgetData.getString("w_detalhes", ""))
                setTextViewText(R.id.tv_total, widgetData.getString("w_total", ""))
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
