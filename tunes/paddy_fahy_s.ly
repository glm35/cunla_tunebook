\version "2.11.23"

\header {
	crossRefNumber = "1"
	footnotes = ""
	title = "Paddy Fahy's"
	meter = "Reel"
}
%source = "François Champs (Fev/2005)"
%discography = "Kevin Crawford: In good company"

melody =  {
    \time 2/2
    \key g \major
    \repeat volta 2 {
        b'8    g'8    g'8    g'8    b'8    d''8    c''8    a'8 |
        a'8    g'8    b'8    d''8    c''8    a'8    fis'8    a'8 |
        b'8    g'8    g'4    b'8    c''8    d''8    g''8 |
        fis''8    g''8    a''8    fis''8    g''8    e''8    d''8    c''8 |
        b'8    g'8    g'8    g'8    b'8    d''8    c''8    a'8 |
        a'8    g'8    b'8    d''8    c''8    a'8    fis'8    a'8 |
        b'8    g'8    g'4    b'8    c''8    d''8    g''8 |
    }
    \alternative{
        { fis''8    g''8    a''8    fis''8    g''4 a'4 | }
        { fis''8    g''8    a''8    fis''8    g''4 g''8 a''8 | }
    }
     
    \repeat volta 2 {
        b''8    g''8    a''8    fis''8    d''8    g''8    g''8    g''8 |
        fis''8    d''8    c''8    a'8    fis'8    g'8    a'4 |
        b''8    g''8    a''8    fis''8    d''8    g''8    g''8    g''8 |
        fis''8    g''8    a''8    fis''8    g''4    g''8    a''8 |
        b''8    g''8    a''8    fis''8    d''8    g''8    g''8    g''8 |
        fis''8    d''8    c''8    a'8    fis'8    g'8    a'4 |
        b'8    g'8    g'8    g'8    b'8    c''8    d''8    g''8 |
    }
    \alternative{
        { fis''8    g''8    a''8    fis''8 g''4    g''8    a''8 | }
        { fis''8    g''8    a''8    fis''8 g''8    e''8    d''8    c''8 |
%          b'8 g'8 g'2 \fermata
	}
    }
}

harmony =  {
    \chordmode {
        % A
        \repeat volta 2 {
            g1 | g | g | e:m |
            g1 | g | g }
        \alternative {
            {e1:m | }
            {e1:m | }
        }
        
        %B
        \repeat volta 2 {
            e1:m | d | c:9 | d2 g2 |
            e1:m | d | c2:9 a:m |
        }
        \alternative {
            { c2 d | }
            { c2 d | } %g }
        }
    }
}



\score{
     <<
        \context ChordNames{
            \set chordChanges = ##t
            \harmony
        }
        \context Staff \melody
    >>
    \layout {}
    \midi {}
}
