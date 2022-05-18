import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/screens/mainpageBefore/learnMore.dart';
import 'package:cross_comp/screens/mainpageBefore/schedulePage.dart';
import 'package:cross_comp/screens/mainpageBefore/schedulingPlanA.dart';
import 'package:cross_comp/screens/mainpageBefore/webPage.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
          "How fit are you?",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: Container(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WebPage("http://www.crosscomps.com")));
                  },
                  child: Text(
                    "CrossComps",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      color: kTextBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  "are universally standardized medical-fitness tests provided through the",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WebPage("https://www.optihealthnetwork.com/")));
                  },
                  child: Text(
                    "OptiHealth Network",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      color: kTextBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),

                Text(
                  "as a World-Wide, Life-Long Fitness Competition",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  "You can do CrossComps anytime, anywhere.*",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  "We'll help you get as fit as you want to be.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  "Set a goal, track your progress, challenge your friends and family, or join a team.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                DefaultButtonBold(
                    text: "Get started today for free!",

                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SchedulingPlanAPage()));
                    },
                    clr: kGreenColor,
                    isInfinity: true),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  "*Anytime, anywhere that service are offered as our network is still growing.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                InkWell(
                  onTap: _launchURL,
                  child: Text(
                    "The cure for preventing or reversing many of the chronic lifestyle-related diseases that plague our modern culture. Learn more",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://www.optihealthnetwork.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // height: 250,
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultButton(
                text: "SCHEDULE YOUR CROSSCOMP",
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SchedulePage()));
                },
                clr: kGreenColor,
                isInfinity: true),
            SizedBox(height: getProportionateScreenHeight(15)),
            DefaultButton(
                text: "LEARN MORE",
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LearnMore()));
                },
                clr: kPrimaryColor,
                isInfinity: true),
          ],
        ),
      ),
    );
  }
}
