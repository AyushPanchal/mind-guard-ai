import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Question {
  final String questionText;
  final List<String> options;

  final RxInt
      selectedOptionIndex; // Index of the selected option, initially null

  Question({
    required this.questionText,
    required this.options,
    int initialSelectedIndex = -1,
  }) : selectedOptionIndex = RxInt(initialSelectedIndex);
}
