import 'package:flt_task/Model/WeatherForecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:flt_task/Screen/HomeScreen.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    testWidgets('Test HomeScreen displays CircularProgressIndicator when isLoading is true', (WidgetTester tester) async {
      // Build HomeScreen with isLoading set to true
      await tester.pumpWidget(MaterialApp(
        home: HomeScreen(
          key: UniqueKey(),
        ),
      ));

      // Verify CircularProgressIndicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Test HomeScreen displays weather forecast when isLoading is false', (WidgetTester tester) async {
      // Build HomeScreen with isLoading set to false
      await tester.pumpWidget(MaterialApp(
        home: HomeScreen(
          key: UniqueKey(),
        ),
      ));

      // Verify weather forecast is displayed
      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('Test HomeScreen displays correct formatted date', (WidgetTester tester) async {
      // Mock weather data
      final List<WeatherForecast> mockWeatherForecastList = [
        WeatherForecast(date: '2024-03-08 18:00:00', weatherDescription: 'Sunny', temperature: 25.0, icon: '01d', timestamp: 1709920800),
      ];

      // Build HomeScreen with mock weather data
      await tester.pumpWidget(MaterialApp(
        home: HomeScreen(
          key: UniqueKey(),
        ),
      ));

      // Verify correct formatted date is displayed
      final formattedDate = DateFormat('dd/MM/yy hh:mm a').format(DateTime.parse(mockWeatherForecastList[0].date));
      expect(find.text(formattedDate.split(" ").first), findsOneWidget); // Verify date part
      expect(find.text(formattedDate.split("24").last), findsOneWidget); // Verify time part
    });

    // Add more test cases as needed
  });
}
