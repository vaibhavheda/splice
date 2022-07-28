import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:splice/common/snackbar_custom.dart';
import 'package:splice/models/short_url_output_model.dart';
import 'package:splice/widgets/error/error_screen_api.dart';
import 'package:splice/widgets/url_shortner_output/url_shortner_output.dart';

import 'package:http/http.dart' as http;
import '../../auth/secrets.dart' as config;
import '../../constants/constants_strings.dart' as constants;

/*
  This Widget is for the Main screen where we will add the screen to add url
  then a button to shorten the URL.
 */
class URLShortnerScreen extends StatefulWidget {
  /*
    Route Name: URL Shortner Output
  */
  static const routeName = "/urlShortHome";
  const URLShortnerScreen({Key? key}) : super(key: key);

  @override
  State<URLShortnerScreen> createState() => _URLShortnerScreenState();
}

class _URLShortnerScreenState extends State<URLShortnerScreen> {
  bool isLoading = false;
  /*
  Controller for the input field
  */
  final TextEditingController _urlInputController = TextEditingController();

  /*
    Set initial state
  */
  @override
  void initState() {
    // initial value of the short URL;
    _urlInputController.addListener(() {
      // Remove the prefix of https://
      final String newText = _urlInputController.text.replaceFirst(
          RegExp(constants.UrlShortnerConstants.urlInputLablePrefix), "");
      // save the new value
      _urlInputController.value = _urlInputController.value.copyWith(
        text: newText,
      );
    });
    super.initState();
  }

  /* Dispose the controller. */
  @override
  void dispose() {
    _urlInputController.dispose();
    super.dispose();
  }

  Future _shortenURL() async {
    try {
      String longUrl = _urlInputController.text;
      // Call the cuttly API
      var url =
          "https://cutt.ly/api/api.php?key=${config.APIKeys.cuttlyApiKey}&short=$longUrl";
      // parse the URL
      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body);
      return json;
    } catch (err) {
      // Handle the errors.
      debugPrint("Error: Fetching Short link failure,$err");
      return null;
    }
  }

  void _showSnackBarMessage(String message) {
    showSnackBarCustom(context, message);
  }

  bool validateUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  /*  
    Function to handle click on the button to shorten the URL.
  */
  void _handleClick() {
    // If the input url is valid then show allow the button click.

    if (_urlInputController.text != "") {
      try {
        // validate URL
        bool isValidUrl = validateUrl('https://${_urlInputController.text}');
        // If valid url
        if (isValidUrl == true) {
          // Show loader
          setState(() {
            isLoading = true;
          });
          // shorten the URL
          _shortenURL().then(
            /*
            After await go for output screen.
           */
            (value) => {
              setState(() {
                isLoading = false;
              }),
              _urlInputController.text = "",
              if (value != null && value['url']['shortLink'] != null)
                {
                  Navigator.pushNamed(
                    context,
                    UrlShortnerOutput.routeName,
                    arguments:
                        UrlShortnerOutputModel(value['url']['shortLink']),
                  )
                }
              else
                {
                  Navigator.pushNamed(
                    context,
                    ErrorScreenAPI.routeName,
                  )
                }
            },
          );
        } else {
          // If not valid then show the error
          _showSnackBarMessage("Enter a valid URL");
        }
      } catch (err) {
        debugPrint("Error: Fetching Short link failure,$err");
        Navigator.pushNamed(
          context,
          ErrorScreenAPI.routeName,
        );
      }
    } else {
      _showSnackBarMessage("Url cannot be empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(""),
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextField(
                      enableInteractiveSelection: true,
                      decoration: const InputDecoration(
                        prefixText:
                            constants.UrlShortnerConstants.urlInputLablePrefix,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(20),
                        labelText:
                            constants.UrlShortnerConstants.urlInputLabelText,
                      ),
                      controller: _urlInputController,
                    ),
                  ),
                  TextButton(
                    onPressed: _handleClick,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.blueAccent,
                      ),
                      foregroundColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                      // overlayColor: MaterialStateProperty.all(Colors.red),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                      ),
                    ),
                    child: const Text(
                      constants.UrlShortnerConstants.generateUrlButton,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
