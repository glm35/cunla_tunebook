\version "2.11.23"

\header {
    title="Unnamed Hornipe 1"
    meter="Hornpipe"
}
%source="François Champs (Fev/2005)"

melody =  {
    \time 2/2
    \key d \major
    \clef treble

    \set tupletSpannerDuration = #(ly:make-moment 1 4)

    \relative d' {

% partie A
        \repeat volta 2 {
            d8 fis a fis d g  b g | fis a d e fis d a fis |
            g4 e'8 fis g fis g fis | \times 2/3 {e8 fis e  d cis b  a b a  g fis e } |
            d8 fis a fis d g  b g | fis a d e fis d a fis |
            g4 e'8 fis g e a, cis |
        }
        \alternative {
            { e d d cis d a fis a }
            { e' d d cis d4 cis8 d }
        }

% partie B
        \repeat volta2 {
            e8 a, a a e4 e'8 fis | g4 fis8 g e a, a a |
            e4 e'8 fis g fis g fis | \times 2/3 {e8 fis e  d cis b  a b a  g fis e } |
            d8 fis a fis d g  b g | fis a d e fis d a fis |
            g4 e'8 fis g e a, cis |
        }
        \alternative {
            { e d d cis d4 cis8 d }
            { e d d cis d a fis a }
        }
    }
}

harmony =  {
    \chordmode {
        % partie A
        d2 d/cis | d/b d/a | g d/fis | e:m a |
        d d/cis | d/b d/fis | g1 | g4 a d2 |
        % repeat
        g4 a d2 |

        % partie B
        e1:m | g2 e:m | e1:m | g2 a |
        d d/cis | d/b d/fis | g1 | g4 a d2 |
        % repeat
        g4 a d2 |
    }
}

\score {
     <<
        \context ChordNames {
            \set chordChanges = ##t
            \harmony
        }
        \context Staff \melody
    >>
    \layout{}
    \midi{}
}