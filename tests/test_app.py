import subprocess
import unittest

APP_PATH = "./build/main"
TIMEOUT = 3

def run_program(input_text):
    process = subprocess.run(
        [APP_PATH],
        input=(input_text + "\n").encode('utf-8'),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        timeout=TIMEOUT
    )
    return process

class TestDictionary(unittest.TestCase):

    def test_basic_words(self):
        cases = [
            ("welcome", "friendly greeting message"),
            ("999", "three nines"),
            ("my_var", "underscore identifier"),
            ("testword", "generic test case"),
        ]
        for key, expected in cases:
            with self.subTest(key=key):
                proc = run_program(key)
                self.assertEqual(proc.returncode, 0, f"Failed for key: {key}")
                self.assertEqual(proc.stdout.decode('utf-8').strip(), expected)
                self.assertEqual(proc.stderr, b"")

    def test_words_with_spaces(self):
        proc = run_program("good morning")
        self.assertEqual(proc.returncode, 0)
        self.assertEqual(proc.stdout.decode('utf-8').strip(), "daily salutation")
        self.assertEqual(proc.stderr, b"")

    def test_special_symbols(self):
        cases = [
            ("won't", "will not contraction"),
            ("re-enter", "hyphenated verb"),
            ("f=ma", "newton second law"),
            ("a&b", "ampersand test"),
            ("they're", "plural contraction"),
        ]
        for key, expected in cases:
            with self.subTest(key=key):
                proc = run_program(key)
                self.assertEqual(proc.returncode, 0, f"Failed for special key: {key}")
                self.assertEqual(proc.stdout.decode('utf-8').strip(), expected)
                self.assertEqual(proc.stderr, b"")

    def test_case_sensitive(self):
        proc_upper = run_program("Python")
        self.assertEqual(proc_upper.returncode, 0)
        self.assertEqual(proc_upper.stdout.decode('utf-8').strip(), "uppercase programming language")

        proc_lower = run_program("python")
        self.assertEqual(proc_lower.returncode, 0)
        self.assertEqual(proc_lower.stdout.decode('utf-8').strip(), "lowercase programming language")

    def test_empty_string(self):
        proc = run_program("")
        self.assertEqual(proc.returncode, 0)
        self.assertEqual(proc.stdout.decode('utf-8').strip(), "blank string accepted")
        self.assertEqual(proc.stderr, b"")

    def test_leading_trailing_spaces(self):
        proc_leading = run_program(" start")
        self.assertEqual(proc_leading.returncode, 0)
        self.assertEqual(proc_leading.stdout.decode('utf-8').strip(), "whitespace at beginning")

        proc_trailing = run_program("end ")
        self.assertEqual(proc_trailing.returncode, 0)
        self.assertEqual(proc_trailing.stdout.decode('utf-8').strip(), "whitespace at end")

    def test_duplicate_keys(self):
        proc = run_program("repeat")
        self.assertEqual(proc.returncode, 0)
        self.assertEqual(proc.stdout.decode('utf-8').strip(), "second occurrence overrides")

    def test_missing_words(self):
        missing = [
            "nonexistent",
            "Welcome",
            "good ",
            " good",
            "won't stop",
            "GOOD MORNING",
        ]
        for key in missing:
            with self.subTest(key=key):
                proc = run_program(key)
                self.assertNotEqual(proc.returncode, 0, f"Should fail for: {key}")
                self.assertEqual(proc.stdout, b"")
                self.assertGreater(len(proc.stderr), 0, "stderr must have error message")

    def test_max_length_key_254(self):
        max_key = "q" * 254
        proc = run_program(max_key)
        self.assertEqual(proc.returncode, 0, "254 chars should be accepted and found")
        self.assertEqual(proc.stdout.decode('utf-8').strip(), "two hundred fifty four chars")
        self.assertEqual(proc.stderr, b"")

    def test_max_length_key_255(self):
        max_key = "p" * 255
        proc = run_program(max_key)
        self.assertEqual(proc.returncode, 0, "255 chars should be accepted and found")
        self.assertEqual(proc.stdout.decode('utf-8').strip(), "two hundred fifty five chars")
        self.assertEqual(proc.stderr, b"")

    def test_buffer_overflow(self):
        overflow_keys = ["r" * 256, "s" * 1000]
        for key in overflow_keys:
            with self.subTest(length=len(key)):
                proc = run_program(key)
                self.assertEqual(proc.returncode, 1, f"Should reject {len(key)} chars")
                self.assertEqual(proc.stdout, b"")
                self.assertIn(b"too long", proc.stderr.lower(), "stderr must mention length error")

    def test_newline_in_input(self):
        proc = run_program("welcome\nextra_data")
        self.assertEqual(proc.returncode, 0)
        self.assertEqual(proc.stdout.decode('utf-8').strip(), "friendly greeting message")
        self.assertEqual(proc.stderr, b"")

    def test_single_characters(self):
        cases = [
            ("m", "single letter m"),
            ("n", "single letter n"),
            ("7", "lucky number"),
        ]
        for key, expected in cases:
            with self.subTest(key=key):
                proc = run_program(key)
                self.assertEqual(proc.returncode, 0)
                self.assertEqual(proc.stdout.decode('utf-8').strip(), expected)
                self.assertEqual(proc.stderr, b"")

if __name__ == "__main__":
    unittest.main(verbosity=2)