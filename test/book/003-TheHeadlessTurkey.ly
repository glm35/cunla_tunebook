\version "2.7.40"
\header {
	crossRefNumber = "1"
	footnotes = ""
	subtitle = "The Boys in the Gap (The Swallow) - Emily Hawkes (18/Oct/2001)"
	tagline = "Lily was here 2.11.26 -- automatically converted from ABC"
	title = "The Headless Turkey"
	composer = "Trad."
}
voicedefault =  {
\set Score.defaultBarType = "empty"

\time 6/8 \key g \major   \repeat volta 2 {   e'8    a'8    g'8    a'4    b'8   
 \bar "|"   c''8    a'8    b'8    c''8    a'8    g'8    \bar "|"   e'4    e'8   
 g'8    fis'8    g'8    \bar "|"   e'8    g'8    e'8    g'8    fis'8    d'8    
\bar "|"       e'8    a'8    g'8    a'4    b'8    \bar "|"   c''8    a'8    b'8 
   c''8    d''8    e''8    \bar "|"   g''8    g''8    g''8    e''8    g''8    
e''8    \bar "|"   d''8    b'8    g'8    a'4.    }     \repeat volta 2 {   a''8 
   e''8    a''8    a''8    e''8    a''8    \bar "|"   g''8    d''8    g''8    
g''8    d''8    g''8    \bar "|"   a''4    a''8    a''8    e''8    fis''8    
\bar "|"   g''8    fis''8    e''8    d''8    e''8    fis''8    \bar "|"       
g''8    g''8    g''8    fis''8    g''8    fis''8    \bar "|"   e''8    d''8    
b'8    g'8    b'8    d''8    \bar "|"   g''4    g''8    e''8    g''8    e''8    
\bar "|"   d''8    b'8    g'8    a'4.    }   
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
