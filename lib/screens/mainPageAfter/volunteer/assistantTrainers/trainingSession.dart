import 'dart:convert';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cross_comp/component/default_button_rect.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/assistantTrainers/profilePage.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/assistantTrainers/scoresPage.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/assistantTrainers/trainingSessionArchive.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

class TrainingSession extends StatefulWidget {
  Map<String, dynamic> mapList;
  Map<String, dynamic> mapListOld;
  TrainingSession({Key? key,required this.mapList,required this.mapListOld}) : super(key: key);

  @override
  _TrainingSessionState createState() => _TrainingSessionState();
}

class _TrainingSessionState extends State<TrainingSession>
    with TickerProviderStateMixin {

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  CountDownController _controller = CountDownController();
  late AnimationController controller;
  String tmString = "0:00";
  List<MdlExe> listExe=[];
  bool isLoading=false;
  String userId = '';
  bool isComplete=false;


  Future<Map<String, dynamic>> saveTrainingSession() async {
    print("saveTrainingSession");

    final response = await http.post(
      Uri.parse(mainApiUrl),
      //  headers: header,
      body: {
        'set_training_session': "true",
        'userId': widget.mapList["uid"],
        'ef_id': widget.mapList["ef_id"],
        'ef_type': widget.mapList["type"],
        'date': widget.mapList["date"],
        'total_time': "60:00",
        'j_id': userId,
        'j_type': widget.mapListOld["role"],
        'status': "0"
      },
    );

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
          try{

            String id= map["id"].toString();
            print("Training Session id : $id");
            saveTrainingExercises(id);

          }catch(e){
            print(e.toString());

          }
          setState(() {
            isLoading = false;
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
  Future<Map<String, dynamic>> saveTrainingExercises(String id) async {
    print("saveTrainingExercises");
    List<Map<String,String>> list=[];
    for(int i =0; i<listExe.length; i++){
      Map<String,String> record={
        "exeName":listExe[i].exeName,
        "exeMin":listExe[i].exeMin,
        "exeReps":listExe[i].exeReps,
      };

      list.add(record);
    }
    print(jsonEncode(list));
    final response = await http.post(
      Uri.parse(mainApiUrl),
      //  headers: header,
      body: {
        'set_training_exercise': "true",
        'ts_id': id,
        'values': jsonEncode(list),

      },
    );

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
            Navigator.of(context).pop();
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
  _displayDialog(BuildContext context) async {
    String text="";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Exercise Name'),
            content: TextFormField(
              onChanged: (txt) {
                text = txt;

              },
              obscureText:  false,
              keyboardType: TextInputType.name,
              initialValue: text,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: 'Exercise',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: kTextGreenColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
            actions: <Widget>[
              ElevatedButton(
                // style: ButtonStyle(
                //   shape: SelectedBorder(),
                //   backgroundColor: MaterialStateProperty.all(kTextGreenColor),
                // ),
                onPressed: () {
                  setState(() {
                    isLoading=false;
                    listExe.add(new MdlExe(exeName: text, exeMin: "", exeReps: ""));
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                // style: ButtonStyle(
                //   shape: SelectedBorder(),
                //   backgroundColor: MaterialStateProperty.all(kTextGreenColor),
                // ),
                onPressed: () {
                  setState(() {
                    isLoading=false;
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }


  _editDialog(BuildContext context,String type,int index) async {
    String text="";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('$type'),
            content: TextFormField(
              onChanged: (txt) {
                text = txt;

              },
              obscureText:  false,
              keyboardType: type=='Reps'?TextInputType.number:TextInputType.datetime,
              initialValue: text,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: type,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: kTextGreenColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
            actions: <Widget>[
              ElevatedButton(
                // style: ButtonStyle(
                //   shape: SelectedBorder(),
                //   backgroundColor: MaterialStateProperty.all(kTextGreenColor),
                // ),
                onPressed: () {
                  setState(() {
                    if(type=='Reps')
                    listExe[index].setRep(text);
                    else
                      listExe[index].setMin(text);

                    isLoading=false;
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                // style: ButtonStyle(
                //   shape: SelectedBorder(),
                //   backgroundColor: MaterialStateProperty.all(kTextGreenColor),
                // ),
                onPressed: () {
                  setState(() {
                    isLoading=false;
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }


  String get timerString {
    Duration duration = controller.duration! * controller.value;
    tmString =
        '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    return tmString;
  }

  void initState() {
    super.initState();
    listExe.add(new MdlExe(exeName: "Walk/Run", exeMin: "", exeReps: ""));
    listExe.add(new MdlExe(exeName: "Squarts", exeMin: "", exeReps: ""));
    listExe.add(new MdlExe(exeName: "Leg-Raise", exeMin: "", exeReps: ""));
    listExe.add(new MdlExe(exeName: "Push-Ups", exeMin: "", exeReps: ""));
    controller = AnimationController(
        vsync: this, duration: Duration(minutes: 60), upperBound: math.pi * 2);

    print("mapList");
    print(widget.mapList);
    print("mapListOld");
    print(widget.mapListOld);
    getUserId();
  }

  getUserId() async {
    await HelperFunction.getUserIdSharedPreference().then((value) {
      if (value != null) {
        setState(() {
          userId = value;


        });
      }
    });
  }

  Widget animatedTile(BuildContext context, int index, animation) {
    MdlExe mdlExe = listExe[index];

    TextStyle textStyle = TextStyle(
      fontSize: getProportionateScreenWidth(15),
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );
    return curveMethod(animation, mdlExe, textStyle, index);
  }

  SlideTransition curveMethod(
      animation, MdlExe mdlExe, TextStyle textStyle, int pos) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
      child: GestureDetector(
        onTap: () {},
        child: Container(
            width: double.infinity,
            child: Table(
              border: TableBorder.all(color: Colors.black),
              children: [


                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      mdlExe.getName(),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _editDialog(context, "Reps", pos);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        mdlExe.getRep(),
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _editDialog(context, "Min", pos);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        mdlExe.getMin(),
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ])
              ],
            ),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int counterX = 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          "Training Session",
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
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  widget.mapList["names"],
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "0.0",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: getProportionateScreenHeight(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 150,
                    width: 150,
                    child: GestureDetector(
                        onTap: () {
                          // if (controller.isAnimating) {
                          //   // setState(() {});
                          //   controller.stop();
                          // } else {
                          //   controller.reverse(
                          //       from: controller.value == 0.0
                          //           ? 1.0
                          //           : controller.value);
                          // }

                          if (counterX == 0) {
                            _controller.start();
                            counterX = 1;
                          } else if (counterX == 1) {
                            _controller.pause();
                            counterX = 2;
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
                          duration: 3600,

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
                            setState(() {
                              isComplete=true;
                            });
                          },
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: SelectedBorder(),
                            backgroundColor:
                                MaterialStateProperty.all(kGreenColor),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ProfilePage(userId: widget.mapList["uid"])));

                          },
                          child: Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: SelectedBorder(),
                            backgroundColor:
                                MaterialStateProperty.all(kGreenColor),
                          ),
                          onPressed: () {

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ScoresPage(mapList: widget.mapList)));

                          },
                          child: Text(
                            "Scores",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: SelectedBorder(),
                            backgroundColor:
                                MaterialStateProperty.all(kGreenColor),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Ex Rx",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Table(
                  border: TableBorder.all(color: Colors.black),
                  children: [
                    TableRow(children: [
                      Container(
                          color: Colors.grey[400],
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Exercise",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Container(
                          color: Colors.grey[400],
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Reps",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Container(
                          color: Colors.grey[400],
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Min",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ]),
                  ],
                ),
                Container(
                  height: getProportionateScreenHeight(160),
                  child: AnimatedList(
                    key: listKey,
                    initialItemCount: listExe.length,
                    itemBuilder: (context, index, animation) {
                      return animatedTile(
                          context, index, animation); // Refer step 3
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: DefaultButtonRect(
                  text: "Add an Exercise",
                  press: () {
                    setState(() {
                      isLoading=true;
                    });
                    _displayDialog(context);
                  },
                  clr: kTextGreenColor,
                  isInfinity: true)),
          Expanded(
            flex: 3,
            child: Container(
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: SelectedBorder(),
                    backgroundColor:isComplete?MaterialStateProperty.all(kGreenColor): MaterialStateProperty.all(kRedColor),
                  ),
                  onPressed: () {


                    isComplete?
                      saveTrainingSession(): Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TrainingSessionArchive(mapList: widget.mapList)));



                  },
                  child: Text(
                    "Archive",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: DefaultButtonRect(
                  text: "Return to List of Trainees",
                  press: () {
                    Navigator.of(context).pop();
                  },
                  clr: kPrimaryColor,
                  isInfinity: true)),
        ],
      ),
    );
  }
}

class MdlExe{
  String exeName;
  String exeReps;
  String exeMin;
  MdlExe({required this.exeName,required this.exeMin,required this.exeReps});

  setName(String name){
    this.exeName=name;
  }
  setRep(String rep){
    this.exeReps=rep;
  }
  setMin(String min){
    this.exeMin=min;
  }
  getName(){
   return this.exeName;
  }
  getRep(){
    return this.exeReps;
  }
  getMin(){
    return this.exeMin;
  }
}
class SelectedBorder extends RoundedRectangleBorder
    implements MaterialStateOutlinedBorder {
  @override
  OutlinedBorder resolve(Set<MaterialState> states) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    );
  }
}
