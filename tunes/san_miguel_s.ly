\version "2.11.23"

\header {
    title = "San Miguel's"
    subtitle = "Reel"
    composer = "François Champs"
}
%source = "François Champs (Mar/2005)"

melody =  {

    \key g \major
    \time 2/2

    \relative g' {
        
        % A
        \repeat volta 2 {
            g4 b8 g  c g b g | c b g c  b g g g |
            a g g b  g g c g | b g g fis g4 g8 fis |
        }

        % B
        \repeat volta 2 {
            e4 b'4  d4 b4 | d8 e8 ~ e b  d a g fis |
            e4 d'  b d8 e ~ | e b d a  g4 g8 fis |
        }
    }
}

harmony =  {
    \chordmode {
        g1 | g | g | g |
        e:m | d | c | d |
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
