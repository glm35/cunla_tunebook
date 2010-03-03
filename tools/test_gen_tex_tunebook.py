#!/usr/bin/env python
# -*- coding:utf-8 -*-

import unittest
import filecmp
import os

import gen_tex_tunebook
from gen_tex_tunebook import *

# unittest reminder:
# assert functions: assertEqual(), assertRaises() and assert_(condition)

class TestTuneIndex(unittest.TestCase):

    def test_format_tune_index_entry(self):
        tune = Tune()
        tune.title = "Come Upstairs with Me"
        tune.type = "slip jig"
        tune.label = "come_upstairs_with_me"

        expected_result = "\emph{Come Upstairs with Me}~(slip jig),~p.\pageref{come_upstairs_with_me}"

        self.assertEqual(expected_result, tune.format_index_entry())

    def test_sort_by_name(self):
        tunes = [Tune("yellow_tinker", "Yellow Tinker", "reel"),
                 Tune("come_upstairs_with_me", "Come Upstairs with Me", "slip jig"),
                 Tune("mistress_on_the_floor", "Mistress on the Floor", "reel")]

        sorted_tunes = sort_tunes(tunes)

        self.assertEqual([Tune("come_upstairs_with_me", "Come Upstairs with Me", "slip jig"),
                          Tune("mistress_on_the_floor", "Mistress on the Floor", "reel"),
                          Tune("yellow_tinker", "Yellow Tinker", "reel")], sorted_tunes)

    def test_demote_determinant(self):
        self.assertEqual("Yellow Tinker, The", demote_determinant("The Yellow Tinker"))

    def test_dont_demote_determinant(self):
        self.assertEqual("Then I Go", demote_determinant("Then I Go"))

    def test_dont_demote_determinant_2(self):
        self.assertEqual("", demote_determinant(""))


if __name__ == '__main__':
    unittest.main()

    #suite = unittest.TestLoader().loadTestsFromTestCase(TestCurrent)
    #unittest.TextTestRunner(verbosity=2).run(suite)
