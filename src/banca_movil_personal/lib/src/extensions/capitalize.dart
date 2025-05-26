// extension Capitalize on String {
//   String get capitalize {
//     if (isEmpty) return this;

//     return split(' ').map((word) {
//       if (word.isEmpty) return word;
//       return word[0].toUpperCase() + word.substring(1).toLowerCase();
//     }).join(' ');
//   }

//   String get capitalizeSentences {
//     if (isEmpty) return this;

//     return split(RegExp(r'(?<=[.!?])\s+')).map((sentence) {
//       if (sentence.isEmpty) return sentence;
//       return sentence[0].toUpperCase() + sentence.substring(1).toLowerCase();
//     }).join(' ');
//   }

//   String get creditCardFormat {
//     return replaceAll("x", "*").replaceAll("-", " ");
//   }

//   String get obtenerUltimosDigitos {
//     return length <= 4 ? this : substring(length - 4);
//   }
// }
