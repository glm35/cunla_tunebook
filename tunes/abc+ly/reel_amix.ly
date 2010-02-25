\version "2.7.40"
\header {
	crossRefNumber = "1"
	footnotes = ""
	tagline = "Lily was here 2.11.26 -- automatically converted from ABC"
	% et patché à la main par Gwen parce que la conversion de
	% abc2ly, c'est n'importe quoi.
	title = "Reel Amixo"
}
voicedefault =
{
%\set Score.defaultBarType = "empty"

  \time 2/2
  \key a \mixolydian

  \partial 8 fis''8
  \repeat volta 2
  {
    e''8    a'8 cis''8    a'8    e''8    a'8    cis''8    a'8    |
    d''8    cis''8    b'8    g'8    b'8    d''8    cis''8    d''8 |
    e''8    a'8    cis''8    a'8    e''8    a'8    cis''8    a'8 |
  }
  \alternative
  {
    {   fis''16    g''16 a''8    e''8    d''8    cis''8    a'8    a'8    fis''8  |  }
    { fis''16    g''16    a''8    e''8    d''8    cis''8    a'8    a'8    a'8 |  }
  }
  \repeat volta 2 
  {
    e''4.    fis''8    g''8    a''8    g''8    e''8  |
    d''8    cis''8    b'8    g'8    b'8    d''8    cis''8    d''8 |
    e''8    d''8    e''8    fis''8    g''8    a''8    g''8    e''8    |
  }
  \alternative
  {
    {   a''8    e''8    fis''8    d''8    cis''8    a'8    a'8    a'8  |  }
    { a''8    e''8    fis''8    d''8    cis''8    a'8    a'8    fis''8  | }
  }
}

\score
{
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

