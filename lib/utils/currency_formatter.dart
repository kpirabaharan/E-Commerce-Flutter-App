String currencyFormatter(String value, {int? quantity}) {
  String formattedValue = '';
  if (quantity != null) {
    formattedValue = (double.parse(value) * quantity).toStringAsFixed(2);
  } else {
    formattedValue = value.contains('.') ? value : '$value.00';
  }
  return '\$${formattedValue.substring(0, formattedValue.indexOf('.') + 3)}';
}
