\version "2.11.23"

\header {
    title = "Unnamed Jig 5"
    meter = "Jig"
}
%source = "François Champs (Fev/2005)"
%discography = "Avant avant dernier album de Danu (2005-09), dans le morceau uncle rat"

melody =  {
    \key g \major
    \time 6/8

    \relative d'' {

        % partie A
        \repeat volta 2 {
            d8 e d  c4. | d8 e d  c4. | d8 e d  c d e | d c a  g e d |
            d'8 e d  c4. | d  d4 c8  | a4 a8  a b c  | d c a  g e d |
        }

        % partie B
        \repeat volta 2 {
            d'8 c a  a g e | a4 a8  a b c | d c a  a b c | d c a  g e d |
            d'8 c a  a g e | a4 a8  a g e | d4 d8  c' d e | d c a  g e d |
        }
    }
}

harmony =  {
    \chordmode {
        % partie A
        d2. | d | d | d |
        d | d |c/a | c/a |

        % partie B
        d | d | d/fis | d/fis | 
        g | g | e:m | e:m | 
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

% \score {
%      << 
%         \context ChordNames {
%             \set chordChanges = ##t
%             \harmony
%         }
%         \context Staff \melody
%     >>
%     \layout {}
%     
  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(ly:make-moment 130 4)
      }
    }


% }
