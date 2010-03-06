\version "2.11.23"

\header {
    title = "Allistrum March"
    meter = "Jig"
}
%source = "François Champs (Fev/2005)"
%discography = "Niall & Cillian Vallely: Callan Bridge"

melody =  {
    \key d \major
    \time 6/8

    \relative e' {

        % partie A
        \repeat volta 2 {
            e8^"Asus" cis' cis  e d d | fis^"G/A" d d  cis^"A" a g |
            e8^"Asus" cis' cis  e d d | fis^"G/A" d cis  a4 g8 |
        }

        % partie B
        \repeat volta 2 {
            fis^"Dsus" g e  fis d d | d d' cis  a g e |
            fis g e  fis d d | d^"D" d' cis  a4^"Dsus" g8 |
        }
    }
}

\score {

    \context Staff \melody

    \layout {}
    
  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(ly:make-moment 130 4)
      }
    }



}
