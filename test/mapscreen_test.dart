import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flt_task/Screen/MapScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  const initialPosition = LatLng(40.7128, -74.0060);
  group('MapScreen Widget Tests', () {

    testWidgets('Test MapScreen displays correctly with temperature layer initially', (WidgetTester tester) async {
      // Mock the initial position
      const initialPosition = LatLng(40.7128, -74.0060);

      // Build MapScreen widget
      await tester.pumpWidget(MaterialApp(
        home: MapScreen(
          latLng: Position.fromMap({
            'latitude': initialPosition.latitude,
            'longitude': initialPosition.longitude,
          }),
        ),
      ));

      // Verify the AppBar title
      expect(find.text('Temperature Layer'), findsOneWidget);

      // Verify the FloatingActionButton icon
      expect(find.byIcon(Icons.cloud), findsOneWidget);

      // Verify that the GoogleMap widget is displayed
      expect(find.byType(GoogleMap), findsOneWidget);
    });

    testWidgets('Test MapScreen switches to precipitation layer on button press', (WidgetTester tester) async {

      // Build MapScreen widget
      await tester.pumpWidget(MaterialApp(
        home: MapScreen(
          latLng: Position.fromMap({
            'latitude': initialPosition.latitude,
            'longitude': initialPosition.longitude,
          }),
        ),
      ));

      // Tap on the floating action button to switch layers
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      // Verify the AppBar title changes
      expect(find.text('Precipitation Layer'), findsOneWidget);

      // Verify the FloatingActionButton icon changes
      expect(find.byIcon(Icons.local_fire_department_rounded), findsOneWidget);
    });
    // Add more test cases as needed
  });
}
