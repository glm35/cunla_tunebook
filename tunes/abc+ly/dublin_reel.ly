\version "2.7.40"
\header {
	crossRefNumber = "1"
	footnotes = ""
	tagline = "Lily was here 2.12.2 -- automatically converted from ABC"
	title = "Dublin reel"
        composer = "Trad."
}
voicedefault =  {
  \time 2/2 \key d \major

  \repeat volta 2 {
    d''8    fis'8    fis'8    fis'8   d''8    fis''8    e''8    cis''8
    d''8    fis'8    fis'8    fis'8   a'8    fis'8    e'8    a'8
  }
  \alternative {
    {
      d''8    fis'8    fis'8    fis'8    d''8    d''8    e''8    d''8
      cis''8    a'8    b'8    fis'8    a'8    fis'8    e'8    a'8
    } {
      b'16    cis''16    d''8    cis''8    e''8    d''8    fis''8    e''8    d''8
      cis''8    a'8    b'8    fis'8    a'8    fis'8    d''8    fis''8
    }
  }

  \repeat volta 2 {
    e''8    a'8    a'8    a'8    e''8    a'8    fis''8    a'8
    e''8    a'8    a'8    a'8    b'8    b'8    fis'8    a'8
  }
  \alternative {
    {
      e''8    a'8    a'8    a'8    e''8    g''8    fis''8    e''8
      d''8    b'8    cis''8    a'8    b'8    b'8    fis'8    a'8
    } {
      e''8    e''8    e''8    ees''8    e''!8    g''8    fis''8    e''8
      d''8    b'8    cis''8    a'8    b'8    b'8    fis'8    a'8
    }
  }

  \repeat volta 2 {
    b'16    cis''16    d''8    cis''8    e''8    d''8    fis'8    fis'8    fis'8
    d''8    e''8    d''8    b'8    a'8    d'8    fis'8    g'8
  }
  \alternative {
    {
      a'4    d''8    cis''8    d''8    fis''8    e''8    d''8
      cis''16    b'16  a'8    b'8    fis'8    a'8    fis'8    e'8    a'8
    } {
      a'4    d''8    fis''8    e''8    e''8    a''8    g''8
      fis''8    d''8    b'8    cis''8    d''8    g''8    fis''8    e''8
    }
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
