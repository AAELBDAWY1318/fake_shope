String? validateConfirmPassword(String? value, String? originalPassword) {
  if (value == null || value.isEmpty) {
    return 'Confirm password cannot be empty';
  } else if (value != originalPassword) {
    return 'Passwords do not match';
  }

  return null; // Confirm password is valid
}
