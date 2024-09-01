String? validateEgyptianPhoneNumber(String? value) {
  // Regular expression for Egyptian phone numbers
  const String phonePattern = r'^(01)[0-9]{9}$';
  final RegExp regex = RegExp(phonePattern);

  if (value == null || value.isEmpty) {
    return 'Phone number cannot be empty';
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid Egyptian phone number (e.g., 01XXXXXXXXX)';
  }

  return null; // Phone number is valid
}
