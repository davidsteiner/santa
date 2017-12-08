import santa
import unittest


class SantaTest(unittest.TestCase):

    def test_calculate_kid_id(self):
        """ Test that the calculate_kid_id calculates the kid ID correctly for the specified values in the challenge """
        self.assertEqual(santa.calculate_kid_id(1, 1), 1)
        self.assertEqual(santa.calculate_kid_id(2, 1), 2)
        self.assertEqual(santa.calculate_kid_id(1, 2), 3)
        self.assertEqual(santa.calculate_kid_id(3, 1), 4)

    def test_find_solution(self):
        """ Test that find_solution gives the expected results """
        self.assertEqual(santa.find_solution(100), 14257)
        self.assertEqual(santa.find_solution(6300000000), 77301763)
