#!/usr/bin/perl -w

use strict;

my $SRC = "src";
my $OUT = "out.stage1";
my $TARGET = "$OUT/testbook.tex";
my $TEMPLATE = "tools/testbook_template.tex";

my $TEMPLATE_INSERT_TUNES = '%%INSERT_TUNES';
my $TEX_TUNE_TAG = '\\\tune';

my $debug = 0;

#
# Get the list of source files (.abc files in SRC)
#

my @src_files;

opendir DSRC, $SRC or die ("Error: cannot open $SRC");
@src_files = sort grep /^.*\.(abc$)/, readdir DSRC;
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
  open $src_fh, "${SRC}/${src_file}" or die "Error: Cannot open $src_file in $SRC";

  # Get and write the test title
  my $title = "untitled";

  while (my $line = <$src_fh>)
  {
    if ($line =~ /^T:(.*$)/)
    {
      $title = $1;
      last;
    }
  }
  print "$src_file: titre=$title\n" if ($debug);
  print $target_fh "\n\n" . '\section{' . $title . '}' . "\n";

  close $src_fh;

  # Write the contents of the ABC file
  my $abc_fh;
  open $abc_fh, "${SRC}/$src_file" or die "Error: cannot open $src_file in $SRC";
  print $target_fh '\begin{verbatim}' . "\n";
  while (my $line = <$abc_fh>)
  {
    print $target_fh $line;
  }
  print $target_fh '\end{verbatim}' . "\n";
  close $abc_fh;

  # Build and write the lilypond block (disable the tune header)
  my $lilyfile = $src_file;
  $lilyfile =~ s/\.abc/\.ly/;
  my $lilytag;
  $lilytag  = '\begin{lilypond}' . "\n";
  $lilytag .= '\paper {' . "\n";
  $lilytag .= '  bookTitleMarkup = \markup {' . "\n";
#  $lilytag .= '    \fill-line {' . "\n";
#  $lilytag .= '      \fromproperty #' . "'header:composer" . "\n";
#  $lilytag .= '    }' . "\n";
  $lilytag .= '  }' . "\n";
  $lilytag .= '}' . "\n";
  $lilytag .= '\include "' . "../" . $OUT . '/' . $lilyfile . '"' . "\n";
  $lilytag .= '\end{lilypond}' . "\n";
  print "lilytag: $lilytag" if ($debug);
  print $target_fh $lilytag;
}

# Write the template footer

while (my $line = <$template_fh>)
{
  print $target_fh $line;
}

close $target_fh;
close $template_fh;
