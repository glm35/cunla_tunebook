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

    def test_demote_determinant_2(self):
        self.assertEqual("Ridées de Lanvaudan, Les",
                         demote_determinant("Les Ridées de Lanvaudan"))

    def test_dont_demote_determinant(self):
        self.assertEqual("Then I Go", demote_determinant("Then I Go"))

    def test_dont_demote_determinant_2(self):
        self.assertEqual("", demote_determinant(""))

    def prepare_exception_text(self, before, after):
        text = "The sorted list differs from the expected sorted list\n"
        text += "Expected sorted list:\n"
        for tune in before:
            text += "    " + str(tune) + "\n"
        text += "Actual sorted list:\n"
        for tune in after:
            text += "    " + str(tune) + "\n"
        return text

    def test_sort_by_name_demote_determinant(self):
        tunes = [Tune("the_humours_of_whiskey", "The Humours of Whiskey", "slip jig"),
                 Tune("come_upstairs_with_me", "Come Upstairs with Me", "slip jig"),
                 Tune("mistress_on_the_floor", "Mistress on the Floor", "reel")]

        sorted_tunes = sort_tunes(tunes)

        expected_sorted_tunes = [Tune("come_upstairs_with_me", "Come Upstairs with Me", "slip jig"),
                                 Tune("the_humours_of_whiskey", "Humours of Whiskey, The", "slip jig"),
                                 Tune("mistress_on_the_floor", "Mistress on the Floor", "reel")]

        self.assertEqual(expected_sorted_tunes, sorted_tunes,
                         self.prepare_exception_text(expected_sorted_tunes, sorted_tunes))

    def test_gen_index_of_tunes(self):
        tunes = [Tune("the_humours_of_whiskey", "The Humours of Whiskey", "slip jig"),
                 Tune("come_upstairs_with_me", "Come Upstairs with Me", "slip jig"),
                 Tune("toss_the_feathers", "Toss the Feathers", "reel"),
                 Tune("mistress_on_the_floor", "Mistress on the Floor", "reel")]

        latex_index = gen_index_of_tunes(tunes)

        expected_latex_index = r"""\section*{Index des airs}
\emph{Come Upstairs with Me}~(slip jig),~p.\pageref{come_upstairs_with_me}

\emph{Humours of Whiskey, The}~(slip jig),~p.\pageref{the_humours_of_whiskey}

\emph{Mistress on the Floor}~(reel),~p.\pageref{mistress_on_the_floor}

\emph{Toss the Feathers}~(reel),~p.\pageref{toss_the_feathers}

"""

        self.assertEqual(expected_latex_index, latex_index)


if __name__ == '__main__':
    unittest.main()

    #suite = unittest.TestLoader().loadTestsFromTestCase(TestCurrent)
    #unittest.TextTestRunner(verbosity=2).run(suite)
