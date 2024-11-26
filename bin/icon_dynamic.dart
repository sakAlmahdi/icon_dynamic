import 'package:icon_dynamic/icon_dynamic.dart' as icon_dynamic;
import 'package:icon_dynamic/models/icons_dynamic/color.dart';
import 'package:icon_dynamic/services/icons_color_dynamic_ser.dart';
import 'package:args/args.dart';

Future<void> main(List<String> arguments) async {
  String? dirPath;
  String? pColor;
  String? lColor;
  String? fColor;
  bool? isDark;
  final parser = ArgParser()
    ..addOption(
      'dir',
      abbr: 'd',
      help: 'Dirctory Path That have file icons.json',
      mandatory: true,
      callback: (d) {
        dirPath = d;
      },
    )
    ..addOption(
      'pc',
      abbr: 'p',
      help: 'primary color set',
      mandatory: true,
      callback: (v) {
        pColor = v;
      },
    )
    ..addOption('labelColor', abbr: 'l', help: 'Label Color set',
        callback: (v) {
      lColor = v;
    })
    ..addOption('fillColor', abbr: 'f', help: 'Fill Color Set ', callback: (v) {
      fColor = v;
    })
    ..addFlag('isdark', abbr: 'D', help: 'is Dark icons gen')
    ..addFlag('help', abbr: 'h', help: 'Help you');

  final results = parser.parse(arguments);
  print("args ${results.arguments}");
  print("comand ${results.command}");
  print("options ${results.options}");
  print("toString ${results.toString()}");

  if (results.flag('isdark')) {
    isDark = true;
  }

  print("dir:$dirPath");
  print("pc:$pColor");
  print("lc:$lColor");
  print("fc:$fColor");
  print("isDark:$isDark");

  IconsColorDynamicSer iconsSer = IconsColorDynamicSer(
    dirPath: dirPath!,
    doOneByMode: true,
    colorOne: pColor == null ? null : Color(hex: pColor!),
    colorTow: lColor == null ? null : Color(hex: lColor!),
    fColor: fColor == null ? null : Color(hex: fColor!),
    isDark: isDark ?? false,
  );
  await iconsSer.start();
  return;
}
