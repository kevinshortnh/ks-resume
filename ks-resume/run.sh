#!/usr/bin/env bash

set -x

export XALAN_HOME="/Users/kevinshort/xalan-j_2_7_2"
java -classpath ${XALAN_HOME}/xalan.jar org.apache.xalan.xslt.Process -IN resume.xml -XSL resume2xhtml.xsl -OUT kevinshort.html
java -classpath ${XALAN_HOME}/xalan.jar org.apache.xalan.xslt.Process -IN resume.xml -XSL resume2fo.xsl    -OUT kevinshort.xml

export FOP_HOME="/Users/kevinshort/fop-1.1"
${FOP_HOME}/fop -xml resume.xml -xsl resume2fo.xsl -pdf  kevinshort.pdf
${FOP_HOME}/fop -xml resume.xml -xsl resume2fo.xsl -ps   kevinshort.ps

exit 0

@REM
@REM ---------------------------------------------------------------------------
@REM Ugly
@REM %FOP_HOME%/fop.bat -xml resume.xml -xsl resume2fo.xsl -txt kevinshort.txt
@REM %FOP_HOME%/fop.bat -xml resume.xml -xsl resume2fo.xsl -rtf  kevinshort.rtf
@REM %FOP_HOME%/fop.bat -xml resume.xml -xsl resume2fo.xsl -png  kevinshort.png
@REM %FOP_HOME%/fop.bat -xml resume.xml -xsl resume2fo.xsl -tiff kevinshort.tiff
@REM ---------------------------------------------------------------------------
@REM These require fop_sandbox.jar
@REM %FOP_HOME%/fop.bat -xml resume.xml -xsl resume2fo.xsl -mif kevinshort.mif
@REM %FOP_HOME%/fop.bat -xml resume.xml -xsl resume2fo.xsl -svg  kevinshort.svg
@REM ---------------------------------------------------------------------------
@REM Viewable qwith Microsoft SwiftView
@REM %FOP_HOME%/fop.bat -xml resume.xml -xsl resume2fo.xsl -pcl kevinshort.pcl
@REM ---------------------------------------------------------------------------
