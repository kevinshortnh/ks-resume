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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:import href="resume_common.xsl"/>
    <xsl:output method="xml"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="showTerse" select="0"/>
    <xsl:param name="showSupv" select="0"/>
    <xsl:param name="showTech" select="1"/>
    <xsl:param name="showSkills" select="1"/>
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master page-height="11in" page-width="8.5in" margin-top="0.5in"
                    margin-right="0.5in" margin-bottom="0.75in" margin-left="0.75in"
                    master-name="only">
                    <fo:region-body region-name="xsl-region-body" margin-bottom="0.25in"/>
                    <fo:region-after region-name="xsl-region-after" extent="0.25in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="only">
                <fo:static-content flow-name="xsl-region-after" xsl:use-attribute-sets="font">
                    <fo:block border-before-style="solid" border-before-width="0.1mm"
                        padding-before="0.5em" padding-start="1em" padding-end="1em"
                        font-family="sans-serif" font-size="8pt" font-style="normal">
                        <fo:list-block>
                            <fo:list-item>
                                <fo:list-item-label>
                                    <fo:block text-align="left">
                                        <xsl:value-of
                                            select="concat(                         'Resume of ',                         /resume/contact_info/@first,                         ' ',                         /resume/contact_info/@middle,                         '. ',                         /resume/contact_info/@last)"/>
                                        <xsl:text>, dated </xsl:text>
                                        <xsl:value-of select="/resume/@date"/>
                                        <xsl:text>, generated using XML, XSLT &amp; XSL-FO.</xsl:text>
                                    </fo:block>
                                </fo:list-item-label>
                                <fo:list-item-body>
                                    <fo:block text-align="right">
                                        <xsl:text>Page </xsl:text>
                                        <fo:page-number/>
                                        <xsl:text> of </xsl:text>
                                        <fo:page-number-citation ref-id="last-page"/>
                                    </fo:block>
                                </fo:list-item-body>
                            </fo:list-item>
                        </fo:list-block>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body" xsl:use-attribute-sets="font">
                    <xsl:apply-templates/>
                    <fo:block id="last-page"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <xsl:template match="resume">
        <fo:block>
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
        </fo:block>
    </xsl:template>
    <xsl:template match="contact_info" mode="body">
        <fo:block>
            <fo:list-block>
                <fo:list-item>
                    <fo:list-item-label>
                        <fo:block/>
                    </fo:list-item-label>
                    <fo:list-item-body>
                        <fo:block>
                            <fo:list-block>
                                <fo:list-item>
                                    <fo:list-item-label>
                                        <fo:block>
                                            <fo:block xsl:use-attribute-sets="contact_name">
                                                <xsl:value-of
                                                  select="translate(                           concat(@first, ' ', @middle, '. ', @last),                           'abcdefghijklmnopqrstuvwxyz',                           'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                                />
                                            </fo:block>
                                            <fo:block xsl:use-attribute-sets="contact_other">
                                                <xsl:value-of
                                                  select="concat( street, ', ', city, ', ', state, ' ', zip, ' &#x2022; ', 'Cell: ', cell)"
                                                />
                                            </fo:block>
                                            <fo:block xsl:use-attribute-sets="contact_other">
                                                <xsl:value-of select="email"/>
                                                <xsl:text> &#x2022; </xsl:text>
                                                <xsl:value-of select="website"/>
                                            </fo:block>
                                        </fo:block>
                                    </fo:list-item-label>
                                    <fo:list-item-body>
                                        <fo:block text-align="right">
                                            <fo:inline>
                                                <fo:external-graphic src="url({image/@url})"/>
                                            </fo:inline>
                                        </fo:block>
                                    </fo:list-item-body>
                                </fo:list-item>
                            </fo:list-block>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </fo:list-block>
        </fo:block>
    </xsl:template>

    <xsl:template match="objectives">
        <fo:block>
            <fo:block xsl:use-attribute-sets="group_header"> PROFESSIONAL OBJECTIVE </fo:block>
            <fo:block xsl:use-attribute-sets="text">
                <xsl:apply-templates/>
            </fo:block>
        </fo:block>
    </xsl:template>

    <xsl:template name="ProcessObjectiveSupv" match="objectiveSupv">
        <xsl:if test="$showSupv">
            <fo:block xsl:use-attribute-sets="text">
                <xsl:apply-templates/>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <xsl:template name="ProcessObjectiveTech" match="objectiveTech">
        <xsl:if test="$showTech">
            <fo:block xsl:use-attribute-sets="text">
                <xsl:apply-templates/>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <xsl:template name="ProcessObjectiveAll" match="objectiveAll">
        <fo:block xsl:use-attribute-sets="text">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="highlights">
        <fo:block>
            <fo:block xsl:use-attribute-sets="group_header"> BACKGROUND HIGHLIGHTS </fo:block>
            <fo:block xsl:use-attribute-sets="text">
                <xsl:apply-templates/>
            </fo:block>
        </fo:block>
    </xsl:template>

    <xsl:template match="overview">
        <fo:block>
            <fo:block xsl:use-attribute-sets="group_header"> BACKGROUND SUMMARY </fo:block>
            <fo:block xsl:use-attribute-sets="text">
                <xsl:apply-templates/>
            </fo:block>
        </fo:block>
    </xsl:template>

    <xsl:template match="overview_item">
        <xsl:apply-templates select="overview_item"/>
    </xsl:template>

    <xsl:template name="ProcessOverviewItem" match="overview_item">
        <fo:block>
            <fo:list-block>
                <fo:list-item>
                    <fo:list-item-label xsl:use-attribute-sets="period_item_label">
                        <fo:block text-align="right">
                            <xsl:text>&#x2022;</xsl:text>
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body xsl:use-attribute-sets="overview_item_body">
                        <fo:block>
                            <xsl:apply-templates/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </fo:list-block>
        </fo:block>
    </xsl:template>

    <xsl:template name="CurrentSkills" match="skills" mode="current-skills">
        <fo:block>
            <fo:block xsl:use-attribute-sets="group_header">
                <xsl:text>TECHNICAL SKILL HIGHLIGHTS</xsl:text>
            </fo:block>
            <fo:list-block xsl:use-attribute-sets="skill_block">
                <xsl:for-each select="./skill_category">
                    <xsl:call-template name="ProcessSkillCategory">
                        <xsl:with-param name="mode">current-skills</xsl:with-param>
                    </xsl:call-template>
                </xsl:for-each>
            </fo:list-block>
        </fo:block>
    </xsl:template>

    <xsl:template name="OldSkills" match="skills" mode="old-skills">
        <fo:block>
            <fo:block xsl:use-attribute-sets="group_header">
                <xsl:text>OTHER TECHNICAL SKILLS</xsl:text>
            </fo:block>
            <fo:list-block xsl:use-attribute-sets="skill_block">
                <xsl:for-each select="./skill_category">
                    <xsl:call-template name="ProcessSkillCategory">
                        <xsl:with-param name="mode">old-skills</xsl:with-param>
                    </xsl:call-template>
                </xsl:for-each>
            </fo:list-block>
        </fo:block>
    </xsl:template>

    <xsl:template name="AnySkills" match="skills" mode="any-skills">
        <fo:block break-before="page">
            <fo:block xsl:use-attribute-sets="group_header">
                <xsl:text>TECHNICAL SKILLS</xsl:text>
            </fo:block>
            <fo:list-block xsl:use-attribute-sets="skill_block">
                <xsl:for-each select="./skill_category">
                    <xsl:call-template name="ProcessSkillCategory">
                        <xsl:with-param name="mode">any-skills</xsl:with-param>
                    </xsl:call-template>
                </xsl:for-each>
            </fo:list-block>
        </fo:block>
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
            <fo:list-item>
                <fo:list-item-label xsl:use-attribute-sets="skill_item_label">
                    <fo:block text-align="right">
                        <xsl:value-of select="concat(@name, ': ')"/>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body xsl:use-attribute-sets="skill_item_body">
                    <fo:block>
                        <xsl:value-of select="$skillset"/>
                        <xsl:text>.</xsl:text>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </xsl:if>
    </xsl:template>
    <xsl:template match="experience">
        <fo:block>
            <fo:block xsl:use-attribute-sets="group_header_no_space_after"> PROFESSIONAL EXPERIENCE </fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="period">
        <fo:block>
            <fo:block xsl:use-attribute-sets="experience_block">
                <fo:list-block>
                    <fo:list-item xsl:use-attribute-sets="period_list_item">
                        <fo:list-item-label xsl:use-attribute-sets="period_item_label">
                            <fo:block/>
                        </fo:list-item-label>
                        <fo:list-item-body xsl:use-attribute-sets="assignment_item_body">
                            <xsl:apply-templates select="assignment[1]"/>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </fo:block>
            <xsl:apply-templates select="assignment[position()!=1]|tasks"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="assignment[1]">
        <fo:block xsl:use-attribute-sets="inner_block">
            <xsl:call-template name="assignment_inner_list_block"/>
        </fo:block>
    </xsl:template>
    <xsl:template match="assignment[2]">
        <fo:block xsl:use-attribute-sets="experience_block">
            <fo:list-block>
                <fo:list-item xsl:use-attribute-sets="assignment_list_item_no_space_before">
                    <fo:list-item-label xsl:use-attribute-sets="period_item_label">
                        <fo:block/>
                    </fo:list-item-label>
                    <fo:list-item-body xsl:use-attribute-sets="assignment_item_body">
                        <fo:block xsl:use-attribute-sets="inner_block">
                            <xsl:call-template name="assignment_inner_list_block"/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </fo:list-block>
        </fo:block>
    </xsl:template>

    <xsl:template match="assignment[position()&gt;2]">
        <fo:block xsl:use-attribute-sets="experience_block">
            <fo:list-block>
                <fo:list-item xsl:use-attribute-sets="assignment_list_item">
                    <fo:list-item-label xsl:use-attribute-sets="period_item_label">
                        <fo:block/>
                    </fo:list-item-label>
                    <fo:list-item-body xsl:use-attribute-sets="assignment_item_body">
                        <fo:block xsl:use-attribute-sets="inner_block">
                            <xsl:call-template name="assignment_inner_list_block"/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </fo:list-block>
        </fo:block>
    </xsl:template>

    <xsl:template name="assignment_inner_list_block">
        <fo:list-block>
            <fo:list-item>
                <fo:list-item-label>
                    <fo:block>
                        <xsl:apply-templates select="position"/>
                        <xsl:text>: </xsl:text>
                        <xsl:value-of select="institution"/>
                        <xsl:value-of select="concat(', ',location,'.')"/>
                        <xsl:text> (</xsl:text>
                        <xsl:choose>
                            <xsl:when test="ancestor::period/@start_month">
                                <xsl:call-template name="monthNumToString">
                                    <xsl:with-param name="monthNum"
                                        select="ancestor::period/@start_month"/>
                                </xsl:call-template>
                                <xsl:number format=" 1111" value="ancestor::period/@start_year"/>
                                <xsl:text> &#8211; </xsl:text>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:choose>
                            <xsl:when test="ancestor::period/@end_month">
                                <xsl:call-template name="monthNumToString">
                                    <xsl:with-param name="monthNum"
                                        select="ancestor::period/@end_month"/>
                                </xsl:call-template>
                                <xsl:number format=" 1111" value="ancestor::period/@end_year"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>Present</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:text>)</xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block xsl:use-attribute-sets="note">
                        <xsl:call-template name="note">
                            <xsl:with-param name="note" select="institution/@note"/>
                        </xsl:call-template>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <xsl:apply-templates select="position"/>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="position">
        <xsl:value-of select="@title"/>
    </xsl:template>

    <xsl:template match="tasks">
        <xsl:apply-templates select="taskTerse"/>
        <xsl:apply-templates select="taskSupv"/>
        <xsl:apply-templates select="taskTech"/>
        <xsl:apply-templates select="taskSkills"/>
    </xsl:template>

    <xsl:template name="ProcessTaskTerse" match="taskTerse">
        <xsl:if test="$showTerse">
            <fo:block xsl:use-attribute-sets="experience_block">
                <fo:list-block>
                    <fo:list-item>
                        <fo:list-item-label xsl:use-attribute-sets="period_item_label">
                            <fo:block text-align="right">
                                <xsl:text>&#x2022;</xsl:text>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body xsl:use-attribute-sets="task_item_body">
                            <fo:block>
                                <xsl:apply-templates/>
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <xsl:template name="ProcessTaskSupv" match="taskSupv">
        <xsl:if test="$showSupv">
            <fo:block xsl:use-attribute-sets="experience_block">
                <fo:list-block>
                    <fo:list-item>
                        <fo:list-item-label xsl:use-attribute-sets="period_item_label">
                            <fo:block text-align="right">
                                <xsl:text>&#x2022;</xsl:text>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body xsl:use-attribute-sets="task_item_body">
                            <fo:block>
                                <xsl:apply-templates/>
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <xsl:template name="ProcessTaskTech" match="taskTech">
        <!--<xsl:if test="$showTech">-->
        <fo:block xsl:use-attribute-sets="experience_block">
            <fo:list-block>
                <fo:list-item>
                    <fo:list-item-label xsl:use-attribute-sets="period_item_label">
                        <fo:block text-align="right">
                            <xsl:text>&#x2022;</xsl:text>
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body xsl:use-attribute-sets="task_item_body">
                        <fo:block>
                            <xsl:apply-templates/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </fo:list-block>
        </fo:block>
        <!--</xsl:if>-->
    </xsl:template>

    <xsl:template name="ProcessTaskSkills" match="taskSkills">
        <xsl:if test="$showSkills">
            <fo:block xsl:use-attribute-sets="experience_block">
                <fo:list-block>
                    <fo:list-item>
                        <fo:list-item-label xsl:use-attribute-sets="period_item_label">
                            <fo:block text-align="right">
                                <xsl:text>&#x2022;</xsl:text>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body xsl:use-attribute-sets="task_item_body">
                            <fo:block>
                                <xsl:apply-templates/>
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <xsl:template match="education">
        <fo:block>
            <fo:block xsl:use-attribute-sets="group_header_no_space_after"> EDUCATION </fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="certifications">
        <fo:block xsl:use-attribute-sets="group_header_no_space_before"> PROFESSIONAL CERTIFICATION </fo:block>
        <fo:block xsl:use-attribute-sets="text">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="patents">
        <fo:block xsl:use-attribute-sets="group_header"> PATENTS </fo:block>
        <fo:block xsl:use-attribute-sets="text">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="associations">
        <fo:block xsl:use-attribute-sets="group_header"> PROFESSIONAL ASSOCIATIONS </fo:block>
        <fo:block xsl:use-attribute-sets="text">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="seminars">
        <fo:block xsl:use-attribute-sets="group_header"> TECHNICAL SEMINARS </fo:block>
        <fo:block xsl:use-attribute-sets="text">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="awards">
        <fo:block xsl:use-attribute-sets="group_header"> HONORS AND AWARDS </fo:block>
        <fo:block xsl:use-attribute-sets="text">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="link">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:variable name="base_font_size" select="10"/>
    <xsl:variable name="base_line_height" select="$base_font_size * 1.2"/>
    <xsl:variable name="min_line_height" select="$base_line_height"/>
    <xsl:variable name="max_line_height" select="$base_line_height"/>
    <xsl:variable name="opt_line_height" select="$base_line_height"/>
    <xsl:variable name="base_sz" select="concat($base_font_size, 'pt')"/>
    <xsl:variable name="base_ht" select="concat($base_line_height, 'pt')"/>
    <xsl:variable name="min_ht" select="concat($min_line_height, 'pt')"/>
    <xsl:variable name="max_ht" select="concat($max_line_height, 'pt')"/>
    <xsl:variable name="opt_ht" select="concat($opt_line_height, 'pt')"/>
    <xsl:attribute-set name="font">
        <xsl:attribute name="font-family">serif</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$base_sz"/>
        </xsl:attribute>
        <xsl:attribute name="line-height">
            <xsl:value-of select="$base_ht"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="contact_name">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="space-after">
            <xsl:value-of select="$opt_ht"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="contact_other">
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="group_header_common">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="group_header_no_space_before" use-attribute-sets="group_header_common">
        <xsl:attribute name="space-after">
            <xsl:value-of select="$opt_ht"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="group_header_no_space_after" use-attribute-sets="group_header_common">
        <xsl:attribute name="space-before">
            <xsl:value-of select="$opt_ht"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="group_header" use-attribute-sets="group_header_common">
        <xsl:attribute name="space-before">
            <xsl:value-of select="$opt_ht"/>
        </xsl:attribute>
        <xsl:attribute name="space-after">
            <xsl:value-of select="$opt_ht"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="text">
        <xsl:attribute name="start-indent">1em</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="simple">
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="note">
        <xsl:attribute name="font-style">italic</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="text-align">right</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="list_item_label">
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="list_item_body">
        <xsl:attribute name="start-indent">body-start()</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="skill_block">
        <xsl:attribute name="provisional-distance-between-starts">12em</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">0.5em</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="skill_item_label">
        <xsl:attribute name="start-indent">0em</xsl:attribute>
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="skill_item_body">
        <xsl:attribute name="start-indent">body-start()</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="experience_block">
        <xsl:attribute name="provisional-distance-between-starts">1em</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">0.5em</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="inner_block">
        <xsl:attribute name="provisional-distance-between-starts">0em</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">2.5em</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="period_list_item">
        <xsl:attribute name="space-before">
            <xsl:value-of select="$opt_ht"/>
        </xsl:attribute>
        <xsl:attribute name="space-after">
            <xsl:value-of select="$opt_ht"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="assignment_list_item_no_space_before">
        <xsl:attribute name="space-after">
            <xsl:value-of select="$opt_ht"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="assignment_list_item"
        use-attribute-sets="assignment_list_item_no_space_before">
        <xsl:attribute name="space-before">
            <xsl:value-of select="$opt_ht"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="period_item_label" use-attribute-sets="list_item_label">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="assignment_item_body" use-attribute-sets="list_item_body">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="position_item_label" use-attribute-sets="list_item_body">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="task_item_body" use-attribute-sets="list_item_body">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="text-align">justify</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="overview_item_body" use-attribute-sets="list_item_body">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="text-align">justify</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>
