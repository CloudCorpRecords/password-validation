import unittest

from solution import get_password_strength, is_weak


class TestPasswordStrength(unittest.TestCase):
    def test_problem_example(self):
        self.assertEqual(
            get_password_strength(
                ["iliketoCoDe", "teaMAKEsmehappy", "123456789", "xYz12", "password"],
                ["coffee", "code", "happy"],
            ),
            ["strong", "weak", "weak", "weak", "weak"],
        )

    def test_length_boundary(self):
        self.assertTrue(is_weak("Abc12", []))
        self.assertFalse(is_weak("Abc123", []))

    def test_digits_only(self):
        self.assertTrue(is_weak("123456", []))
        self.assertFalse(is_weak("12345a", []))

    def test_single_case(self):
        self.assertTrue(is_weak("abcdefg", []))
        self.assertTrue(is_weak("ABCDEFG", []))
        self.assertFalse(is_weak("Abcdefg", []))

    def test_common_word_is_case_sensitive(self):
        self.assertTrue(is_weak("mycoffeecup1", ["coffee"]))
        self.assertFalse(is_weak("myCoffeeCup", ["coffee"]))

    def test_empty_common_word_is_ignored(self):
        self.assertFalse(is_weak("Abc123", [""]))


if __name__ == "__main__":
    unittest.main()
