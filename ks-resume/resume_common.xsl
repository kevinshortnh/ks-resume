<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet  [
<!ENTITY nbsp   "&#160;">
<!ENTITY copy   "&#169;">
<!ENTITY reg    "&#174;">
<!ENTITY trade  "&#8482;">
<!ENTITY mdash  "&#8212;">
<!ENTITY ldquo  "&#8220;">
<!ENTITY rdquo  "&#8221;">
<!ENTITY pound  "&#163;">
<!ENTITY euro   "&#8364;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:variable name="current-year" select="2010"/>
    <xsl:variable name="current-limit" select="5"/>
    <xsl:template name="ProcessSkill">
        <xsl:param name="list"/>
        <xsl:param name="mode"/>
        <xsl:if test="$list">
            <xsl:variable name="first">
                <xsl:choose>
                    <xsl:when test="$mode = 'current-skills'">
                        <xsl:apply-templates select="$list[1]" mode="current-skills"/>
                    </xsl:when>
                    <xsl:when test="$mode = 'old-skills'">
                        <xsl:apply-templates select="$list[1]" mode="old-skills"/>
                    </xsl:when>
                    <xsl:when test="$mode = 'any-skills'">
                        <xsl:apply-templates select="$list[1]" mode="any-skills"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>[BAD MODE}</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="rest">
                <xsl:call-template name="ProcessSkill">
                    <xsl:with-param name="list" select="$list[position() != 1]"/>
                    <xsl:with-param name="mode" select="$mode"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="expr1" select="string-length($first) &gt; 0"/>
            <xsl:variable name="expr2" select="string-length($rest) &gt; 0"/>
            <xsl:if test="$expr1">
                <xsl:value-of select="$first"/>
            </xsl:if>
            <xsl:if test="$expr1 and $expr2">
                <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:if test="$expr2">
                <xsl:value-of select="$rest"/>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template name="CurrentSkill" match="skill" mode="current-skills">
        <xsl:variable name="expr1" select="@force = 'current'"/>
        <xsl:variable name="expr2a" select="$current-year - @last_used &lt; $current-limit"/>
        <xsl:variable name="expr2b" select="not(@force = 'old')"/>
        <xsl:variable name="expr2" select="$expr2a and $expr2b"/>
        <xsl:if test="$expr1 or $expr2">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="AnySkill" match="skill" mode="any-skills">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template name="OldSkill" match="skill" mode="old-skills">
        <xsl:variable name="expr1" select="@force = 'old'"/>
        <xsl:variable name="expr2" select="$current-year - @last_used &gt;= $current-limit"/>
        <xsl:if test="$expr1 or $expr2">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="highlight[position() != last()]">
        <xsl:value-of select="concat(., '&#160;&#x2022;&#160;')"/>
    </xsl:template>
    <xsl:template match="highlight[position() = last()]">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="certification[position() != last()]">
        <xsl:apply-templates/>
        <xsl:text> &#x2022; </xsl:text>
    </xsl:template>
    <xsl:template match="certification[position() = last()]">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="patent[position() != last()]">
        <xsl:apply-templates/>
        <xsl:text> &#x2022; </xsl:text>
    </xsl:template>
    <xsl:template match="patent[position() = last()]">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="association[position() != last()]">
        <xsl:apply-templates/>
        <xsl:text> &#x2022; </xsl:text>
    </xsl:template>
    <xsl:template match="association[position() = last()]">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="seminar[position() != last()]">
        <xsl:apply-templates/>
        <xsl:text> &#x2022; </xsl:text>
    </xsl:template>
    <xsl:template match="seminar[position() = last()]">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="award">
        <xsl:apply-templates/>
        <xsl:text>.</xsl:text>
    </xsl:template>
    <xsl:template name="note">
        <xsl:param name="note"/>
        <xsl:choose>
            <xsl:when test="string-length($note)=0">
                <xsl:text>&#160;</xsl:text>
            </xsl:when>
            <xsl:when test="string-length(substring-before($note,'&lt;link'))=0">
                <xsl:text>(</xsl:text>
                <xsl:value-of select="$note"/>
                <xsl:text>)</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>(</xsl:text>
                <xsl:value-of
                    select="concat(             substring-before($note,'&lt;link'),             substring-before(substring-after($note,'&gt;'),'&lt;/link&gt;'),             substring-after($note,'&lt;/link&gt;'))"/>
                <xsl:text>)</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="monthNumToString">
        <xsl:param name="monthNum"/>
        <xsl:choose>
            <xsl:when test="$monthNum =  1">
                <xsl:text>Jan</xsl:text>
            </xsl:when>
            <xsl:when test="$monthNum =  2">
                <xsl:text>Feb</xsl:text>
            </xsl:when>
            <xsl:when test="$monthNum =  3">
                <xsl:text>Mar</xsl:text>
            </xsl:when>
            <xsl:when test="$monthNum =  4">
                <xsl:text>Apr</xsl:text>
            </xsl:when>
            <xsl:when test="$monthNum =  5">
                <xsl:text>May</xsl:text>
            </xsl:when>
            <xsl:when test="$monthNum =  6">
                <xsl:text>Jun</xsl:text>
            </xsl:when>
            <xsl:when test="$monthNum =  7">
                <xsl:text>Jul</xsl:text>
            </xsl:when>
            <xsl:when test="$monthNum =  8">
                <xsl:text>Aug</xsl:text>
            </xsl:when>
            <xsl:when test="$monthNum =  9">
                <xsl:text>Sep</xsl:text>
            </xsl:when>
            <xsl:when test="$monthNum = 10">
                <xsl:text>Oct</xsl:text>
            </xsl:when>
            <xsl:when test="$monthNum = 11">
                <xsl:text>Nov</xsl:text>
            </xsl:when>
            <xsl:when test="$monthNum = 12">
                <xsl:text>Dec</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>UNK</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
