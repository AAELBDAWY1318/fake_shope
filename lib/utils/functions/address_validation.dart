String? validateAddress(String? value) {
  // Minimum length requirement for an address
  const int minLength = 5;

  if (value == null || value.isEmpty) {
    return 'Address cannot be empty';
  } else if (value.length < minLength) {
    return 'Address must be at least $minLength characters long';
  } else if (!RegExp(r'^[a-zA-Z0-9\s,.-]+$').hasMatch(value)) {
    return 'Address contains invalid characters';
  }

  return null; // Address is valid
}
