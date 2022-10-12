class ImagePaths {
  const ImagePaths();

  static ElixirPaths elixirs = ElixirPaths();
}

class ElixirPaths {
  String get elixirGreen => 'assets/images/elixir_green.png';
  String get elixirBlue => 'assets/images/elixir_blue.png';
  String get elixirPink => 'assets/images/elixir_pink.png';
  String get elixirRed => 'assets/images/elixir_red.png';
  String get elixirYellow => 'assets/images/elixir_yellow.png';

  List<String> elixirList = [
    'assets/images/elixir_green.png',
    'assets/images/elixir_blue.png',
    'assets/images/elixir_pink.png',
    'assets/images/elixir_red.png',
    'assets/images/elixir_yellow.png',
  ];
}
