import 'package:flt_task/Controller/HomeScreenController.dart';
import 'package:flt_task/Screen/MapScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController controller = Get.put(HomeScreenController());

  @override
  void initState() {
    super.initState();
    controller.checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Task")),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Next 5 Days Forecast:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.separated(
                        itemCount: controller.weatherForecastList.length,
                        itemBuilder: (context, index) {
                          DateTime date = DateTime.parse(controller.weatherForecastList[index].date);
                          String formattedDate = DateFormat('dd/MM/yy hh:mm a').format(date);
                          return ListTile(
                            title: Text(
                              controller.weatherForecastList[index]
                                  .weatherDescription,
                              style: const TextStyle(fontSize: 16),
                            ),
                            subtitle: Text(
                                '${controller.weatherForecastList[index].temperature.toStringAsFixed(1)} °C'),
                            leading: Image.network(
                              'https://openweathermap.org/img/wn/${controller.weatherForecastList[index].icon}.png',
                              width: 48,
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    formattedDate.split(" ").first
                                ),
                                Text(
                                    formattedDate.split("24").last
                                )
                              ],
                            ),
                            dense: false,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                    ),
                  ),
                ],
              );
      }),
      floatingActionButton: Obx(() {
        return controller.isLoading.value
            ? Container()
            : FloatingActionButton(
                backgroundColor: Colors.blueAccent[100],
                onPressed: () {
                  Get.to(MapScreen(latLng: controller.currentPosition));
                },
                child: const Icon(Icons.pin_drop));
      }),
    );
  }
}
