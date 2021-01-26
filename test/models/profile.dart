import 'package:flutter_test/flutter_test.dart';
import 'package:kotprog/models/profile.dart';

void main() {
  test("Can change nickname", () {
    var profile = Profile();

    expect(profile.nick, '');
    profile.nick = "Tomi_Ohl";
    expect(profile.nick, 'Tomi_Ohl');
  });
}