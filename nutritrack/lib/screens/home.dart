import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nutritrack/commons/global_variables.dart';
import 'package:nutritrack/services/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String formattedDate = DateFormat('MMMM d').format(DateTime.now());

class _HomeScreenState extends State<HomeScreen> {
  var username;
  var userDailyStats;
  final ApiService _apiService = ApiService();

  String result = 'Today, $formattedDate';

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _apiService.getUserByID(id: prefs.getInt('userID')!);

    setState(() {
      username = response.data[0]['username'];
    });
    print(prefs.getInt('userID'));
    getDailyStats();
  }

  getDailyStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _apiService.getDailyStats(id: prefs.getInt('userID')!);
    setState(() {
      userDailyStats = response.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    print(userDailyStats);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: username != null && userDailyStats != null ? Padding(
        padding: const EdgeInsets.only(top: 80),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Hi, $username",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          result,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Icon(Icons.notifications_active),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    height: 320,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: SemicircularIndicator(
                                  strokeCap: StrokeCap.round,
                                  strokeWidth: 10,
                                  color: GlobalVariables.mainColor,
                                  bottomPadding: 0,
                                  child: Column(
                                    children: [
                                      Text(
                                        userDailyStats['total_consumed_calories']
                                                    .toString() ==
                                                'null'
                                            ? '0'
                                            : userDailyStats[
                                                    'total_consumed_calories']
                                                .toString(),
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontSize: 44,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Calories you\nconsumed today',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Protein',
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: LinearPercentIndicator(
                                          padding: EdgeInsets.zero,
                                          width: 100.0,
                                          barRadius: const Radius.circular(20),
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 12.0,
                                          percent: 0.6,
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor:
                                              GlobalVariables.secondColor,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          userDailyStats['total_consumed_protein']
                                                      .toString() ==
                                                  'null'
                                              ? '0 g'
                                              : "${userDailyStats['total_consumed_protein'].toString()} g",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Fat',
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: LinearPercentIndicator(
                                          padding: EdgeInsets.zero,
                                          width: 100.0,
                                          barRadius: const Radius.circular(20),
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 12.0,
                                          percent: 0.5,
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor:
                                              GlobalVariables.thirdColor,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          userDailyStats['total_consumed_fat']
                                                      .toString() ==
                                                  'null'
                                              ? '0 g'
                                              : "${userDailyStats['total_consumed_fat'].toString()} g",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Carbs',
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: LinearPercentIndicator(
                                          padding: EdgeInsets.zero,
                                          width: 100.0,
                                          barRadius: const Radius.circular(20),
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 12.0,
                                          percent: 0.8,
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor:
                                              GlobalVariables.forthColor,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          userDailyStats['total_consumed_carbs']
                                                      .toString() ==
                                                  'null'
                                              ? '0 g'
                                              : "${userDailyStats['total_consumed_carbs'].toString()} g",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      userDailyStats['total_burned_calories']
                                                  .toString() ==
                                              'null'
                                          ? '0 Kcal'
                                          : "${userDailyStats['total_burned_calories'].toString()} Kcal",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "🔥 Burned",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${userDailyStats['total_meals'].toString()}",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "🥦 Meals",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Today\'s Meals',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ) : const Center(
        child: CircularProgressIndicator(
          color: GlobalVariables.mainColor,
        ),
      ),
    );
  }
}
