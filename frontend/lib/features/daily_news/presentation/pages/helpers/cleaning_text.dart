String cleanText(String? text) {
  if (text == null) return '';

  // Quitar espacios al inicio y final
  String cleaned = text.trim();

  // Eliminar cualquier carácter que no sea letra, número, espacio o puntuación básica dentro del texto
  cleaned = cleaned.replaceAll(
      RegExp(r'^[^A-Za-zÁÉÍÓÚáéíóúÑñ0-9]+'), ''); // al inicio
  cleaned =
      cleaned.replaceAll(RegExp(r'[^A-Za-zÁÉÍÓÚáéíóúÑñ0-9]+$'), ''); // al final

  return cleaned;
}
