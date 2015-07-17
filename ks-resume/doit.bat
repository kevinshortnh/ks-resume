@REM 03/16/2008 Using fop-0.94 and xsltj from WinXP (DOS Shell)
@REM ---------------------------------------------------------------------------
@REM Good output formats
@REM
java -classpath %XALAN_HOME%\xalan.jar org.apache.xalan.xslt.Process -IN resume.xml -XSL resume2xhtml.xsl -OUT kevinshort.html
java -classpath %XALAN_HOME%\xalan.jar org.apache.xalan.xslt.Process -IN resume.xml -XSL resume2fo.xsl    -OUT kevinshort.xml
call %FOP_HOME%\fop.bat -xml resume.xml -xsl resume2fo.xsl -pdf  kevinshort.pdf
call %FOP_HOME%\fop.bat -xml resume.xml -xsl resume2fo.xsl -ps   kevinshort.ps
@REM
@REM ---------------------------------------------------------------------------
@REM Ugly
@REM %FOP_HOME%\fop.bat -xml resume.xml -xsl resume2fo.xsl -txt kevinshort.txt
@REM %FOP_HOME%\fop.bat -xml resume.xml -xsl resume2fo.xsl -rtf  kevinshort.rtf
@REM %FOP_HOME%\fop.bat -xml resume.xml -xsl resume2fo.xsl -png  kevinshort.png
@REM %FOP_HOME%\fop.bat -xml resume.xml -xsl resume2fo.xsl -tiff kevinshort.tiff
@REM ---------------------------------------------------------------------------
@REM These require fop_sandbox.jar
@REM %FOP_HOME%\fop.bat -xml resume.xml -xsl resume2fo.xsl -mif kevinshort.mif
@REM %FOP_HOME%\fop.bat -xml resume.xml -xsl resume2fo.xsl -svg  kevinshort.svg
@REM ---------------------------------------------------------------------------
@REM Viewable qwith Microsoft SwiftView
@REM %FOP_HOME%\fop.bat -xml resume.xml -xsl resume2fo.xsl -pcl kevinshort.pcl
@REM ---------------------------------------------------------------------------
