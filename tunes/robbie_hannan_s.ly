\version "2.11.23"

\header {
    title = "Robbie Hannan's"
    meter = "Jig"
}
%source="François Champs (Fev/2005)"

melody =  {
    \key g \major
    \time 6/8

    \relative a' {
        
        % partie A
        \partial 4
        a8 g |
        \repeat volta 2 {
            fis4 d8  d a' g  | a4 a8  g e a | d,4 d8 a' g e | fis4 d8  d a' g |
            fis4. g | a4 a8  c d e | d c a  g e a | 
        }
        \alternative {
            { d,4 d8  d a' g | }
            { d4 d8  d a' b | }
        }

        %partie B
        \repeat volta 2 {
            c4 a8  a g fis | g4 g8  g fis g | a4 c8  b a g | a d cis  d4 e8 |
            fis e d  c a g | fis4. g | d'8 cis a  g e a |
        }
        \alternative {
            { d,4 d8  d a' b | }
            { d,2. \fermata | }
        }
    }
}

harmony =  {
    \chordmode {
        \partial 4
        r4 |

        % partie A
        d2. | d | d | d |
        d | d | c/d | c/d |
        % repeat
        c/d |

        % partie B
        c | g | d | d |
        d/fis | d/fis | g | g |
        % repeat
        d |
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
      tempoWholesPerMinute = #(ly:make-moment 130 4)
      }
    }


}
