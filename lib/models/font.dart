class Font {
  int id;
  String family;
  String fontSample;
  Font(this.id, this.family, this.fontSample);

  static List<Font> fontList() {
    return <Font>[
      Font(1, 'Tajwal', 'sample1'),
      Font(1, 'Rakkas', 'sample2'),
    ];
  }
}
