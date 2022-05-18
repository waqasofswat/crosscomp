import 'dart:convert';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/screens/mainPageAfter/TestScreens/timerPainter.dart';
import 'package:cross_comp/screens/mainPageAfter/professionals/professionalJudge/professionalJudgeParticipants.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/volunteerJudge/volunteerJudgeParticipants.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:http/http.dart' as http;

class ShuttleTestScreen extends StatefulWidget {
  final bool isProf;
  Map<String, dynamic> mapList;
  Map<String, dynamic> mapListOld;
  ShuttleTestScreen({required this.isProf,required this.mapList,required this.mapListOld});

  @override
  _ShuttleTestScreenState createState() => _ShuttleTestScreenState();
}

class _ShuttleTestScreenState extends State<ShuttleTestScreen>
    with TickerProviderStateMixin {

  late AnimationController controller;
  CountDownController _controller = CountDownController();
  int counterX = 0;
  String tmString = "0:00";
  bool isEditable = false;
  bool isGradeSelected = false;
  bool isComplete = false;
  String get timerString {
    Duration duration = controller.duration! * controller.value;
    // setState(() {
    tmString =
        '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    //});
    return tmString;
  }


  int meters = 0;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 4),
    );
  }
  static final Map<String, String> gradeMap = {
    'a': 'A',
    'b': 'B',
    'c': 'C',
    'd': 'D',
  };
  static final Map<String, double> gradeValMap = {
    'a': 1.00,
    'b':  0.90,
    'c': 0.75,
    'd': 0.50,
  };

  String _selectedGender = gradeMap.keys.first;
bool isLoading = false;
  Future<Map<String, dynamic>> saveExerciseScore() async {
    print("saveExerciseScore");


    String gradeVal=gradeMap[_selectedGender].toString();
    double gVal=double.parse(gradeValMap[_selectedGender].toString());
    double finalVal= ((meters/800)*100)*gVal;
    print("gVal : $gVal");
    print("finalVal : $finalVal");
    String url = mainApiUrl +
        "?set_scores=true&ef_id=${widget.mapList["ef_id"]}&User_ID=${widget.mapList["uid"]}&date=${widget.mapList["date"]}&type=${widget.mapList["type"]}&meters=$finalVal&metersGrade=$gradeVal";

    print(url);
    final response = await http.get(Uri.parse(url));
    print(response.statusCode.toString());
    print(response.body.toString());
    if (response.statusCode == 200) {
      if (response.body.toString().contains("Failure")) {
        print("response Failed");
        setState(() {
          // _loading = false;
          isLoading = false;

          // progress?.dismiss();
        });
      } else {
        // import 'dart:convert';

        Map<String, dynamic> map = jsonDecode(response.body);
        if (map['status'] == "failed") {
          setState(() {
            isLoading = false;

          });
        } else {

          setState(() {
            isLoading = false;
            if(widget.isProf){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfessionalJudgeParticipants(mapList: widget.mapListOld)));
            }else{
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      VolunteerJudgeParticipants(mapList: widget.mapListOld)));
            }
          });
        }

        print("response Success");
      }
      return json.decode(response.body.toString());
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to fetch data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          "Shuttle",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: isLoading?Center(child: Loading(),):
      Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(25)),
          Expanded(
            flex: 1,
            child: Text(
             widget.mapList["names"],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: getProportionateScreenHeight(18),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(25)),
          Expanded(
            flex: 9,
            child: Stack(
              children: [
                Visibility(
                  visible: false,
                  child: GestureDetector(
                    onTap: () {
                      if (controller.isAnimating) {
                        setState(() {
                          meters += 10;
                        });
                        // controller.stop();
                      } else {
                        controller.reverse(
                            from: controller.value == 0.0
                                ? 1.0
                                : controller.value);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 150),
                      child: Container(
                          child: Align(
                        alignment: FractionalOffset.center,
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: AnimatedBuilder(
                                  animation: controller,
                                  builder: (context, child) {
                                    return CustomPaint(
                                      painter: TimerPainter(
                                          animation: controller,
                                          backgroundColor: Color(0xFF2dcc70),
                                          color: Colors.blueGrey),
                                    );
                                  },
                                ),
                              ),
                              Align(
                                alignment: FractionalOffset.center,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Count Down",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              getProportionateScreenHeight(15),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    AnimatedBuilder(
                                        animation: controller,
                                        builder: (context, child) {
                                          return Text(
                                            timerString,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        25),
                                                fontWeight: FontWeight.normal),
                                          );
                                        })
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {

                      if (counterX == 0) {
                        _controller.start();
                        counterX = 1;
                      } else if (counterX == 1) {
                        setState(() {
                          meters += 10;
                        });
                        // _controller.pause();
                        // counterX = 2;
                      } else if (counterX == 2) {
                        _controller.resume();
                        counterX = 1;
                      } else {
                        _controller.restart();
                        counterX = 0;
                      }
                    },
                    child: CircularCountDownTimer(
                      // Countdown duration in Seconds.
                      duration: 240,

                      // Countdown initial elapsed Duration in Seconds.
                      initialDuration: 0,

                      // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
                      controller: _controller,

                      // Width of the Countdown Widget.
                      width: MediaQuery.of(context).size.width / 2.5,

                      // Height of the Countdown Widget.
                      height: MediaQuery.of(context).size.height / 2.5,

                      // Ring Color for Countdown Widget.
                      ringColor: Colors.grey[300]!,

                      // Ring Gradient for Countdown Widget.
                      ringGradient: null,

                      // Filling Color for Countdown Widget.
                      fillColor: Colors.blueGrey,

                      // Filling Gradient for Countdown Widget.
                      fillGradient: null,

                      // Background Color for Countdown Widget.
                      backgroundColor: Colors.blue,

                      // Background Gradient for Countdown Widget.
                      backgroundGradient: null,

                      // Border Thickness of the Countdown Ring.
                      strokeWidth: 10.0,

                      // Begin and end contours with a flat edge and no extension.
                      strokeCap: StrokeCap.round,

                      // Text Style for Countdown Text.
                      textStyle: TextStyle(
                          fontSize: 33.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),

                      // Format for the Countdown Text.
                      textFormat: CountdownTextFormat.MM_SS,

                      // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
                      isReverse: false,

                      // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
                      isReverseAnimation: false,

                      // Handles visibility of the Countdown Text.
                      isTimerTextShown: true,

                      // Handles the timer start.
                      autoStart: false,

                      // This Callback will execute when the Countdown Starts.
                      onStart: () {
                        // Here, do whatever you want
                        print('Countdown Started');
                      },

                      // This Callback will execute when the Countdown Ends.
                      onComplete: () {
                        // Here, do whatever you want
                        counterX = 0;
                        print('Countdown Ended');
                      },
                    )),
              ],
            ),
          ),
          Expanded(flex: 3, child: Container()),
          Expanded(
            flex: 3,
            child: isEditable
                ? ElegantNumberButton(
                    buttonSizeHeight: getProportionateScreenHeight(40),
                    buttonSizeWidth: getProportionateScreenHeight(40),
                    textStyle: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900,
                    ),
                    color: kPrimaryColor,
                    initialValue: meters,
                    minValue: 0,
                    maxValue: 10000,
                    step: 1,
                    decimalPlaces: 0,
                    onChanged: (value) {
                      // get the latest value from here
                      setState(() {
                        meters = value.toInt();
                      });
                    },
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!controller.isAnimating) {
                          isEditable = true;
                        }
                      });
                    },
                    child: Text(
                      meters.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: getProportionateScreenHeight(55),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Meters",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: getProportionateScreenHeight(25),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(flex: 1, child: Container()),
          Expanded(flex: 2, child: isComplete?   CupertinoRadioChoice(
              choices: gradeMap,
              onChange: (String gradeKey) {
                setState(() {
                  _selectedGender = gradeKey;
                });
              },
              initialKeyValue: _selectedGender):Container()),
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 2,
            child: DefaultButton(
                text: "Submit",
                press: () {
                  print("Submitttttttttttt");
                  if(!isComplete){
                    setState(() {
                      isComplete=true;
                    });
                  }else{


                    showDialog(
                        context: context,
                        builder: (_) => ConformDialog(
                            pressYes: () {
                              setState(() {

                                isLoading=true;
                                Navigator.of(context).pop();
                                saveExerciseScore();
                              });
                            },
                            pressNo: () {
                              Navigator.of(context).pop();
                            },
                            title: "Save",
                            message: "Save Records to database"));
                  }

                },
                clr: kRedColor,
                isInfinity: false),
          ),
          SizedBox(height: getProportionateScreenHeight(25)),
        ],
      ),
    );
  }

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties
  //       .add(DiagnosticsProperty<Future<String>>('timerString', timerString));
  // }
}
