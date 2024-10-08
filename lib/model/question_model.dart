class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];

  list.add(Question("What was the objective of the Dandi March?", [
    Answer("To protest against the British salt tax", true),
    Answer("To demand complete independence", false),
    Answer("To support the Khilafat Movement", false),
    Answer("To demand the release of political prisoners", false),
  ]));

  list.add(Question(
      "Who gave the slogan 'Do or Die' during the independence movement?", [
    Answer("Subhas Chandra Bose", false),
    Answer("Mahatma Gandhi", true),
    Answer("Bhagat Singh", false),
    Answer("Jawaharlal Nehru", false),
  ]));

  list.add(
      Question("Which Indian leader is known as the 'Iron Man of India'?", [
    Answer("Bhagat Singh", false),
    Answer("Jawaharlal Nehru", false),
    Answer("Sardar Vallabhbhai Patel", true),
    Answer("Subhas Chandra Bose", false),
  ]));

  list.add(Question("Who designed the Indian national flag?", [
    Answer("Mahatma Gandhi", false),
    Answer("Jawaharlal Nehru", false),
    Answer("Bhagat Singh", false),
    Answer("Pingali Venkayya", true),
  ]));

  list.add(Question("What is the national song of India?", [
    Answer("Jana Gana Mana", false),
    Answer("Vande Mataram", true),
    Answer("Saare Jahan Se Achha", false),
    Answer("Ae Mere Watan Ke Logon", false),
  ]));

  list.add(
      Question("Which Indian leader gave the 'Tryst with Destiny' speech?", [
    Answer("Subhas Chandra Bose", false),
    Answer("Sardar Patel", false),
    Answer("Mahatma Gandhi", false),
    Answer("Jawaharlal Nehru", true),
  ]));

  list.add(Question(
      "Which monument in New Delhi is associated with Independence Day celebrations?",
      [
        Answer("India Gate", false),
        Answer("Red Fort", true),
        Answer("Qutub Minar", false),
        Answer("Rashtrapati Bhavan", false),
      ]));

  list.add(Question("Who wrote the Indian national anthem?", [
    Answer("Rabindranath Tagore", true),
    Answer("Bankim Chandra Chatterjee", false),
    Answer("Sarojini Naidu", false),
    Answer("Subhas Chandra Bose", false),
  ]));

  list.add(Question(
      "Which freedom fighter is known as the 'Father of the Nation'?", [
    Answer("Bhagat Singh", false),
    Answer("Mahatma Gandhi", true),
    Answer("Lal Bahadur Shastri", false),
    Answer("Jawaharlal Nehru", false),
  ]));

  list.add(Question("Who was the first Prime Minister of independent India?", [
    Answer("Mahatma Gandhi", false),
    Answer("Sardar Patel", false),
    Answer("Subhas Chandra Bose", false),
    Answer("Jawaharlal Nehru", true),
  ]));

  list.add(Question("When did India gain independence from British rule?", [
    Answer("1950", false),
    Answer("1945", false),
    Answer("1947", true),
    Answer("1937", false),
  ]));

  list.add(Question("Which Indian leader led the Salt Satyagraha?", [
    Answer("Subhas Chandra Bose", false),
    Answer("Jawaharlal Nehru", false),
    Answer("N.K Narayan", false),
    Answer("Mahatma Gandhi", true),
  ]));

  list.add(Question(
      "Which Indian leader is known for his slogan 'Inquilab Zindabad'?", [
    Answer("Bhagat Singh", true),
    Answer("Subhas Chandra Bose", false),
    Answer("Mahatma Gandhi", false),
    Answer("Sardar Patel", false),
  ]));

  list.add(
      Question("Which movement led to the boycott of British goods in India?", [
    Answer("Civil Disobedience Movement", false),
    Answer("Swadeshi Movement", true),
    Answer("Quit India Movement", false),
    Answer("Non-Cooperation Movement", false),
  ]));

  list.add(Question("Who gave the slogan 'Jai Jawan Jai Kisan'?", [
    Answer("Indira Gandhi", false),
    Answer("Lal Bahadur Shastri", true),
    Answer("Jawaharlal Nehru", false),
    Answer("Sardar Patel", false),
  ]));

  return list;
}
