import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:weather_jano/consts/images.dart';
import 'package:weather_jano/consts/strings.dart';
import 'package:weather_jano/controllers/main_controller.dart';
import 'package:weather_jano/models/current_weather_model.dart';
import 'models/hourly_weather_model.dart';
import 'our_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const WeatherApp(),
      title: "Weather App",
    );
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    var date = DateFormat("yMMMMd").format(DateTime.now());
    var theme = Theme.of(context);
    var controller = Get.put(MainController());
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: "$date".text.color(theme.primaryColor).make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Obx(
                () => IconButton(
                onPressed: () {
                  controller.changeTheme();
                },
                icon:
                Icon(controller.isDark.value ? Icons.light_mode : Icons.dark_mode, color: theme.iconTheme.color)),
          ),
    ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder(
          future: controller.currentWeatherData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              CurrentWeatherData data = snapshot.data;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "${data.name}"
                        .text
                        .fontFamily("poppins_bold")
                        .uppercase
                        .size(32)
                        .color(theme.primaryColor)
                        .letterSpacing(1)
                        .make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                            "assets/weather/${data.weather![0]!.icon}.png",
                            height: 80,
                            width: 80),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: "${data.main!.temp}" "$degree",
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 64,
                              fontFamily: "poppins",
                            ),
                          ),
                          TextSpan(
                            text: "${data.weather![0]?.main}",
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 18,
                              letterSpacing: 2,
                              fontFamily: "poppins",
                            ),
                          ),
                        ]))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                            onPressed: null,
                            icon: Icon(
                              Icons.expand_less_rounded,
                              color: theme.iconTheme.color,
                            ),
                            label: "${data.main!.temp}" "$degree"
                                .text
                                .color(theme.iconTheme.color)
                                .make()),
                        TextButton.icon(
                            onPressed: null,
                            icon: Icon(
                              Icons.expand_more_rounded,
                              color: theme.primaryColor,
                            ),
                            label: "${data.main!.tempMin}" "$degree"
                                .text
                                .color(theme.iconTheme.color)
                                .make()),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(3, (index) {
                        var iconsList = [clouds, humidity, windspeed];
                        var values = [
                          "${data.clouds!.all}",
                          "${data.main!.humidity}",
                          "${data.wind!.speed} Km/h"
                        ];
                        return Column(
                          children: [
                            Image.asset(
                              iconsList[index],
                              height: 60,
                              width: 60,
                            )
                                .box
                                .color(theme.primaryColor)
                                .padding(EdgeInsets.all(5))
                                .roundedSM
                                .make(),
                            10.heightBox,
                            values[index].text.color(theme.primaryColor).make()
                          ],
                        );
                      }),
                    ),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    FutureBuilder(
                      future: controller.hourlyWeatherData,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          HourlyWeatherData hourlyData = snapshot.data;
                          return SizedBox(
                            height: 150,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: hourlyData.list!.length > 6
                                  ? 6
                                  : hourlyData.list!.length,
                              itemBuilder: (BuildContext context, int index) {
                                var time = DateFormat.jm().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        hourlyData.list![index].dt!.toInt() *
                                            1000));
                                return Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(right: 4),
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(children: [
                                    "$time ".text.color(Vx.gray400).make(),
                                    Image.asset(
                                        "assets/weather/${hourlyData.list![index].weather![0].icon}.png"),
                                    "${hourlyData.list![index].main!.temp}$degree"
                                        .text
                                        .color(Vx.gray400)
                                        .make(),
                                  ]),
                                );
                              },
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    10.heightBox,
                    Divider(),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Next 7 Days"
                            .text
                            .semiBold
                            .size(18)
                            .color(theme.primaryColor)
                            .make(),
                        TextButton(
                            onPressed: () {}, child: "View All".text.make()),
                      ],
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        var day = DateFormat("EEEE").format(
                            DateTime.now().add(Duration(days: index + 1)));
                        return Card(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: day.text.semiBold.make()),
                                Expanded(
                                  child: TextButton.icon(
                                      onPressed: null,
                                      icon: Image.asset(
                                        "assets/weather/50n.png",
                                        width: 40,
                                      ),
                                      label: "21$degree".text.make()),
                                ),
                                RichText(
                                    text: const TextSpan(children: [
                                  TextSpan(
                                    text: "27$degree / ",
                                    style: TextStyle(
                                        color: Vx.gray800,
                                        fontFamily: "poppins",
                                        fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: "19$degree",
                                    style: TextStyle(
                                        color: Vx.gray600,
                                        fontFamily: "poppins",
                                        fontSize: 16),
                                  )
                                ])),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
