LILY_PREFIX=/opt/bin
LILYPOND_BOOK=${LILY_PREFIX}/lilypond-book
#ABC2LY=${LILY_PREFIX}/abc2ly
ABC2LY=${LILY_PREFIX}/abc2ly-glm
CONVERT_LY=${LILY_PREFIX}/convert-ly

target = testbook
stage1_outdir = out.stage1
stage2_outdir = out.stage2
src = src

lyfiles := $(patsubst ${src}/%.abc,${stage1_outdir}/%.ly,$(wildcard ${src}/*.abc))

${stage2_outdir}/$(target).dvi : ${stage1_outdir} ${stage2_outdir} ${stage2_outdir}/${target}.tex
	@echo [LATEX] ${target}.tex
	@cd ${stage2_outdir} && latex ${target}.tex > latex.log

${stage2_outdir}/${target}.tex : ${stage1_outdir}/${target}.tex
	@echo [LILYPOND-BOOK `${LILYPOND_BOOK} --version`] ${stage1_outdir}/${target}.tex
	@cd ${stage2_outdir} && ${LILYPOND_BOOK} ../${stage1_outdir}/${target}.tex &>lilypond-book.log

${stage1_outdir}/%.ly : ${src}/%.abc
	@echo [ABC2LY] $<
	@${ABC2LY} -o $@ $< 2>${stage1_outdir}/abc2ly.log
	@cat ${stage1_outdir}/abc2ly.log |grep Warning |grep -v "Q specification" || true
	@! (cat ${stage1_outdir}/abc2ly.log |grep "Huh?  Don't understand" )
# Note:
# - split into two commands to be able to filter abc2ly output without losing
# the return code
# - we display warnings without stopping
# - we abort in case of "Huh?  Don't understand" messages

${stage1_outdir}/${target}.tex: ${lyfiles} ./tools/testbook_template.tex ./tools/make_testbook.pl
	@echo [MAKE_TESTBOOK]
	@tools/make_testbook.pl

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

clean :
	@echo [CLEANING]
	@-rm -rf ${stage1_outdir}
	@-rm -rf ${stage2_outdir}
	@-rm -f src/*.mid
	@-rm -f *~
	@-rm -f src/*~
	@-rm -f doc/*~

help:
	@echo "Targets to build the testbook:"
	@echo "        default: dvi format"
	@echo "        ps: Postcript format"
	@echo "        pdf: pdf format (broken output: use ps)"
	@echo "Other targets:"
	@echo "        view: view the book in dvi format"
	@echo "        viewps: view the book in PostScript format"
	@echo "        clean: remove all the generated files"
