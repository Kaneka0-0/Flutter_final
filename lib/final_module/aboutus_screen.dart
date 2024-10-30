import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_module/final_module/language_constant.dart';
import 'package:final_module/final_module/language_logic.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the current theme is dark
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    // Get the current language index
    final langIndex = context.watch<LanguageLogic>().languageIndex;
    final lang = context.watch<LanguageLogic>().lang;

    return Scaffold(
      appBar: AppBar(title: Text(lang.appName)), // Use dynamic app name
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Description
            Text(
              langIndex == 0 
                ? _englishCompanyDescription() 
                : _khmerCompanyDescription(),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Contact Information
            Text(
              lang.contact, // Dynamically get the label based on language
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            _buildContactDetail(lang.address, '123 News Avenue, Phnom Penh, GA 30303', isDarkTheme),
            _buildContactDetail(lang.phone, '(+855) 177-333-37', isDarkTheme),
            _buildContactDetail(lang.email, 'info@news.com', isDarkTheme),
            const SizedBox(height: 20),

            // Mission Statement Header
            Text(
              lang.mission, // Use dynamic mission label
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              langIndex == 0 
                ? lang.missionStatementEnglish 
                : lang.missionStatementKhmer,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            // Mission Statement Body
            _buildMissionStatement(langIndex == 0 ? _englishMissionPoints() : _khmerMissionPoints(), isDarkTheme),
          ],
        ),
      ),
    );
  }

  String _englishCompanyDescription() {
    return  'News Worldwide is the most honored brand in cable news, reaching more individuals on television and online than any other cable news organization in the United States. '
              'Globally, people across the world can watch News International, which is widely distributed in over 200 countries and territories. News Digital is the #1 online news destination, with more unique visitors than any other news source. '
              'News’s award-winning portfolio includes non-scripted programming from CNN Original Series and CNN Films for broadcast, streaming, and distribution across multiple platforms. '
              'News programming can be found on News, News International, and News en Español channels, on the NewsOriginals hub on discovery+, on Max, and for pay TV subscription via News.com, News apps, and cable operator platforms. '
              'Additionally, CNN Newsource is the world’s most extensively utilized news service partnering with over 1,000 local and international news organizations around the world. News is a division of Warner Bros. Discovery.'; // Your full English description here
  }

  String _khmerCompanyDescription() {
    return    'News Worldwide គឺជាម៉ាកដ៏មានកិត្តិយសបំផុតនៅក្នុងព័ត៌មានទូរទស្សន៍ខ្សែកាប ដែលឈានដល់បុគ្គលជាច្រើននៅលើទូរទស្សន៍ និងតាមអ៊ីនធឺណិតជាងស្ថាប័នព័ត៌មានខ្សែកាបផ្សេងទៀតនៅក្នុងសហរដ្ឋអាមេរិក។ '
              'ទូទាំងពិភពលោក មនុស្សជុំវិញពិភពលោកអាចមើល News International ដែលត្រូវបានចែកចាយយ៉ាងទូលំទូលាយនៅក្នុងជាង 200 ប្រទេស និងដែនដី។ News Digital គឺជាទិសដៅព័ត៌មានអនឡាញលេខ 1 ដោយមានអ្នកទស្សនាប្លែកជាងប្រភពព័ត៌មានផ្សេងទៀត។ '
              'ផលប័ត្រដែលទទួលបានពានរង្វាន់របស់ News រួមមានកម្មវិធីដែលមិនមែនជាស្គ្រីបពី CNN Original Series និង CNN Films សម្រាប់ការផ្សាយ ការផ្សាយ និងការចែកចាយនៅលើវេទិកាជាច្រើន។ '
              'កម្មវិធីព័ត៌មានអាចរកបាននៅលើប៉ុស្តិ៍ News, News International, និង News en Español, នៅលើ NewsOriginals hub on discovery+, on Max, និងសម្រាប់ការជាវទូរទស្សន៍បង់ប្រាក់តាមរយៈ News.com កម្មវិធីព័ត៌មាន និងវេទិកាប្រតិបត្តិករខ្សែកាប។ '
              'លើសពីនេះ CNN Newsource គឺជាសេវាកម្មព័ត៌មានដែលប្រើប្រាស់យ៉ាងទូលំទូលាយបំផុតរបស់ពិភពលោក ដែលចាប់ដៃគូជាមួយស្ថាប័នព័ត៌មានក្នុងស្រុក និងអន្តរជាតិជាង 1,000 ជុំវិញពិភពលោក។ ព័ត៌មានគឺជាផ្នែកមួយរបស់ Warner Bros. Discovery ។'; 
  }

  Widget _buildContactDetail(String label, String detail, bool isDarkTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              detail,
              style: TextStyle(
                fontSize: 16.0,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionStatement(List<String> missionPoints, bool isDarkTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: missionPoints.map((point) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            '• $point',
            style: TextStyle(
              fontSize: 16.0,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }

  List<String> _englishMissionPoints() {
    return [
      'We are truth-seekers and storytellers.',
      'We are journalists, designers, and technologists, united by a mission to inform, engage and empower the world.',
      'We bear witness to history as it unfolds and explain not just what happened, but why, and what it means to you.',
      'Our products and platforms take you to the farthest corners of the world, and they bring the world to you, delivering content and services that enrich your lives, your families, and your communities.',
      'We are available on more screens in more places than any other news source.',
      'We stand for excellence in our journalism and our products.',
      'We are committed to serving you.',
      'We are News.'
    ];
  }

  List<String> _khmerMissionPoints() {
    return [
      'យើងជាអ្នកស្វែងរកការពិត និងជាអ្នកនិទានរឿង។'
      'យើងជាអ្នកសារព័ត៌មាន អ្នករចនា និងអ្នកបច្ចេកវិទ្យា ដែលរួបរួមគ្នាដោយបេសកកម្មដើម្បីជូនដំណឹង ចូលរួម និងផ្តល់អំណាចដល់ពិភពលោក។',
      'យើងធ្វើជាសាក្សីចំពោះប្រវត្តិសាស្រ្ត ដូចដែលវាលាតត្រដាង ហើយពន្យល់មិនគ្រាន់តែអំពីអ្វីដែលបានកើតឡើងនោះទេ ប៉ុន្តែហេតុអ្វី និងវាមានន័យយ៉ាងណាចំពោះអ្នក។'
      'ផលិតផល និងវេទិការបស់យើងនាំអ្នកទៅកាន់ជ្រុងឆ្ងាយបំផុតនៃពិភពលោក ហើយពួកវានាំពិភពលោកមករកអ្នក ដោយផ្តល់នូវខ្លឹមសារ និងសេវាកម្មដែលធ្វើអោយជីវិតរបស់អ្នក គ្រួសាររបស់អ្នក និងសហគមន៍របស់អ្នក។',
      'យើង​មាន​នៅ​លើ​អេក្រង់​ច្រើន​កន្លែង​ជាង​ប្រភព​ព័ត៌មាន​ផ្សេង​ទៀត។',
      'យើងឈរសម្រាប់ឧត្តមភាពក្នុងវិស័យសារព័ត៌មាន និងផលិតផលរបស់យើង។'
      'យើងប្តេជ្ញាបម្រើអ្នក។'
      'យើងជាព័ត៌មាន។'
    ];
  }
}
