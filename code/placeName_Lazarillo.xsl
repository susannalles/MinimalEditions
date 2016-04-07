<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:import href="identity.xsl"/>
    <xsl:template match="tei:placeName">
        <xsl:variable name="geonames_api">
            <xsl:text>http://api.geonames.org/search?q=</xsl:text>
        </xsl:variable>
        <xsl:variable name="geonames_params">
            <xsl:text>&amp;maxRows=10&amp;style=LONG&amp;lang=es</xsl:text>
        </xsl:variable>
        <xsl:variable name="geonames_username">
            <xsl:text>&amp;username=tcatapano</xsl:text>
        </xsl:variable>
        <xsl:element name="placeName" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="key">
                <xsl:text>http://www.geonames.org/</xsl:text>
                <xsl:value-of
                    select="document(concat($geonames_api, normalize-space() , $geonames_params, $geonames_username))//geoname[1]/geonameId"
                />
            </xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>


</xsl:stylesheet>
