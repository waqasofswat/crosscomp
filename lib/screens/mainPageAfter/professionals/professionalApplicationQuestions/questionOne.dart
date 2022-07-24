import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/screens/mainPageAfter/professionals/professionalApplicationQuestions/questionTwo.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class QuesOne extends StatefulWidget {
  QuesOne({Key? key}) : super(key: key);

  @override
  _QuesOneState createState() => _QuesOneState();
}

class _QuesOneState extends State<QuesOne> {


  bool isValidText = false;
  final TextEditingController _q1controller = TextEditingController();

  Future<void> _read() async {
    String v=await HelperFunction.getPQ1SharedPreference()??"";
    setState(()  {
     _q1controller.text=v;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _read();
    });
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
          "Application",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  "1 of 4",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Briefly explain how your participation in CrossComps has benefited you.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),

                SizedBox(height: getProportionateScreenHeight(10)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  height: 200,
                  child: TextFormField(
                    controller: _q1controller,
                    onChanged: (txt) {
                      if (txt.length >= 1000)
                        setState(() {
                          isValidText = true;
                        });
                      else
                        setState(() {
                          isValidText = false;
                        });
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                   // initialValue: '',
                    decoration: InputDecoration(
                      labelText: 'Response',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),

                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  "(1,000 charater limit)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: DefaultButton(
                      text: "Save & Continue",
                      press: () {
                        HelperFunction.savePQ1SharedPreference(_q1controller.value.text);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => QuesTwo()));
                      },
                      clr: kTextGreenColor,
                      isInfinity: true),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: DefaultButton(
                      text: "Save & Exit",
                      press: () {
                        HelperFunction.savePQ1SharedPreference(_q1controller.value.text);
                        Navigator.pop(context);
                      },
                      clr: kRedColor,
                      isInfinity: true),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
