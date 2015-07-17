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
    <xsl:import href="resume_common.xsl"/>
    <xsl:output method="html" encoding="ISO-8859-1"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="showTerse" select="0"/>
    <xsl:param name="showSupv" select="0"/>
    <xsl:param name="showTech" select="1"/>
    <xsl:param name="showSkills" select="1"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="resume">
        <html>
            <head>
                <title>
                    <xsl:apply-templates select="contact_info" mode="head"/>
                </title>
                <!--<link href="http://www.oxmicro.com/ks-resume/kevinshort.css" type="text/css" rel="stylesheet"/>-->
                <link href="kevinshort.css" type="text/css" rel="stylesheet"/>
            </head>
            <body>
                <xsl:apply-templates select="contact_info" mode="body"/>
                <xsl:apply-templates select="objectives"/>
                <xsl:apply-templates select="overview"/>
                <xsl:apply-templates select="highlights"/>
                <!--<xsl:apply-templates select="skills" mode="current-skills"/>-->
                <xsl:apply-templates select="experience"/>
                <xsl:apply-templates select="independent_study"/>
                <!--<xsl:apply-templates select="skills" mode="old-skills"/>-->
                <xsl:apply-templates select="education"/>
                <xsl:apply-templates select="certifications"/>
                <xsl:apply-templates select="patents"/>
                <xsl:apply-templates select="associations"/>
                <xsl:apply-templates select="seminars"/>
                <xsl:apply-templates select="awards"/>
                <xsl:apply-templates select="skills" mode="any-skills"/>
                <p/>
                <hr/>
                <div class="note">
                    <xsl:value-of
                        select="concat(                         'Resume of ',             /resume/contact_info/@first,             ' ',             /resume/contact_info/@middle,             '. ',             /resume/contact_info/@last)"/>
                    <xsl:text>, dated </xsl:text>
                    <xsl:value-of select="/resume/@date"/>
                    <xsl:text>, generated using XML &amp; XSLT.</xsl:text>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="ContactInfoHead" match="contact_info" mode="head">
        <xsl:value-of select="concat('Resume of: ',@first,' ',@middle,'. ', @last)"/>
    </xsl:template>

    <xsl:template name="ContactInfoBody" match="contact_info" mode="body">
        <div class="contact_name">
            <xsl:apply-templates select="image"/>
            <xsl:value-of
                select="translate(         concat(@first, ' ', @middle, '. ', @last),         'abcdefghijklmnopqrstuvwxyz',         'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"
            />
        </div>
        <div class="contact_other">
            <xsl:value-of
                select="concat(         street,         ', ',         city,         ', ',         state,         ' ',         zip, ' &#149; ',         'Cell: ',         cell)"
            />
        </div>
        <div class="contact_other">
            <xsl:text>Email: </xsl:text>
            <a href="{concat('mailto:', email)}">
                <xsl:value-of select="email"/>
            </a>
            <xsl:text> &#149; </xsl:text>
            <xsl:text>URL: </xsl:text>
            <a href="{website}">
                <xsl:value-of select="website"/>
            </a>
        </div>
    </xsl:template>

    <xsl:template match="objectives">
        <div class="group_header"> PROFESSIONAL OBJECTIVE </div>
        <div class="text">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="overview">
        <div class="group_header"> BACKGROUND SUMMARY </div>
        <div class="text">
            <xsl:apply-templates select="overview_item"/>
        </div>
    </xsl:template>

    <xsl:template match="highlights">
        <div class="group_header"> BACKGROUND HIGHLIGHTS </div>
        <div class="text">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template name="ProcessOverviewItem" match="overview_item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template name="CurrentSkills" match="skills" mode="current-skills">
        <div class="group_header">
            <xsl:text>TECHNICAL SKILL HIGHLIGHTS</xsl:text>
        </div>
        <xsl:for-each select="./skill_category">
            <xsl:call-template name="ProcessSkillCategory">
                <xsl:with-param name="mode">current-skills</xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="OldSkills" match="skills" mode="old-skills">
        <div class="group_header">
            <xsl:text>OTHER TECHNICAL SKILLS</xsl:text>
        </div>
        <xsl:for-each select="./skill_category">
            <xsl:call-template name="ProcessSkillCategory">
                <xsl:with-param name="mode">old-skills</xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="AnySkills" match="skills" mode="any-skills">
        <div class="group_header">
            <xsl:text>TECHNICAL SKILLS</xsl:text>
        </div>
        <xsl:for-each select="./skill_category">
            <xsl:call-template name="ProcessSkillCategory">
                <xsl:with-param name="mode">any-skills</xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="ProcessSkillCategory">
        <xsl:param name="list"/>
        <xsl:param name="mode"/>
        <xsl:variable name="skillset">
            <xsl:call-template name="ProcessSkill">
                <xsl:with-param name="list" select="./skill"/>
                <xsl:with-param name="mode" select="$mode"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:if test="string-length($skillset) &gt; 0">
            <div class="skill_outer_box">
                <div class="skill_column_one">
                    <xsl:value-of select="concat(@name, ': ')"/>
                </div>
                <div class="skill_column_two">
                    <xsl:value-of select="$skillset"/>
                    <xsl:text>.</xsl:text>
                </div>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="experience">
        <div class="group_header_no_space_after"> PROFESSIONAL EXPERIENCE </div>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="independent_study">
        <div class="group_header_no_space_after"> INDEPENDENT STUDY </div>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template name="ObjectiveSupv" match="objectiveSupv">
        <xsl:if test="$showSupv">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="ObjectiveTech" match="objectiveTech">
        <xsl:if test="$showTech">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="ObjectiveAll" match="objectiveAll">
        <p/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="period">
        <div class="simple">
            <xsl:apply-templates select="assignment[1]"/>
        </div>
        <xsl:apply-templates select="assignment[position() != 1]|tasks"/>
    </xsl:template>

    <xsl:template match="assignment">
        <div class="simple">
            <div class="exp_column_two_assignment">
                <div class="note">
                    <xsl:call-template name="note">
                        <xsl:with-param name="note" select="institution/@note"/>
                    </xsl:call-template>
                </div>
                <xsl:apply-templates select="position"/>
                <xsl:text>: </xsl:text>
                <xsl:choose>
                    <xsl:when test="url">
                        <a href="{url}" target="_blank">
                            <xsl:value-of select="institution"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="institution"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="concat(', ', location, '.')"/>
                <xsl:text> (</xsl:text>
                <xsl:choose>
                    <xsl:when test="ancestor::period/@start_month">
                        <xsl:call-template name="monthNumToString">
                            <xsl:with-param name="monthNum" select="ancestor::period/@start_month"/>
                        </xsl:call-template>
                        <xsl:number format=" 1111" value="ancestor::period/@start_year"/>
                        <xsl:text> &#8211; </xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="ancestor::period/@end_month">
                        <xsl:call-template name="monthNumToString">
                            <xsl:with-param name="monthNum" select="ancestor::period/@end_month"/>
                        </xsl:call-template>
                        <xsl:number format=" 1111" value="ancestor::period/@end_year"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Present</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>)</xsl:text>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="position">
        <xsl:value-of select="@title"/>
    </xsl:template>

    <xsl:template match="tasks">
        <div class="exp_column_two_task">
            <ul>
                <xsl:apply-templates select="taskTerse"/>
                <xsl:apply-templates select="taskSupv"/>
                <xsl:apply-templates select="taskTech"/>
                <xsl:apply-templates select="taskSkills"/>
            </ul>
        </div>
    </xsl:template>

    <xsl:template name="ProcessTaskTerse" match="taskTerse">
        <xsl:if test="$showTerse">
            <li>
                <xsl:apply-templates/>
            </li>
        </xsl:if>
    </xsl:template>

    <xsl:template name="ProcessTaskSupv" match="taskSupv">
        <xsl:if test="$showSupv">
            <li>
                <xsl:apply-templates/>
            </li>
        </xsl:if>
    </xsl:template>

    <xsl:template name="ProcessTaskTech" match="taskTech">
        <!--<xsl:if test="$showTech">-->
        <li>
            <xsl:apply-templates/>
        </li>
        <!--</xsl:if>-->
    </xsl:template>

    <xsl:template name="ProcessTaskSkills" match="taskSkills">
        <xsl:if test="$showSkills">
            <li>
                <i>
                    <xsl:apply-templates/>
                </i>
            </li>
        </xsl:if>
    </xsl:template>

    <xsl:template match="link">
        <a href="{@url}" target="_blank">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>

    <xsl:template match="image">
        <div class="note">
            <img src="{@url}"/>
        </div>
    </xsl:template>

    <xsl:template match="education">
        <div class="group_header_no_space_after"> EDUCATION </div>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="certifications">
        <div class="group_header"> PROFESSIONAL CERTIFICATION </div>
        <div class="text">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="patents">
        <div class="group_header"> PATENTS </div>
        <div class="text">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="associations">
        <div class="group_header"> PROFESSIONAL ASSOCIATIONS </div>
        <div class="text">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="seminars">
        <div class="group_header"> TECHNICAL SEMINARS </div>
        <div class="text">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="awards">
        <div class="group_header"> HONORS AND AWARDS </div>
        <div class="text">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

</xsl:stylesheet>
