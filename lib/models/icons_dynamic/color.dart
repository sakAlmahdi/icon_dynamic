class Color {
  late String hex;
  List<int> get rgb => hexToRgb(hex);
  Color({required this.hex});

  String opacity({required double opacity}) {
    // Ensure the hex color is in the format #RRGGBB (6 characters after #)
    if (hex.startsWith('#')) {
      hex = hex.substring(1);
    }

    // Convert hex color to RGB components
    int r = int.parse(hex.substring(0, 2), radix: 16);
    int g = int.parse(hex.substring(2, 4), radix: 16);
    int b = int.parse(hex.substring(4, 6), radix: 16);

    // Calculate alpha value based on opacity (opacity is a value between 0 and 1)
    int a = (opacity * 255).round();

    // Return the RGBA hex string, with the alpha value
    return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}${a.toRadixString(16).padLeft(2, '0')}';
  }

  List<int> hexToRgb(String hex) {
    hex = hex.replaceAll('#', '');
    int r = int.parse(hex.substring(0, 2), radix: 16);
    int g = int.parse(hex.substring(2, 4), radix: 16);
    int b = int.parse(hex.substring(4, 6), radix: 16);
    return [r, g, b];
  }
}

extension ColorEx on List<int> {
  String toHex() {
    return '#${map((channel) {
      return channel.toRadixString(16).padLeft(2, '0');
    }).join('')}';
  }
}
