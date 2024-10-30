List<Language> languageList = [
  Language(),
  Khmer()
];

class Language {
  String get home => "Home";
  String get contact => "Contact";
  String get theme => "Theme";
  String get darkMode => "To Dark Mode";
  String get lightMode => "To Light Mode";
  String get systemMode => "To System Mode";
  String get language => "Language";
  String get toKhmer => "ប្តូរទៅភាសាខ្មែរ";
  String get toEnglish => "Change To English";
  String get appName => "Main Screen";
  String get categories => 'Categories';
  String get address => 'Address';
  String get phone => 'Phone';
  String get email => 'Email';
  String get mission => 'Mission';
  String get missionStatementEnglish => 'English';
  String get missionStatementKhmer => 'ភាសាខ្មែរ';
  String get home1 => "Search"; 
  String get search => "What you want to know"; 
  String get recent => "Recent Search"; 
  String get recommendation => "Recommend for you"; 
}


class Khmer implements Language {
  @override
  String get appName => "កម្មវិធីខ្មែរ";
  @override
  String get home => "ទំព័រដើម";
  @override
  String get contact => "ទំនាក់ទំនង";
  @override
  String get theme => "ពន្លឺ";
  @override
  String get darkMode => "ប្តរទៅងងឹត";
  @override
  String get lightMode => "ប្តរទៅភ្លឺ";
  @override
  String get systemMode => "ប្តរតាមប្រព័ន្ធ";
  @override
  String get language => "ភាសា";
  @override
  String get toKhmer => "ប្តូរទៅភាសាខ្មែរ";
  @override
  String get toEnglish => "Change To English";
  @override
  String get categories => "Categories";
  @override
  String get  address=> "អាស័យដ្ឋាន";
  @override
  String get  phone=> "ទូរស័ព្ទ";
  @override
  String get  email=> "អុីម៉ែល";
  @override
  String get  mission=> "បេសកម្ម";
  @override
  String get  missionStatementEnglish=> "English";
  @override
  String get  missionStatementKhmer=> "ភាសាខ្មែរ";
  @override
  String get home1 => "ស្វែងរក"; 
  @override
  String get search => "តើអ្នកចង់ស្វែងរកអ្វី"; 
  @override
  String get recent => "ការស្វែងរកចុុងក្រោយ"; 
  @override
  String get recommendation => "ណែនាំសម្រាប់អ្នក"; 
}
