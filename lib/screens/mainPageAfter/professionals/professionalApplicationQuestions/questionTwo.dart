import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/screens/mainPageAfter/professionals/professionalApplicationQuestions/questionThree.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class QuesTwo extends StatefulWidget {
  QuesTwo({Key? key}) : super(key: key);

  @override
  _QuesTwoState createState() => _QuesTwoState();
}

class _QuesTwoState extends State<QuesTwo> {
  final TextEditingController _q2controller = TextEditingController();

  Future<void> _read() async {
    String v=await HelperFunction.getPQ2SharedPreference()??"";
    setState(()  {
      _q2controller.text=v;
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
                  "2 of 4",
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
                    "Briefly explain how volunteering with CrossComps has benefited other Participants.",
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
                    controller: _q2controller,
                    onChanged: (txt) {},
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    //initialValue: '',
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
                        HelperFunction.savePQ2SharedPreference(_q2controller.value.text);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuesThree()));
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
                        HelperFunction.savePQ2SharedPreference(_q2controller.value.text);

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
