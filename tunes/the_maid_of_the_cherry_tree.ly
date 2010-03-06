\version "2.11.23"

\header{
	title = "The Maid of the Cherry Tree"
	meter = "Reel"
%	composer = ""
}
%source = "François Champs (Fev/2005)"

melody =  {
	\time 2/2
	\key a \minor
	\clef treble
  
% part A

  \repeat volta 2 {
      e''8 a' c'' a' e'' a' c'' a' | g'4 b'8 g' d'' g' b'4 |
      e''8 a' c'' a' e'' a' c'' a' | d'' b' g' b' c'' a' a' a' |
      e'' a' c'' a' e'' a' c'' a' |	g'4 b'8 g' d'' g' b'4 |
      c''8 c'' c'' a' b' g' g'4 |	}
  \alternative {
      { d''8 b' g' b' c''[ a'] a' a'}
      { d''8 b' g' b' c''[ a'] a'[ b']}
  }

% part B

  \repeat volta 2 {
      c''4 e''8 c'' g'' c'' e'' c'' | c''4 e''8 g'' d'' b' g' b' |
      c''4 e''8 c'' g'' c'' e''4 | d''8 b' g' b' c'' a' a' b' |
      c''4 e''8 c'' g'' c'' e'' c'' |	c''4 e''8 g'' d'' b' g' b' |
      c'' c'' c'' a' b' g' g'4 | d''8 b' g' b' c''[ a'] }
  \alternative {
      { a' b' }
      { a'[ a'] \bar "|." }
  }
}


harmony =  {
    \chordmode {

        % A
        a1:m | a:m | a:m | e:m |
        a:m | a:m | a:m | e:m |
        a4:m e4.:m d |

        % B
        c1 | c | c | f2 g |
        c1 | c | f | g |
    }
}

\score{
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
      tempoWholesPerMinute = #(ly:make-moment 180 4)
      }
    }


}
