abstract class AddressValidator {
  static String? validateCEP(String? value) {
    if (value!.isEmpty) return "O CEP é obrigatorio";
    return null;
  }

  static String? validateLogradouro(String? value) {
    if (value!.isEmpty) return "O logradouro é obrigatório";
    if (value.length < 4) return "Digite um logradouro valido";
    return null;
  }

  static String? validateBairro(String? value) {
    if (value!.isEmpty) return "O bairro é obrigatório";
    if (value.length < 2) return "Digite um bairro valido";
    return null;
  }

  static String? validateCidade(String? value) {
    if (value!.isEmpty) return "A cidade é obrigatória";
    return null;
  }

  static String? validateNumero(String? value) {
    if (value!.isEmpty) return "Desabilite o numero caso não tenha";
    return null;
  }

  static String? validateComplemento(String? value) {
    if (value!.isEmpty) return "Desabilite o complemento caso não tenha";
    return null;
  }
}
