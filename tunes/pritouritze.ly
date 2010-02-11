\version "2.11.23"

\header {
    title = "Pritouritze"
    subtitle = "Reel"
    composer = "François Champs"
}
%source = François Champs (Mar/2005)

melody =  {
    \key e \minor
    \time 2/2

    \relative a' {
        
        % partie A
        \repeat volta 2 {
            a8 b b a  b d e b | d b a g  e d e b' |
            a4 a8 g  a b c e | d b a g  e d e g |
            a8 b b a  b d e b | d b a g  e d e b' |
            a4 a8 g  a b c e |
        }
        \alternative {
            { d8 b a g  e4 a | }
            { d8 b a g  e4 g'8 fis | }
        }

        % partie B
        \repeat volta 2 {
            g8 b, b b  e b g' b, | e b b a  b d e fis |
            g8 b, b b  e4 g8 fis | e g fis e  a g fis e |
            g8 b, b b  e b g' b, | e b b a  b d e g |
            a,4 a8 g  a b c e |
        }
        \alternative {
            { d8 b a g  e4 g'8 fis | }
            { d8 b a g  e2 \fermata | }
        }
    }
}

harmony =  {
    \chordmode {
        % A
        e1:m | e:m | d | d | c | c | d | d |
        % repeat
        d |

        % B
        e:m | e:m | d | d | a:m | a:m | c | d |
        % revoir le nommage du Am (la, do, ré, sol)
        
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