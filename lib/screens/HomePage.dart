// ignore: file_names

import 'package:allen/FeatureBox.dart';
import 'package:allen/OpenAIService.dart';
import 'package:allen/pallete.dart';
import 'package:allen/widgets/drawer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  String lastWords = "";
  final OpenAISercice openAISercice = OpenAISercice();
  bool showinputtext = false;
  bool isInputTextFieldVisible = false;

  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        title: BounceInDown(child: const Text("Allen")),
        elevation: BorderSide.strokeAlignOutside,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Assistant image
            ZoomIn(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                          color: Pallete.assistantCircleColor,
                          shape: BoxShape.circle),
                    ),
                  ),
                  Container(
                    height: 125,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/virtualAssistant.png"))),
                  ),
                ],
              ),
            ),

            //chat bubble
            FadeInRight(
              child: Visibility(
                // ignore: unnecessary_null_comparison
                visible: generatedImageUrl == null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 40)
                      .copyWith(top: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Pallete.borderColor),
                    borderRadius: BorderRadius.circular(20).copyWith(
                      topLeft: Radius.zero,
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: showinputtext
                          ? ZoomIn(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        TextFormField(
                                          controller: _textEditingController,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Enter your question',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () async {
                                      final query = _textEditingController
                                          .text; // Use the text from the TextFormField

                                      if (query.isNotEmpty) {
                                        final response = await openAISercice
                                            .isArtPromptAPI(query);

                                        if (response != null) {
                                          if (response.contains("https")) {
                                            generatedImageUrl = response;
                                            generatedContent = null;
                                          } else {
                                            generatedImageUrl = null;

                                            generatedContent = response;
                                            if (generatedContent ==
                                                "You exceeded your current quota, please check your plan and billing details.") {
                                              print("yes");
                                            }
                                          }
                                        }
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Visibility(
                              visible: !isInputTextFieldVisible,
                              child: Text(
                                "Hello! I am Allen What task can I do for you?",
                                style: TextStyle(
                                    fontSize:
                                        generatedContent == null ? 25 : 12,
                                    color: Pallete.mainFontColor,
                                    fontFamily: "Cera Pro"),
                              ),
                            )),
                ),
              ),
            ),

            if (generatedImageUrl != null)
              Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(generatedImageUrl!)),
              ),
            //feature line
            SlideInLeft(
              child: Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                    ),
                    child: const Text("Here are some features!!",
                        style: TextStyle(
                            fontFamily: "Cera Pro",
                            color: Pallete.mainFontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
              ),
            ),

            // feature list
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Column(
                children: [
                  SlideInLeft(
                    delay: Duration(microseconds: start),
                    child: const FeatureBox(
                      color: Pallete.firstSuggestionBoxColor,
                      headertext: 'ChatGpt',
                      description:
                          'It is an Ai model which can answer any question.',
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + delay),
                    child: const FeatureBox(
                        color: Pallete.secondSuggestionBoxColor,
                        headertext: "Dall-E",
                        description:
                            "Get inspired and stay creative with your personal assistant"),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + 2 * delay),
                    child: const FeatureBox(
                        color: Pallete.thirdSuggestionBoxColor,
                        headertext: "Smart Voice Assistant",
                        description:
                            "Get the best of both worlds with voice assistantt"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (isInputTextFieldVisible) {
              // If the input text field is currently visible, hide it and clear the text
              isInputTextFieldVisible = false;
              showinputtext = false;
              _textEditingController.clear();
              // Reset the generated content and image URL
              generatedContent = null;
              generatedImageUrl = null;
            } else {
              // If the input text field is hidden, show it
              isInputTextFieldVisible = true;
              showinputtext = true;
            }
          });
        },
        child: Icon(
            isInputTextFieldVisible ? Icons.remove_circle : Icons.add_circle),
      ),
    );
  }
}
