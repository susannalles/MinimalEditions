<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
 
    
    <xsl:template match="tei:placeName">
        <xsl:copy>
        
            <xsl:value-of select="."></xsl:value-of>
        </xsl:copy>
    </xsl:template>
        
 
    
    <xsl:template match="* | text()| @* | node()">
        
       
            <xsl:apply-templates select="* | text() | @*"/>
        
    </xsl:template>
    
    <xsl:template match="/">
        
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            
            <xsl:apply-templates></xsl:apply-templates>
        </TEI>
    </xsl:template>
    
</xsl:stylesheet>