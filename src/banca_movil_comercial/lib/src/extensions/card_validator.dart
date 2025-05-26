enum CreditCardTypes {
  visa,
  mastercard,
  americanExpress,
  discover,
  dinersClub,
  jcb,
  unknown,
}

extension CreditCardValidator on String {
  CreditCardTypes get getCardType {
    // Eliminar caracteres no numéricos y extraer los primeros 6 dígitos disponibles
    String cleanedNumber = replaceAll(RegExp(r'[^0-9]'), '');
    String binPart = cleanedNumber.length >= 6
        ? cleanedNumber.substring(0, 6)
        : cleanedNumber.length >= 4
            ? cleanedNumber.substring(0, 4)
            : cleanedNumber;

    // Diccionario de patrones
    final patterns = {
      CreditCardTypes.visa: RegExp(r'^4'),
      CreditCardTypes.mastercard:
          RegExp(r'^(5[1-5]|222[1-9]|22[3-9]|2[3-6]|27[01]|2720)'),
      CreditCardTypes.americanExpress: RegExp(r'^3[47]'),
      CreditCardTypes.discover: RegExp(r'^6(?:011|5)'),
      CreditCardTypes.dinersClub: RegExp(r'^3(?:0[0-5]|[68])'),
      CreditCardTypes.jcb: RegExp(r'^(?:2131|1800|35)'),
    };

    // Buscar coincidencia con patrones
    for (var entry in patterns.entries) {
      if (entry.value.hasMatch(binPart)) {
        return entry.key;
      }
    }
    return CreditCardTypes.unknown;
  }
}
