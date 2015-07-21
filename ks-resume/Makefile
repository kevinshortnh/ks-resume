#!/usr/bin/env make -f
#
# Makefile for ks-resume
#

# Mac OS X paths
# XALAN_HOME      = /Users/kevinshort/xalan-j_2_7_2
# FOP_HOME        = /Users/kevinshort/fop-1.1

TARGETS         += kevinshort.html
TARGETS         += kevinshort.xml
TARGETS         += kevinshort.pdf
TARGETS         += kevinshort.ps

default: $(TARGETS)

clean:
	$(RM) $(TARGETS)

kevinshort.html: resume.xml resume2xhtml.xsl
	java -classpath $(XALAN_HOME)/xalan.jar org.apache.xalan.xslt.Process -IN resume.xml -XSL resume2xhtml.xsl -OUT kevinshort.html

kevinshort.xml: resume.xml resume2fo.xsl
	java -classpath $(XALAN_HOME)/xalan.jar org.apache.xalan.xslt.Process -IN resume.xml -XSL resume2fo.xsl    -OUT kevinshort.xml

kevinshort.pdf: resume.xml resume2fo.xsl
	sh $(FOP_HOME)/fop -xml resume.xml -xsl resume2fo.xsl -pdf  kevinshort.pdf

kevinshort.ps: resume.xml resume2fo.xsl
	sh $(FOP_HOME)/fop -xml resume.xml -xsl resume2fo.xsl -ps   kevinshort.ps
