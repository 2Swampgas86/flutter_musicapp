class QuizQuestion{
  const QuizQuestion({required this.question,required this.options,this.image,this.audio, required this.correctAnswer});
  final String question;
  final List<String> options;
  final String? image;
  final String? audio;
  final String correctAnswer;

  factory QuizQuestion.fromFirestore(Map<String, dynamic> data) {
    return QuizQuestion(
      question: data['question'],
      options: List<String>.from(data['options']),
      image: data['image'],
      audio: data['audio'],
      correctAnswer: data['correctAnswer'],
    );
  }
}