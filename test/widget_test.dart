import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flyful_farms/app/app.dart';
import 'package:flyful_farms/config/di.dart';

Future<void> _loadFont(String family, List<String> assets) async {
  for (final asset in assets) {
    final bytes = File('fonts/$asset').readAsBytesSync();
    final loader = FontLoader(family)
      ..addFont(Future.value(ByteData.view(bytes.buffer)));
    await loader.load();
  }
}

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    await initDI();
    await _loadFont('Poppins', [
      'Poppins-Regular.ttf',
      'Poppins-Medium.ttf',
      'Poppins-Bold.ttf',
    ]);
    await _loadFont('Outfit', [
      'Poppins-Regular.ttf',
      'Poppins-Medium.ttf',
      'Poppins-Bold.ttf',
    ]);
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const App());
    await tester.pump();

    expect(find.byType(App), findsOneWidget);
  });
}
