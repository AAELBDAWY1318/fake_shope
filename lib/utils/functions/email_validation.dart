String? validateEmail(String? value) {
  // Regular expression for validating an email address
  const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  final RegExp regex = RegExp(emailPattern);

  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }

  return null; // Email is valid
}
