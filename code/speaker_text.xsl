<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei" version="2.0">
    <!-- 
          speaker_text.xsl:
          create list of words and their frequency, and list of all words, for each speaker in source document
          see: email https://www.oxygenxml.com/archives/xsl-list/200402/msg00392.html and surrounding thread
     -->
    <xsl:template match="/">
        <texts>
            <!-- group all sp elements by the value of their corresp or who attributes -->
            <xsl:for-each-group select="//tei:sp" group-by="@corresp | @who">
                <!-- create a speaker element with the attrubute "name" value of the current group's
                     corresp or who attribute (i.e., the "grouping key")
                -->
                <speaker name="{current-grouping-key()}">
                    <!-- create a frequency element as the root of the output document-->
                         <frequency>
                         <!-- create a sequence of all text strings separated by "non-word" characters (\W+) from the text
                              in the current group of sp elements (using tokenize() function)
                         
                            for each item (i.e., word) in the sequence created by the tokenize() function, assign to variable $w
                            and convert the word to lower-case
                         
                            group the sequence of lower-cased words by spelling (group-by=".")
                         
                            for each group of words (for-each-group), sort by the count of the # of occurences of the word
                         
                            create a word_count element with:
                                * a word element with the word making up each group of occurrences ("the current-grouping-key")
                                * a count element with the count of occurrences of the word
                         -->      
                        <xsl:for-each-group group-by="."
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
                    <!-- create list of all words in each group of sp elements
                             
                              create a sequence of all text strings separated by "non-word" characters (\W+) from the text
                              in the current group of sp elements (using tokenize() function)
                              
                              for each item (i.e., word) in the sequence created by the tokenize() function, assign to variable $w
                              and normalize the spacing of the variable and convert the word to lower-case
                              
                     -->         
                              
                    <all_words>
                        <xsl:value-of
                            select="
                                for $w in tei:p/tokenize(., '\W+')[.]
                                return
                                    lower-case(normalize-space($w))"
                        />
                    </all_words>
                </speaker>
            </xsl:for-each-group>
        </texts>
    </xsl:template>
    <!-- :-!¿?¡.,; -->


</xsl:stylesheet>
