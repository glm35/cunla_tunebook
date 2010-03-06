\version "2.11.23"

\header{
	title = "Farewell to Whalley Range"
	meter = "Slip jig"
	composer = "Michael McGoldrick"
}
%source = "François Champs (Fev/2005)"

melody =  {
	\time 9/8
	\key fis \minor
	\clef treble

% A
  \repeat volta2 {
  	fis'4 cis''8 b' a' fis' fis'4 e'8 |
    fis'4 cis''8 b' a' cis'' fis'' e'' cis'' |
    b'4 b'8 b' a' b' cis''4 a'8 |
  }
  \alternative {
    { b'4 b'8 b' a' b' cis'' b' a' | }
    { b'4 b'8 b' a' b' cis'' e'' fis'' | }
  }

% B
  \repeat volta2 {
  	a''4 a''8 fis'' e'' cis'' fis'' e'' cis'' |
    b'4 b'8 b' a' b' cis'' e'' fis'' |
    a''4 a''8 b'' a'' fis'' a'' fis'' e'' |
  }
  \alternative {
    { fis'' e'' cis'' b' cis'' e'' fis'' e'' cis'' | }
    { fis'' e'' cis'' fis'' e'' cis'' b' a' b' }
  }
}

harmony =  {
    \chordmode {
        % A
        fis1:m ~ fis8:m | fis1:m ~ fis8:m | fis1:m ~ fis8:m | fis1:m ~ fis8:m |
        % repeat
        fis1:m ~ fis8:m |

        %B
        a1 ~ a8 | a1 ~ a8 | d1 ~ d8 | d1 ~ d8 |
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
    \layout {
    }
    
  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(ly:make-moment 120 4)
      }
    }


}
