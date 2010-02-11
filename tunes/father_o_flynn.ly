\version "2.7.40"
\header {
	crossRefNumber = "1"
	footnotes = ""
	subtitle = "Cunla (juin 2005)"
	tagline = "Lily was here 2.12.2 -- automatically converted from ABC"
	title = "Father O'Flynn"
}
voicedefault =  {
\set Score.defaultBarType = "empty"

\key d \major \time 6/8 %  partie A

\repeat volta 2 {
    d''8 ^"D"   a'8    fis'8    d'8    fis'8    a'8  \bar "|"
    b'8    e''8    d''8    cis''8    b'8    cis''8    \bar "|"
    d''8   cis''8    d''8    e''8    fis''8    g''8    \bar "|"
    fis''8 ^"G"   d''8    d''8    e''8    cis''8    a'8        \bar "|"
    d''8 ^"D"   a'8    fis'8    d'8    fis'8    a'8    \bar "|"
    b'8    e''8    d''8    cis''8    b'8    cis''8    \bar "|"
    d''8    cis''8    d''8      e''8 ^"G"   fis''8    g''8    
}
\alternative {
    {     fis''8 ^"A"   d''8    cis''8      d''4. ^"D"   }
    {     fis''8 ^"A"   d''8    cis''8      d''4 ^"D"   e''8 }
}

%  partie B

\repeat volta 2 {
    fis''4 ^"D"   fis''8    fis''8    g''8    a''8    \bar "|"
    e''8    cis''8    a'8    a'8    b'8    cis''8    \bar "|"
    d''8 ^"G"   cis''8    d''8    b'8    e''8    d''8    \bar "|"
    cis''8    a'8    a'8    a'8    b'8    c''8        \bar "|"
    b'4 ^"Em"   b'8    b'8    cis''8    d''8    \bar "|"
    a'8    fis'8    d'8    d'8    fis'8    a'8    \bar "|"     
    d''8 ^"D"   cis''8    d''8      e''8 ^"G"   fis''8    g''8
}
\alternative {
  {    fis''8 ^"A"   d''8    cis''8      d''4 ^"D"   e''8    }
  {     fis''8 ^"A"   d''8    cis''8      d''4. ^"D"   \bar "|."   }
}
}

\score{
    <<

	\context Staff="default"
	{
	    \voicedefault 
	}

    >>
	\layout {
	}
	\midi {}
}
