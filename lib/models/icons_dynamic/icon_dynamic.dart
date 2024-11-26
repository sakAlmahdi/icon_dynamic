import 'package:icon_dynamic/models/icons_dynamic/color.dart';

class IconDynamic {
  late String iconPath;
  bool? isDark;
  List<String>? pColors;
  List<String>? lColors;
  List<String>? fColors;
  String? pColor;
  String? lColor;
  String? fColor;
  double? pOpacity;
  double? lOpacity;
  double? fOpacity;

  Color? get getPColor => pColor == null ? null : Color(hex: pColor!);
  Color? get getLColor => lColor == null ? null : Color(hex: lColor!);
  Color? get getFColor => fColor == null ? null : Color(hex: fColor!);

  IconDynamic({
    required this.iconPath,
    this.isDark,
    this.pColors,
    this.lColors,
    this.fColors,
    this.pColor,
    this.lColor,
    this.fColor,
    this.pOpacity,
    this.lOpacity,
    this.fOpacity,
  });

  IconDynamic.fromJson(Map<String, dynamic> json) {
    iconPath = json['iconPath'];
    isDark = json['isDark'];
    pColors = json['pColors'].cast<String>();
    lColors = json['lColors'].cast<String>();
    fColors = json['fColors'].cast<String>();
    pColor = json['pColor'];
    lColor = json['lColor'];
    fColor = json['fColor'];
    pOpacity = double.tryParse(json['pOpacity'].toString());
    lOpacity = double.tryParse(json['lOpacity'].toString());
    fOpacity = double.tryParse(json['fOpacity'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iconPath'] = iconPath;
    data['isDark'] = isDark;
    data['pColors'] = pColors;
    data['lColors'] = lColors;
    data['fColors'] = fColors;
    data['pColor'] = pColor;
    data['lColor'] = lColor;
    data['fColor'] = fColor;
    data['pOpacity'] = pOpacity;
    data['lOpacity'] = lOpacity;
    data['fOpacity'] = fOpacity;
    return data;
  }

  static List<IconDynamic> fromList(List<dynamic> data) =>
      data.map((e) => IconDynamic.fromJson(e)).toList();

  // copyWith method
  IconDynamic copyWith({
    String? iconPath,
    bool? isDark,
    List<String>? pColors,
    List<String>? lColors,
    List<String>? fColors,
    String? pColor,
    String? lColor,
    String? fColor,
    double? pOpacity,
    double? lOpacity,
    double? fOpacity,
  }) {
    return IconDynamic(
      iconPath: iconPath ?? this.iconPath,
      isDark: isDark ?? this.isDark,
      pColors: pColors ?? this.pColors,
      lColors: lColors ?? this.lColors,
      fColors: fColors ?? this.fColors,
      pColor: pColor ?? this.pColor,
      lColor: lColor ?? this.lColor,
      fColor: fColor ?? this.fColor,
      pOpacity: pOpacity ?? this.pOpacity,
      lOpacity: lOpacity ?? this.lOpacity,
      fOpacity: fOpacity ?? this.fOpacity,
    );
  }
}

extension DoubleEx on double? {
  double get realOpacity {
    if (this == null) return 1;
    if (this! >= 1) return 1;
    if (this! <= 0) return 0;
    return this!;
  }
}
