String? validatePassword(String? value) {
  // Minimum length requirement
  const int minLength = 8;

  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  } else if (value.length < minLength) {
    return 'Password must be at least $minLength characters long';
  } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  } else if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  } else if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Password must contain at least one digit';
  } else if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
    return 'Password must contain at least one special character (!@#\$&*~)';
  }

  return null; // Password is valid
}
