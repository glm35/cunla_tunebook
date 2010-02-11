\version "2.11.23"

\header {
    title = "Rakish Paddy"
    subtitle = "Reel"
}
%source = "Cyrille Gaillard (Mar/2005)"

melody =  {
    
    \key g \major
    \time 2/2

    \relative c'' {

        % A
        \repeat volta 2 {
            c4 c8 b  c4 a8 b | c a a g  e g g g |
            a d d cis  d e fis e | d c a g  fis g a b |
            c4 c8 b  c4 a8 b | c a a g  e g g e |
            d e fis g  a b c a | d c a g  fis a d,4 |
        }

        % B
        \repeat volta 2 {
            e'8 g g g  a g g g | e g g g  e d c d |
            e a a a  b a a g | e a a g  e d c d |
            e g g g  a4 a8 g | fis4 fis8 e  d e fis g |
            a fis g e  fis d e cis | 
        }
        \alternative {
            { d b a g  fis a d,4 }
            { d'8 b a g  fis g a b }
        }
    }
}

harmony =  {
    \chordmode {
        % A
        c1/a | c/a | d | d | c/a | c/a | d | d |

        % B
        c/a | c/a | d | d | c/a | c/a | d | d |
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
