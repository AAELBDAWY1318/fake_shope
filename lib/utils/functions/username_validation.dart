String? validateUsername(String? value) {
  // Minimum and maximum length requirements
  const int minLength = 3;
  const int maxLength = 20;

  if (value == null || value.isEmpty) {
    return 'Username cannot be empty';
  } else if (value.length < minLength) {
    return 'Username must be at least $minLength characters long';
  } else if (value.length > maxLength) {
    return 'Username cannot be more than $maxLength characters long';
  } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
    return 'Username can only contain letters, numbers, and underscores';
  } else if (value.contains(' ')) {
    return 'Username cannot contain spaces';
  }

  return null; // Username is valid
}
