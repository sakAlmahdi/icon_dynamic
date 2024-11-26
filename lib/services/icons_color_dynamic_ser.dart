import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:icon_dynamic/models/icons_dynamic/color.dart';
import 'package:icon_dynamic/models/icons_dynamic/icon_dynamic.dart';
import 'package:path/path.dart' as path_lib;

class IconsColorDynamicSer {
  late String dirPath;
  Color? colorOne;
  Color? colorTow;
  Color? fColor;
  double? opacityOne;
  double? opacityTow;
  bool? doOneByMode = false;
  bool isDark = false;

  IconsColorDynamicSer({
    required this.dirPath,
    this.colorOne,
    this.colorTow,
    this.fColor,
    this.doOneByMode = false,
    this.isDark = false,
  });

  start() async {
    List<IconDynamic> icons = await getIconsDynamic();
    IconDynamic? icon;
    if (doOneByMode ?? false) {
      if (isDark) {
        int index = icons.indexWhere((e) => e.isDark == true);
        if (index >= 0) {
          icon = icons[index];
        }
      } else {
        int index =
            icons.indexWhere((e) => e.isDark == false || e.isDark == null);
        if (index >= 0) {
          icon = icons[index];
        }
      }
      if (icon != null) {
        await change(icon: icon);
      }
    } else {
      for (var i = 0; i < icons.length; i++) {
        await change(icon: icons[i]);
      }
    }
  }

  change({required IconDynamic icon}) async {
    Color? c1 = colorOne ?? icon.getPColor;
    Color? c2 = colorTow ?? icon.getLColor;
    Color? c3 = fColor ?? icon.getFColor;
    if (c1 == null) throw 'color one not set';
    String path = "$dirPath/${icon.iconPath}";
    String ext = path.split('.').last;
    if (ext != "svg" && icon.iconPath != "*") throw 'only support svg icons';

    if (icon.iconPath == "*") {
      await changeAll(icon: icon);
      return;
    }

    File iconFile = File(path);
    var data = await iconFile.readAsString();
    await iconFile.exists();

    if (icon.pColors?.isNotEmpty ?? true) {
      data = changeColor(
        data: data,
        colors: icon.pColors ?? [],
        to: c1.opacity(opacity: icon.pOpacity.realOpacity),
      );
    }
    if (icon.lColors?.isNotEmpty ?? true) {
      data = changeColor(
        data: data,
        colors: icon.lColors ?? [],
        to: c2?.opacity(opacity: icon.lOpacity.realOpacity),
      );
    }
    if (icon.fColors?.isNotEmpty ?? true) {
      data = changeColor(
        data: data,
        colors: icon.fColors ?? [],
        to: c3?.opacity(opacity: icon.fOpacity.realOpacity),
      );
    }

    log(data.toString());

    if (icon.isDark ?? false) {
      await saveDark(path: path, data: data, extension: ext);
    } else {
      await iconFile.writeAsString(data);
      await iconFile.exists();
    }
  }

  saveDark({
    required String path,
    required String data,
    required String extension,
  }) async {
    if (!path.contains('_dark.$extension')) {
      path = path.replaceAll('.$extension', '_dark.$extension');
    }
    File iconFile = File(path);
    await iconFile.writeAsString(data);
    await iconFile.exists();
  }

  String changeColor({
    required List<String> colors,
    required String data,
    String? to,
  }) {
    if (to == null) return data;
    for (var i = 0; i < colors.length; i++) {
      data = data.replaceAll(RegExp(colors[i]), to);
    }

    return data;
  }

  changeAll({required IconDynamic icon}) async {
    List<IconDynamic> icons = [];
    Directory appsDir = Directory(dirPath);
    List<FileSystemEntity> entities = appsDir.listSync(
      followLinks: false,
      recursive: false,
    );

    for (var entity in entities) {
      if (entity.statSync().type == FileSystemEntityType.file) {
        String ext = entity.path.split('.').last;

        if (ext == 'svg') {
          var basename = path_lib.basename(entity.path);
          icons.add(icon.copyWith(iconPath: basename));
        }
      }
    }
    for (var i = 0; i < icons.length; i++) {
      await change(icon: icons[i]);
    }
  }

  Future<List<IconDynamic>> getIconsDynamic() async {
    File confFile = File("$dirPath/icons.json");
    if (!confFile.existsSync()) throw "icons.json not found";
    var data = confFile.readAsStringSync();
    return IconDynamic.fromList(jsonDecode(data));
  }
}
