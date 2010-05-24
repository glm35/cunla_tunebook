\version "2.12.2"

\header {
    title = "The Full Booner"
}

melody = {
    \clef treble
    \key a \mixolydian
    \time 10/8

    \repeat volta 2 {
        a'8[ e''8 e''8] e''8[ d''8 b'8] cis''4 d''8[ b'8] |
        cis''8[ e''8 e''8] d''8[ b'8 a'8] fis''4 g''8[ e''8] |
        a'8[ e''8 e''8] e''8[ d''8 b'8] cis''4 d''8[ b'8] |
        cis''8[ e''8 e''8] d''8[ b'8 a'8] a'4 a'4
    }
    \repeat volta 2 {
        g''8[ a''8 g''8] e''8[ d''8 e''8] fis''8[ g''8] a''8[ e''8] |
        a''8[ a''8 a''8] e''8[ d''8 e''8] fis''8[ g''8] fis''8[ d''8] |
        a'8[ e''8 e''8] e''8[ d''8 b'8] cis''4 d''8[ b'8] |
        cis''8[ e''8 e''8] d''8[ b'8 a'8] a'4 a'4
    }
}

\score {
    \new Staff \melody
    \layout { }
    \midi { }
}
