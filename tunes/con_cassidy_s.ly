\version "2.11.23"

\header{
	title = "Con Cassidy's"
	meter = "Highland"
}
%source = "François Champs (Fev/2005)"

melody =  {
	\time 2/2
	\key d \major
	\clef treble

% A

  \repeat volta2 {
      cis''8 a' a' g' e' a' a' b' | cis'' b' a' gis'' a'' gis'' a'' d'' |
      cis'' a' a' g' e' a' a'4 | b'16 c'' b'8 g' b' d'' g'' e'' d'' |
  }

% B

	\key g \major

  c''4 c''8 e'' g'' e'' c'' b' | c'' b' a' b'' a'' g'' e'' d'' |
	c''4 d'' e''8 fis'' g'' e'' |	d'' b' b' b' d'' g'' e'' d'' |
	c''4 c''8 e'' g'' e'' c'' b' | c'' b' a' g'' a'' b'' g'' a'' |
	a''4 a''8 fis'' g'' a'' g'' e'' | d'' b' b'4 fis''16 g'' a''8 e'' d'' \bar "|."
}

harmony =  {
    \chordmode {

        % A
        a1 | d | a | g/a |
        
        % B
        a1:m | a:m | a:m | g/a |
        a:m | g | d | d |
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
    \layout { }
    
  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(ly:make-moment 120 4)
      }
    }


}
