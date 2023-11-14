// ignore: file_names

import 'dart:io';

import 'package:html/parser.dart';
import 'package:puppeteer/puppeteer.dart';

class RegexHelper {
  final RegExp exp;
  final List<RegExp>? alternativeReGex;
  final String? name;
  RegexHelper({required this.exp, this.alternativeReGex, this.name});
}

List<String> regexMainHelper(String name, String regexExpression) {
  RegExp exp = RegExp(regexExpression, caseSensitive: false);
  Iterable<Match> matches = exp.allMatches(name);
  List<String> returnedList = [];
  for (Match match in matches) {
    returnedList.add(match.group(1).toString());
  }
  return returnedList;
}

List<String> htmlLiParser(String desc) {
  final temp = parse(desc);
  final liColls = temp.querySelectorAll('a');
  List<String> liCollsString = [];
  for (var e in liColls) {
    liCollsString.add(e.outerHtml);
  }
  return liCollsString;
}
//

void puppeteerHelperFunction(String search, bool displayAll) async {
  var browser = await puppeteer.launch();
  var page = await browser.newPage();
  var myFile00 = File('log00.txt');
  //
  await page.goto(
      'https://www.youtube.com/results?search_query=${search.replaceAll(' ', '+')}',
      wait: Until.networkIdle);
  List<dynamic> aTags = await page.$$eval('a', 'e => e.map(i => i.href)');
  var aTagsNotFull = aTags
      .where((elem) => elem.toString().contains(RegExp(r'watch?')) == true);
  displayAll
      ? myFile00.writeAsString(aTags.join('\n'))
      : myFile00.writeAsString(aTagsNotFull.toList().join('\n'));

  await browser.close();
}
