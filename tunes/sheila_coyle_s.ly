\version "2.11.23"

\header {
    title = "Sheila Coyle's"
    meter = "Reel"
}
%source = "Florian (2005-03)"
%composer = Trad.

melody =  {
    \key d \major
    \time 2/2

    \relative fis' {
        
        % A
        \repeat volta 2 {
            fis8 a a fis  a4 d,8 fis | a d, fis a  b a g fis |
            g b b a  b4 d8 b | a b d fis  e d b a |
            fis8 a a fis  a4 d,8 fis | a d, fis a  b a g fis |
            g4 g8 b  a4 a8 fis | e fis g e  fis d d4 |
        }

        % B
        \repeat volta 2 {
            d'8 fis fis e  fis4 fis8 e | d e fis d  a g fis d |
            cis'4  e8 cis  fis cis e4 | b8 cis d cis  b a fis a |
            d8 fis fis e  fis4 fis8 e | d e fis d  a g fis d |
            g4 g8 b  a4 a8 fis | e fis g e  fis d d4 |            
        }

    }
}

harmony =  {
    \chordmode {
        % A
        d1 | d | g | g | d | d | g | g2 a2 |

        % B
        d1 | d | e:m | e:m | d/fis | d/fis | g | g2 a2 |
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
      tempoWholesPerMinute = #(ly:make-moment 120 4)
      }
    }


}