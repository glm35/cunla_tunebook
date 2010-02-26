#!/usr/bin/python

import sys
import re
from optparse import OptionParser


# ------------------------------------------------------------------------
# Global variables
# ------------------------------------------------------------------------

tune_dir = "tunes"
out = "out.stage1"


# ------------------------------------------------------------------------
# Data structures
# ------------------------------------------------------------------------

# The list of the tune labels
#
# Necessary to keep an ordored record of the tunes.

labels = []

# The dictionnary of tunes
#
# For each tune identified by its label, it contains the title and the
# type of the tune.
#
# key: label
# value: dictionnary that contains the data for the tune labelled by the
# key:
#    keys: "title", "type"

tunes = {}


# ------------------------------------------------------------------------
# Parse the command line arguments
# ------------------------------------------------------------------------

def parse_command_line():
    parser = OptionParser()
    parser.add_option("-n", "--name", dest="name", default="tunebook",
                      help="set the tunebook name")
    (options, args) = parser.parse_args()
    return (options, args)


# ------------------------------------------------------------------------
# Get the list of tunes
# ------------------------------------------------------------------------

def get_tune_labels(label_file, labels):
    f = open(label_file)
    while True:
        label = f.readline()
        if label == '':
            # reached end of file
            break
        if label[0] == '#':
            continue
        label = label.strip()
        if label:
            labels.append(label)
        # else: emtpy line
    f.close()


# ------------------------------------------------------------------------
# Get the metadata in a tune
# ------------------------------------------------------------------------

def get_tune_metadata(label):
    title, type = None, None

    for ext in (".ly", ".abc"):
        try:
            f = open(tune_dir + "/" + label + ext)
            tune = f.readlines()
            f.close()
            title, type = get_metadata(tune, ext)
            if not title:
                title = "Unnamed"
            break
        except IOError:
            pass
    else:
        sys.stderr.write("Warning: no tune file for label " + label + "\n")
    return title, type


def get_metadata(tune, ext):
    title, type = None, None

    if ext == ".abc":
        title_re = re.compile('^T:(.*)$')
        type_re = re.compile('^R:(.*)$')
    else:
        title_re = re.compile('^\s*title\s*=\s*"(.*)"$')
        type_re = re.compile('^\s*subtitle\s*=\s*"(.*)"$')

    for line in tune:
        if title and type:
            break

        if not title:
            m = title_re.match(line)
            if m:
                title = m.group(1).strip()
                continue

        if not type:
            m = type_re.match(line)
            if m:
                type = m.group(1).strip().lower()
                continue

    return title, type


# ------------------------------------------------------------------------
# Generate a tune
# ------------------------------------------------------------------------

def gen_tune_header(title, type=None):
    #header = ["\n\n\\pagebreak\n", "\\section{" + title, "}\n"]
    #header = ["\n\n", "\\section{" + title, "}\n"]
    #if type != None:
    #    header.insert (2, " (" + type + ")")
    #return "".join(header)
    #header = "\\paragraph{}\n\\begin{figure}[p]\n"
    header = "\\begin{figure}[!]\n"
    return header


def gen_tune_label(label):
    tex_label = ['\\label{', label, '}\n']
    return "".join(tex_label)


def gen_lilypond_block(label):
    block = []
    block.append('\\begin{lilypond}\n')
    #block.append('\\paper {\n')
    #block.append('  bookTitleMarkup = \\markup {\n')
    #block.append('    \\fill-line {\n')
    ## append an empty string to have the composer right aligned:
    #block.append('      ""\n')
    #block.append('      \\fromproperty #\'header:composer\n')
    #block.append('    }\n')
    #block.append('  }\n')
    #block.append('}\n')
    block.append('\\include "' + '../' + out + '/' + label + '.ly' + '"' + "\n")
    block.append('\\end{lilypond}\n')
    block.append('\\end{figure}\n')
    #block.append('\\linebreak\n')
    #block.append('\\clearpage\n')

    return "".join(block)


def gen_tune(label, title, type):
    data = []
    data.append(gen_tune_header(title, type))
    data.append(gen_tune_label(label))
#    try:
#        f = open(tune_dir + "/" + label + ".tex")
#        for line in f:
#            if line.strip() == '\\tune':
#                data.append(gen_lilypond_block(label))
#                continue
#            data.append(line)
#        f.close()
#    except IOError:
#        data.append(gen_lilypond_block(label))
    data.append(gen_lilypond_block(label))
    return data


# ------------------------------------------------------------------------
# Generate the book
# ------------------------------------------------------------------------

def eat_up_template(template, tag=None):
    data = []
    while template:
        line = template.pop(0)
        if (line == tag):
            break
        data.append(line)
    return data


def gen_book_index(tunes):
    data = []
    data.append('\n\n')
    #data.append('\\pagebreak\n')
    data.append('\\section*{Index des suites}\n')

    try:
        f = open(set_file)
    except:
        sys.stderr.write("Warning: Cannot open" + set_file + "\n")
        return []

    for lineno, line in enumerate(f):
        # Each line contains a comma separated list of labels.
        # A line can be empty
        # A line can be a comment starting with #
        line = line.strip()
        if line == '':
            continue
        if line[0] == '#':
            continue
        labels = line.split(',')
        entry = []
        for label in labels:
            label = label.strip()
            if not tunes.has_key(label):
                sys.stderr.write(set_file + ":" + str(lineno+1) + " " +
                                 "Warning: No matching tune for index label " +
                                 label + "\n")
                continue
            tune = []
            tune.append('\emph{' + tunes[label]['title'] + '}')
            if tunes[label]['type'] != None:
                tune.append('~(' + tunes[label]['type'] + ')')
            tune.append(',~p.\\pageref{' + label + '}')
            entry.append("".join(tune))
        data.append('~/ '.join(entry) + "\n")
        data.append('\n')

    f.close()
    return data


def gen_book():
    get_tune_labels(label_file, labels)

    f_template = open(template_file)
    template = f_template.readlines()
    f_template.close()

    f_tunebook = open(tunebook_file, "w")
    f_tunebook.writelines(eat_up_template(template, "%%INSERT_TUNES\n"))
    for label in labels:
        title, type = get_tune_metadata(label)
        if not title:
            continue
        tunes[label] = {'title' : title, 'type' : type}
        f_tunebook.writelines(gen_tune(label, title, type))
    f_tunebook.writelines(eat_up_template(template, "%%INSERT_INDEX\n"))
    f_tunebook.writelines(gen_book_index(tunes))
    f_tunebook.writelines(eat_up_template(template))
    f_tunebook.close()


# ------------------------------------------------------------------------
# Program entry point
# ------------------------------------------------------------------------

(options, args) = parse_command_line()

label_file = "metadata/" + options.name + "-tunes.txt"
set_file = "metadata/" + options.name + "-sets.txt"
template_file = "metadata/" + options.name + "-template.lytex"
tunebook_file = out + "/" + options.name + ".lytex"

gen_book()
