#!/usr/bin/perl -w

use strict;

my $SRC = "./src";
my $OUT = "./out.stage1";
my $TARGET = "$OUT/tunebook.tex";
my $TEMPLATE = "$SRC/TunebookTemplate.tex";
my $SET_LIST = "$SRC/SetList.txt";

my $TEMPLATE_INSERT_TUNES = '%%INSERT_TUNES';
my $TEX_TUNE_TAG = '\\\tune';

my $debug = 0;

# Hash with all the tunes
#
# key = basename (name of the tune file without extension)
#
# value = reference to a hash
#    keys =
#           "title": tune title (Crock of gold, ...)
#           "type": "reel", "jig", ..., "unnamed" (lower case)

my %tunes;

#
# Get the list of source files (.abc and .ly files in SRC)
#

my @src_files;

opendir DSRC, $SRC or die ("Error: cannot open $SRC");
@src_files = sort grep /^.*\.(abc$)|(ly$)/, readdir DSRC;
closedir DSRC;

if ($debug)
{
  print "source files list:\n";
  foreach my $file (@src_files)
  {
    print "  ", $file, "\n";
  }
}


# Write the template header

my $template_fh;
my $target_fh;

open $template_fh, $TEMPLATE or die ("Error: cannot open $TEMPLATE");

open $target_fh, ">$TARGET" or die ("Error: cannot open $TARGET for writing");

while (my $line = <$template_fh>)
{
  if ($line =~ $TEMPLATE_INSERT_TUNES)
  {
    last;
  }
  else
  {
    print $target_fh $line;
  }
}


# Process each source file

my $src_fh;
my $basename;

SRC_FILE: foreach my $src_file (@src_files)
{
  # If it is a abc file, and if there is a lilypond file with the same
  # basename, skip the abc file

  if ($src_file =~ /^(.*)\.abc$/)
  {
    $basename = $1;
    print "basename for $src_file: $basename\n" if ($debug);
    foreach my $tmp_file (@src_files)
    {
      if ($tmp_file =~ /^(.*)\.ly$/)
      {
        my $ly_basename = $1;
        print "basename for $tmp_file: $ly_basename\n" if ($debug);
        if ($ly_basename eq $basename)
        {
          print "Skipping $src_file ($tmp_file is prioritary)\n";
          next SRC_FILE;
        }
      }
    }
  }

  open $src_fh, "$SRC/$src_file" or die "Error: Cannot open $src_file in $SRC";

  # Get the song title, discography and type
  my $title = "untitled";
  my @discography = ();
  my $type = "undefined";

  if ($src_file =~ /^(.*)\.abc$/) # ABC file
  {
    while (my $line = <$src_fh>)
    {
      if ($line =~ /^T:(.*$)/)
      {
        $title = $1;
      }
      elsif ($line =~ /^D:(.*$)/)
      {
        push @discography, $1;
      }
      elsif ($line =~ /^R:(.*$)/)
      {
        $type = $1;
      }
    }
  }
  elsif ($src_file =~ /^(.*)\.ly$/)
  {
    $basename = $1;
    while (my $line = <$src_fh>)
    {
      if ($line =~ /^[\s]*title[\s]*=[\s]*"(.*)"$/)
      {
        $title = $1;
        print "ly title found: $title\n" if ($debug);
      }
      elsif ($line =~ /^[\s]*subtitle[\s]*=[\s]*"(.*)"$/)
      {
        $type = $1;
        print "ly subtitle found: $type\n" if ($debug);
      }
      #TODO: manage discography as %discography comment
    }
  }
  else
  {
    print "Error: source file with unknown type found ($src_file)\n";
    exit (1);
  }

  print "$src_file: titre=$title, disco=@discography, type=$type\n" if ($debug);

  # Write the song header

  print $target_fh "\n\n" . '\pagebreak' . "\n" ;
  print $target_fh '\section{' . $title;
  print $target_fh " (" . $type . ")" if ($type ne "undefined");
  print $target_fh '}' . "\n";

  # Write a label for cross-reference in the index

  print $target_fh '\label{' . $basename . '}' . "\n";

  # Include the lilypond file

  my $lilyfile = $src_file;
  $lilyfile =~ s/\.abc/\.ly/; # substitution not needed for .ly source files

  # since lilypond 2.10.8 (maybe earlier)
  my $lilytag;
  $lilytag  = '\begin{lilypond}' . "\n";
  #$lilytag .= '\paper{bookTitleMarkup=##f scoreTitleMarkup=##f }' . "\n";

  $lilytag .= '\paper {' . "\n";
  $lilytag .= '  bookTitleMarkup = \markup {' . "\n";
  $lilytag .= '    \fill-line {' . "\n";
  $lilytag .= '      ""' . "\n"; # empty string to have the composer right aligned
  $lilytag .= '      \fromproperty #' . "'header:composer" . "\n";
  $lilytag .= '    }' . "\n";
  $lilytag .= '  }' . "\n";
  $lilytag .= '}' . "\n";

  $lilytag .= '\include "' . '../' . $OUT . '/' . $lilyfile . '"' . "\n";
  $lilytag .= '\end{lilypond}' . "\n";

  #my $lilytag = '\lilypondfile[20pt]{';
  #my $lilytag = '\lilypondfile[staffsize=20]{'; # since lilypond 2.2.6

  #$lilytag .= '../' . $OUT . '/' . $lilyfile . '}' . "\n";

  print "lilytag: $lilytag" if ($debug);

  # If there is no .tex file associated to the .abc file,
  #   Warn and write the \lilypondfile tag
  # Else write the .tex file

  my $texfile = $src_file;
  $texfile =~ s/\.abc/\.tex/;
  $texfile =~ s/\.ly/\.tex/;
  $texfile = $SRC . '/' . $texfile;

  if (not -e $texfile)
  {
    print $target_fh $lilytag;
  }
  else
  {
    my $tex_fh;
    my $found_tune_tag = 0;

    open $tex_fh, $texfile or die "Error: cannot open $texfile";
    while (my $line = <$tex_fh>)
    {
      if ($line =~ /$TEX_TUNE_TAG/)
      {
#        print "Found tune tag in $texfile\n";
        if ($found_tune_tag)
        {
          print "Warning: $texfile contains more than one tune tag\n";
        }
        else
        {
          $line =~ s/$TEX_TUNE_TAG/$lilytag/;
          $found_tune_tag = 1;
        }
      }
      print $target_fh $line;
    }
    close $tex_fh;

    if (not $found_tune_tag)
    {
      print "Warning: tune tag not found in $texfile\n";
      print $target_fh $lilytag;
    }
  }

  close $src_fh;

  # Add an entry for the tune in the tunes hash
  {
    my %tune;
    $tune{"title"} = $title;
    $tune{"type"} = $type;
    $tunes{$basename} = \%tune;
    print "Addded $basename\n" if ($debug);
  }
}

print "Tune list:\n" if ($debug);
foreach my $basename (keys %tunes) {
  my $title = $tunes{$basename}->{"title"};
  my $type = $tunes{$basename}->{"type"};
  print "$basename: $title ($type)\n" if ($debug);
}


# Write the index of sets
# TODO: use the section number instead of pageref

my $set_fh;
open $set_fh, $SET_LIST or die "Error: cannot open $SET_LIST";

print $target_fh "\n\n" . '\pagebreak' . "\n";
print $target_fh '\section*{Index des suites}' . "\n";

my $lineno=0;
while (my $line = <$set_fh>) {
  $lineno++;
  next if ($line =~ m/^[\s]*#/); # ignore comments
  next if ($line =~ m/^[\s]*$/); # ignore empty lines
  $line =~ s/^[\s]*//; # remove leading white spaces
  $line =~ s/[\s]*$//; # remove trailing white spaces (should remove the newline char)
  my @basenames = split /[\s]*,[\s]*/, $line;
  my $i = 0;
  foreach my $basename (@basenames) {
    $i++;
    if (defined $tunes{$basename}) {
      my $tune = $tunes{$basename};
      if ($i != 1) {
        print $target_fh "~/ ";
      }
      print $target_fh '\emph{' . "$tune->{\"title\"}" . '}' . "~($tune->{\"type\"},~p.\\pageref{$basename})";
      $i++;
    }
    else {
      print "Warning ($SET_LIST:$lineno): unknown tune label $basename\n";
    }
  }
  if ($i == 0) {
    print "Warning ($SET_LIST:$lineno): syntax error\n";
  }
  else {
    print $target_fh "\n\n";
  }
}

close $set_fh;



# Write the template footer

while (my $line = <$template_fh>)
{
  print $target_fh $line;
}

close $target_fh;
close $template_fh;
