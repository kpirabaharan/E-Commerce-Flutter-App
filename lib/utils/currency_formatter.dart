String currencyFormatter(String value) {
  final formattedValue = value.contains('.') ? value : '$value.00';
  return '\$${formattedValue.substring(0, formattedValue.indexOf('.') + 3)}';
}
