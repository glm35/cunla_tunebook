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

    def test_tune_index(self):
        pass


if __name__ == '__main__':
    unittest.main()

    #suite = unittest.TestLoader().loadTestsFromTestCase(TestCurrent)
    #unittest.TextTestRunner(verbosity=2).run(suite)
