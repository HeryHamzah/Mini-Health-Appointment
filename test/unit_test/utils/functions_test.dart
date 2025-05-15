import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_health_appointment/core/utils/functions.dart';

void main() {
  group('combineDateAndTime', () {
    test('should combine date and time correctly', () {
      final date = DateTime(2025, 5, 15);
      final time = const TimeOfDay(hour: 14, minute: 30);
      final result = combineDateAndTime(date, time);

      expect(result.year, 2025);
      expect(result.month, 5);
      expect(result.day, 15);
      expect(result.hour, 14);
      expect(result.minute, 30);
    });
  });

  group('emailValidator', () {
    test('returns error if email is empty', () {
      expect(emailValidator(''), isNotNull);
      expect(emailValidator('   '), isNotNull);
      expect(emailValidator(null), isNotNull);
    });

    test('returns error if email format is incorrect', () {
      expect(emailValidator('invalid_email'), isNotNull);
      expect(emailValidator('example@'), isNotNull);
      expect(emailValidator('example.com'), isNotNull);
    });

    test('returns null if email is valid', () {
      expect(emailValidator('test@example.com'), null);
    });
  });

  group('passwordValidator', () {
    test('returns error if password is empty', () {
      expect(passwordValidator(''), isNotNull);
      expect(passwordValidator(null), isNotNull);
    });

    test('returns error if password is less than 6 characters', () {
      expect(passwordValidator('12345'), isNotNull);
    });

    test('returns null if password is valid', () {
      expect(passwordValidator('123456'), null);
      expect(passwordValidator('mypassword'), null);
    });
  });

  group('confirmPasswordValidator', () {
    test('returns error if confirm password is empty', () {
      expect(confirmPasswordValidator('', '123456'), isNotNull);
      expect(confirmPasswordValidator(null, '123456'), isNotNull);
    });

    test('returns error if passwords do not match', () {
      expect(confirmPasswordValidator('abcdef', '123456'), isNotNull);
    });

    test('returns null if passwords match', () {
      expect(confirmPasswordValidator('123456', '123456'), null);
      expect(confirmPasswordValidator('  password ', 'password'),
          null); // trimming
    });
  });
}
