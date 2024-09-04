import 'dart:math';

List<String> complimentsfor5 = [
  "Perfect harmony! You're hitting all the right notes!",
  "Absolutely harmonious! You're mastering the melody of music theory.",
];
List<String> complimentsfor4 = [
  "Bravo! Your knowledge is striking a chord with excellence.",
  "Impressive! You're conducting a symphony of knowledge.",
];
List<String> complimentsfor3 = [
  "Well done! You're orchestrating a solid understanding of music theory.",
  "Nicely done! Your understanding of music theory is hitting all the right notes.",
];
List<String> complimentsfor2 = [
  "Keep practicing! You're tuning in to the nuances of music theory.",
  "Good effort! You're starting to compose your musical knowledge.",
];
List<String> complimentsfor1 = [
  "Every great composer had to start somewhere! You're building your musical foundation.",
  "Every note counts! Keep exploring, and you'll soon find your rhythm.",
];
List<String> complimentsfor0 = [
  "Even Mozart had off days! Keep exploring, and you'll soon find your rhythm.",
  "Don't fret! Everyone's journey begins with the first step. Keep on practicing!",
];

Random random = Random();
int randomIndex = random.nextInt(complimentsfor5.length);

String selectedWordfor5 = complimentsfor5[randomIndex];
String selectedWordfor4 = complimentsfor4[randomIndex];
String selectedWordfor3 = complimentsfor3[randomIndex];
String selectedWordfor2 = complimentsfor2[randomIndex];
String selectedWordfor1 = complimentsfor1[randomIndex];
String selectedWordfor0 = complimentsfor0[randomIndex];

// Map condition to text
Map<int, String> compliments = {
  5: selectedWordfor5,
  4: selectedWordfor4,
  3: selectedWordfor3,
  2: selectedWordfor2,
  1: selectedWordfor1,
  0: selectedWordfor0,
};
