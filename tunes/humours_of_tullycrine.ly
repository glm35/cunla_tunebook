\version "2.11.23"

\header {
    title = "Humours of Tullycrine"
    subtitle = "Hornpipe"
}
%source="François Champs (Fev/2005)"

melody =  {
    \time 2/2
    \key a \minor

    \relative e'' {

        % partie A

        \partial 4
        e8 d |

        \repeat volta 2 {
            c4 a8 b c b c d | e a a g e4 d8 b |
            c4 c8 a b a g a | b d d e d4 b8 g |
            a g a b c b c d | e a a g e4 d8 b |
            c4 d8 e d b g b | 
        }
        \alternative {
            { c a a g a4 e'8 d | }
            { c a a g a4 \times 2/3 { a8 c d } | }
        }

        % partie B

        \repeat volta 2 {
            e8 a a g a g e d | e a a g a g e d |
            g4 g8 fis g e d4 | \times 2/3 { e8 fis g } fis a g e d g, |
            a g a b c b c d | e a a g e4 d8 b |
            c4 d8 e d b g b | 
        }
        \alternative {
            { c a a g a4 \times 2/3 { a8 c d | } }
            { c a a g a2 \fermata }
        }
    }
}

harmony =  {
    \chordmode {
        
        \partial 4
        r4 |

        % partie A
        a1:m | e:m | a2:m g | g1 |
        a1:m | e:m | c2 d2 | d4 g a2:m |
        %repeat
        a1:m |

        % partie B
        a1:m | e:m | g | e:m |
        a1:m | e:m | c2 d2 | d4 g a2:m |        
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
