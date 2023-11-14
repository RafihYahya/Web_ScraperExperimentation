import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:webscraper/helperFunctions.dart';

Future<void> fetchFromYoutubeData(String name) async {
  final response = await http
      .get(Uri.parse('https://www.youtube.com/results?search_query=$name'));
//
  if (response.statusCode == 200) {
    var myFile = File('log.txt');
    var myFile2 = File('log2.txt');
    var myFile3 = File('log3.txt');
    var myFile4 = File('log4.txt');
    myFile.writeAsString(
        regexMainHelper(response.body, r'href="([^"]*)"').join('\n'));
    myFile2.writeAsString(htmlLiParser(response.body).join('\n'));
    myFile3.writeAsString(response.body);
    myFile4.writeAsString(parse(response.body).toString());
  } else {
    throw Exception('Something Wrong Happened');
  }
}
