\version "2.7.40"
\header {
	composer = "Trad."
	crossRefNumber = "1"
	footnotes = ""
	tagline = "Lily was here 2.12.2 -- automatically converted from ABC"
	title = "The Lark on the Strand"
}
voicedefault =  {
\time 6/8 \key d \major
\repeat volta 2 {
  e'4.    e'8    d'8    e'8 | fis'8    d'8    b8    d'4. |
  e'8    fis'8    e'8    d'8  fis'8    a'8    | b'4    b'8    b'8    a'8    fis'8 |
  e'4.    e'8    d'8    e'8  | fis'8    d'8    b8    d'4. |
  e'8    fis'8    e'8    d'4    fis'8
}
\alternative {
  {   a'8    fis'8    d'8   fis'4    d'8    }
  {   a'8    fis'8    d'8    fis'4    e'8   }
}
\repeat volta 2 {
  d'8    fis'8    d'8    d''4    d'8  | d''8  fis''8    e''8    d''8    a'8    fis'8    |
  d'8    fis'8    d'8    d''4    a'8  | b'4    b'8    b'8    a'8    fis'8    |
  d'8    fis'8    d'8    d''4    d'8  | d''8    fis''8    e''8    d''8  cis''8    d''8    |
  e''4    e''8    e''8    d''8    a'8   | b'4    b'8    b'8    a'8    fis'8
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
