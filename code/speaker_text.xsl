<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei" version="2.0">
    <xsl:template match="/">
        <texts>
            <xsl:for-each-group select="//tei:sp" group-by="@corresp | @who">
               <speaker name="{current-grouping-key()}">
                   <frequency>   <xsl:for-each-group group-by="."
                        select="
                            for $w in current-group()/tei:p/text()/tokenize(., '\W+')[.]
                            return
                                lower-case($w)">
                        <xsl:sort select="count(current-group())" order="descending"/>                        
                        <!-- <xsl:if test="string-length(string(current-grouping-key())) gt 0"> -->
                       <word_count>
                            <word>
                                <xsl:value-of select="current-grouping-key()"/>
                            </word>
                            <count>
                                <xsl:value-of select="count(current-group())"/>
                            </count>
                        </word_count>
                        <!--</xsl:if> -->
                    </xsl:for-each-group>
                   </frequency>
                   <all_words>
                       <xsl:value-of select="for $w in tei:p/tokenize(., '\W+')[.] return lower-case(normalize-space($w))"/>                       
                   </all_words>
                </speaker>
            </xsl:for-each-group>
        </texts>
    </xsl:template>
    <!-- :-!¿?¡.,; -->


</xsl:stylesheet>
