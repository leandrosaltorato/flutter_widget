import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

import '../models/caminhada.dart';
import 'storage_service.dart';

class WidgetService {
  static const _androidName = 'com.example.flutter_caminhadas_maps.CaminhadasWidget';

  static Future<void> atualizar() async {
    try {
      final lista = await StorageService.listar();

      if (lista.isEmpty) {
        await HomeWidget.saveWidgetData<String>(
            'w_titulo', 'Nenhuma caminhada');
        await HomeWidget.saveWidgetData<String>(
            'w_distancia', 'Abra o app e crie a primeira');
        await HomeWidget.saveWidgetData<String>('w_detalhes', '');
        await HomeWidget.saveWidgetData<String>('w_total', '0 caminhadas');
      } else {
        final ultima = lista.first;
        final totalMetros =
            lista.fold<double>(0, (soma, c) => soma + c.distanciaMetros);

        await HomeWidget.saveWidgetData<String>('w_titulo', ultima.titulo);
        await HomeWidget.saveWidgetData<String>(
            'w_distancia', formatarDistancia(ultima.distanciaMetros));
        await HomeWidget.saveWidgetData<String>('w_detalhes',
            '${ultima.calorias.round()} kcal  •  ${formatarTempo(ultima.tempoMinutos)}');
        await HomeWidget.saveWidgetData<String>('w_total',
            '${lista.length} caminhadas  •  ${formatarDistancia(totalMetros)} no total');
      }

      await HomeWidget.updateWidget(qualifiedAndroidName: _androidName);
    } catch (e) {
      debugPrint('Falha ao atualizar o widget: $e');
    }
  }

  static Future<void> fixar() async {
    try {
      await HomeWidget.requestPinWidget(qualifiedAndroidName: _androidName);
    } catch (e) {
      debugPrint('Falha ao fixar o widget: $e');
    }
  }
}
