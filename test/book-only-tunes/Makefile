SHELL=/bin/bash
# Note: by default, GNU Make uses /bin/sh which is /bin/dash on Debian
# systems, which causes some surprises with the commands. For instance,
# stdout+stderr IO redirection with "&>" does not work with dash.

LILYPOND_BOOK=lilypond-book
ABC2LY=abc4ly.py
#CONVERT_LY=convert-ly

# 2 cibles configurables: "cunla" (uniquement le répertoire cunla) et
# "tunebook" (tout mon répertoire irlandais)
target = cunla
stage1_outdir = out.stage1
stage2_outdir = out.stage2
#src = src
src = tunes

lyfiles := $(patsubst ${src}/%.abc,${stage1_outdir}/%.ly,$(wildcard ${src}/*.abc))
lyfiles2 := $(patsubst ${src}/%.ly,${stage1_outdir}/%.ly,$(wildcard ${src}/*.ly))
texfiles := $(wildcard ${src}/*.tex)

${stage2_outdir}/$(target).dvi : ${stage1_outdir} ${stage2_outdir} ${stage2_outdir}/${target}.tex ${stage2_outdir}/lilypond-book.log
	@echo [LATEX] ${target}.lytex
	@cd ${stage2_outdir} && latex -halt-on-error -interaction=batchmode ${target}.tex > latex1.log
	@cd ${stage2_outdir} && latex -interaction=batchmode ${target}.tex > latex2.log
# Note: we call LaTeX twice to get the cross refs right (index)
# Note 2: we add the dependency to lilypond-book.log because sometimes
# lilypond-book just updates the files included in
# ${stage2_outdir}/${target}.tex. Looking at the log file shows that
# lilypond-book was run and that latex is (probably) to be run again.

${stage2_outdir}/${target}.tex : ${stage1_outdir}/${target}.lytex ${lyfiles} ${lyfiles2}
	@echo [LILYPOND-BOOK `${LILYPOND_BOOK} --version`] -o ${stage2_outdir}/${target}.tex ${stage1_outdir}/${target}.lytex
	cd ${stage2_outdir} && ${LILYPOND_BOOK} ../${stage1_outdir}/${target}.lytex &> lilypond-book.log

${stage1_outdir}/%.ly : ${src}/%.ly
#	@echo [CONVERT-LY] $<
#	@${CONVERT_LY} $< > $@ 2>${stage1_outdir}/convert-ly.log
	@echo [CP] $<
	@cp $< $@
# Note: convert-ly looses the encoding (uses UTF-8?)
# Note: invoking convert-ly does not work when the input version is the same
# as the output version

${stage1_outdir}/%.ly : ${src}/%.abc
	@echo [ABC2LY] $<
	@${ABC2LY} -o $@ $< 2>${stage1_outdir}/abc2ly.log
	@cat ${stage1_outdir}/abc2ly.log |grep Warning |grep -v "Q specification" || true
# Note:
# - split into two commands to be able to filter abc2ly output without losing
# the return code
# - we don't care about grep return code

${stage1_outdir}/${target}.lytex: ${lyfiles} ${lyfiles2} ${texfiles} ./metadata/${target}-template.lytex ./metadata/guitar_chords.tex ./metadata/${target}-sets.txt ./tools/gen-tex-tunebook.py ./metadata/${target}-tunes.txt
	@echo [GEN-TEX-TUNEBOOK]
	@tools/gen-tex-tunebook.py --name ${target}

${stage1_outdir} :
	@echo [MKDIR] ${stage1_outdir}
	@mkdir ${stage1_outdir}

${stage2_outdir} :
	@echo [MKDIR] ${stage2_outdir}
	@mkdir ${stage2_outdir}

ps: ${stage2_outdir}/$(target).ps
# Note: It's better to use PostScript than pdf. As a matter of fact, the #'s
# (sharps) of LilyPond chordnames are lost during the call to dvipdf

${stage2_outdir}/$(target).ps : ${stage2_outdir}/$(target).dvi
	@echo [DVIPS] ${target}.dvi
	@cd ${stage2_outdir} && dvips -o ${target}.ps ${target}.dvi

pdf: ${stage2_outdir}/$(target).pdf

${stage2_outdir}/$(target).pdf : ${stage2_outdir}/$(target).dvi
	@echo [DVIPDF] ${target}.dvi -- NOTE: ps output is preferred
	@cd ${stage2_outdir} && dvipdf ${target}.dvi

view: ${stage2_outdir}/$(target).dvi
	@echo [XDVI] ${stage2_outdir}/$(target).dvi
	@xdvi ${stage2_outdir}/$(target).dvi &

viewps: ${stage2_outdir}/$(target).ps
	@echo [EVINCE] ${stage2_outdir}/$(target).ps
	@evince ${stage2_outdir}/$(target).ps &

# Chord table
table: ${stage2_outdir}/chord_table.dvi

${stage2_outdir}/chord_table.dvi: ${stage2_outdir} metadata/chord_table.tex metadata/guitar_chords.tex
	@echo [LATEX] metadata/chord_table.tex
	@cd ${stage2_outdir} && latex metadata/chord_table.tex

# View chord table
vtable: ${stage2_outdir}/chord_table.dvi
	@echo [XDVI] ${stage2_outdir}/chord_table.dvi
	@xdvi ${stage2_outdir}/chord_table.dvi &

clean :
	@echo [CLEANING]
	@-rm -rf ${stage1_outdir}
	@-rm -rf ${stage2_outdir}
	@-rm -f src/*.mid
	@-rm -f *~
	@-rm -f src/*~
	@-rm -f doc/*~

arch:
	@echo [ARCHIVING]
	@tar cvfj save/${target}-`date "+%Y%m%d-%Hh%M"`.tar.bz2 bugs/* doc/* Makefile src/* tools/*
#	@gzip ${target}-`date "+%Y%m%d-%Hh%M"`.tar
#	@mv *.tar.gz save

arch2:
	@echo [ARCHIVING v2]
	@tar cvfj ../${target}-`date "+%Y%m%d-%Hh%M"`.tar.bz2 ../tunebook --exclude=out*

help:
	@echo "Targets to build the book:"
	@echo "        default: dvi format"
	@echo "        ps: Postcript format"
	@echo "        pdf: pdf format (broken output: use ps)"
	@echo "Other targets:"
	@echo "        view: view the book in dvi format"
	@echo "        viewps: view the book in PostScript format"
	@echo "        table: build the chord table"
	@echo "        vtable: view the chord table"
	@echo "        clean: remove all the generated files"
	@echo "        arch: create an archive with the source and doc files"
	@echo "        arch2: create an archive with all but the out* directories"
