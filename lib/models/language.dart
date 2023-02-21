class Language {
  int id;
  String flag;
  String name;
  String code;
  Language(this.id, this.flag, this.name, this.code);

  static List<Language> languageList() {
    return <Language>[
      Language(1, '🇺🇸', 'English', 'en'),
      Language(2, '🇪🇬', 'العربية', 'ar'),
    ];
  }
}
