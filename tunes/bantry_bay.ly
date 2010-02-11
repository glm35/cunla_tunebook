\version "2.11.23"

\header {
    title = "Bantry Bay"
    subtitle = "Hornpipe"
}
%source="François Champs (Fev/2005)"

melody =  {
    \time 2/2
    \key g \major

    \relative g' {

        % partie A

        \partial 4
        g8 a

        \repeat volta 2 {
            b8 g a g e g d e | g4 g8 fis g b a g |
            e g a b c b a g | e a a g a4 a8 b |
            c4 c8 a b4 b8 g | a b a g e g d4 |
            b'8 g a g e g d e |
        }
        \alternative {
            { g4 g8 fis g4 g8 a | }
            { g4 g8 fis g4 \times 2/3 { a8 b c } | }
        }

        % partie B

        \repeat volta 2 {
            d4 d8 e d b g a | b e e d e4 e8 fis |
            g fis e d b g b d | g4 g8 fis g4 e8 fis |
            g a g fis e fis e d | b g a g e g d4 |
            b'8 g a g e g d e |
        }
        \alternative {
            { g4 g8 fis g4 \times 2/3 { a8 b c } | }
            { g4 g8 fis g2 \fermata }
        }
    }
}

harmony =  {
    \chordmode {
        \partial 4
        r4 |

        % partie A
        g1 | g | a:m |a:m | b:m | b:m | c | d |
        % repeat
        d1 |

        % partie B
        g1 | b:m | e:m | g | b:m | a:m | b:m | c2 d2 |
        % repeat
        c2 g2 |
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
    \layout {}
    
  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(ly:make-moment 100 4)
      }
    }


}
