\version "2.11.23"

\header{
	title = "The Crying Game"
	meter = "Slip jig"
	composer = "Carole Ménard"
}
%source = "Carole Ménard (Fev/2005)"

melody =  {
	\time 9/8
	\key b \minor
	\clef treble

  \relative fis' {
      % A
      \repeat volta 2 {
          fis8 b b  b cis d  e d cis | 
          fis,8 b b  b cis d  e cis a |
          fis8 b b  b cis d  e d cis |
          e d cis  d cis b  cis b a |
      }

      % B
      \repeat volta 2 {
          fis e d  a' b a  g fis e |
          fis e d  d' cis b  cis b a | 
          fis e d  a' b a  g fis e |
          d' cis b  cis b a  b a g |
      }
  }
}

harmony =  {
    \chordmode {
        % A
        b1:m ~ b8:m | b1:m ~ b8:m | b1:m ~ b8:m | a1 ~ a8 |

        % B
        d1 ~ d8 | d4./fis g a | d1 ~ d8 | g1 ~ g8 |
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
