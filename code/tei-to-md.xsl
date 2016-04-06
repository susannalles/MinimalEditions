<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="text"></xsl:output>
    
    <!-- SAT: Selecciona las <div> de primer nivel: -->
    <xsl:template match="/">
        <xsl:apply-templates select="//tei:body/tei:div"/>
    </xsl:template>

    <!-- <xsl:strip-space elements="*"/>-->

    <!-- SAT: Creación de files individuales para el prólogo y cada uno de los tratados. en caso que sólo se quisiera
    transformar una parte determinada del texto se debería indicar con xPath y substituirlo por "tei:body/tei:div"-->
   
    <xsl:template match="tei:body/tei:div">
        <!-- SAT: esta variable sirve para agarrar el valor del @xml:id y utilizarlo, por ejemplo, 
        para nombrar los ficheros.-->
        <xsl:variable name="sect_id" select="@xml:id"/>
        <xsl:result-document method="xml" encoding="utf-8"
            href="../../_posts/2016-03-14-{$sect_id}.md" omit-xml-declaration="yes">
            <!-- SAT: aquí se edita el header con yaml -->
            <xsl:text>---&#x0A;layout: narrative&#x0A;</xsl:text>
            <xsl:text>title: </xsl:text>
            <xsl:value-of select="tei:head[@type='titulo']"/>
            <xsl:text>&#x0A;</xsl:text>
            <xsl:text>author:</xsl:text>
            <xsl:value-of select="tei:teiHeader/fileDesc/titleStmt/author"/>
            <xsl:text>editor: Minimal Edition Class&#x0A;</xsl:text>
            <xsl:text>rights: Public Domain&#x0A;</xsl:text>
            <xsl:text>---&#x0A;&#x0A;</xsl:text>
            <xsl:apply-templates/>
        </xsl:result-document>
    </xsl:template>

    <!-- SAT: Tipografía -->
    <xsl:template match="tei:head[@type='titulo']"/>
       <!-- <xsl:text>&#xa;</xsl:text>
        <xsl:text>## </xsl:text>
        <xsl:value-of select="normalize-space(.)"></xsl:value-of>
        <xsl:text>&#xa; &#xa;</xsl:text>
    </xsl:template>
    -->
    
    <xsl:template match="tei:head[@type='subtitulo']">
        <xsl:text>&#xa;</xsl:text>
        <xsl:text>## </xsl:text>
        <xsl:apply-templates></xsl:apply-templates>
        <xsl:text>&#xa;&#xa;</xsl:text>
      
        <!--<p class="centered large">
            <xsl:apply-templates/>
        </p>-->
    </xsl:template>

   
    <xsl:template match="tei:p">
        <xsl:text>&#x0A;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#x0A;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:persName">
        <xsl:text> </xsl:text>
        <span class="persName">
            <xsl:apply-templates/>
        </span>
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <!--Problema con el espacio del texto  -->
   <!-- <xsl:template match="text()">
        <xsl:value-of select="normalize-space()"/>
    </xsl:template>-->
    
    <xsl:template match="text()">
        <xsl:value-of select="replace(replace(., '-', '\\-'), '\s+', ' ')"></xsl:value-of>
    </xsl:template>

</xsl:stylesheet>
