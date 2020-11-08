#!/usr/bin/env make -f
#
# Makefile for ks-resume
#

# Mac OS X paths
BASE_DIR        = /Users/kevinsho
XALAN_HOME      = $(BASE_DIR)/xalan-j_2_7_2
FOP_HOME        = $(BASE_DIR)/fop-2.5/fop
FOP_HOME        = $(BASE_DIR)/fop-2.1
XERCES_HOME     = $(BASE_DIR)/xerces-2_12_1

INPUTS		+= resume.xml

TARGETS         += kevinshort.html
TARGETS         += kevinshort.xml
TARGETS         += kevinshort.pdf
TARGETS         += kevinshort.ps

default: $(TARGETS)

clean:
	$(RM) $(TARGETS)
	$(RM) *.bak
	$(RM) xmllint.out

kevinshort.html: resume.xml resume2xhtml.xsl
	java -classpath $(XALAN_HOME)/xalan.jar org.apache.xalan.xslt.Process -IN resume.xml -XSL resume2xhtml.xsl -OUT kevinshort.html

kevinshort.xml: resume.xml resume2fo.xsl
	java -classpath $(XALAN_HOME)/xalan.jar org.apache.xalan.xslt.Process -IN resume.xml -XSL resume2fo.xsl    -OUT kevinshort.xml

kevinshort.pdf: resume.xml resume2fo.xsl
	sh $(FOP_HOME)/fop -xml resume.xml -xsl resume2fo.xsl -pdf  kevinshort.pdf

kevinshort.ps: resume.xml resume2fo.xsl
	sh $(FOP_HOME)/fop -xml resume.xml -xsl resume2fo.xsl -ps   kevinshort.ps

spell: FORCE
	for i in $(INPUTS); do aspell --lang=en --mode=html check $$i;done

passive: FORCE
	-for i in is are was were be been; do fgrep -w $$i $(INPUTS);done

lint xmllint:
	xmllint --format - < $(INPUTS) > xmllint.out

open: $(TARGETS)
	open kevinshort.pdf
FORCE:
