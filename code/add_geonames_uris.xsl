<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">
    
    <!-- add_geonames_uris.xsl
             add key attribute with geonames,org URI to each placeName element in lazarillo-master.xml
             
             WARNING: this is an automated lookup and may not produce correct results.
        
        -->
     
    <!-- 
         import identity transform stylesheet which will copy all nodes in input
         except for elements with templates in this stylesheet (i.e, placeName)
    -->
    <xsl:import href="identity.xsl"/>
    <xsl:template match="tei:placeName">
      
        
        <!-- Geonames API query URL-->
        <xsl:variable name="geonames_api">
            <xsl:text>http://api.geonames.org/search?q=</xsl:text>
        </xsl:variable>
        <!-- Query Paramters: maxRows, style, language and country-->
        <xsl:variable name="geonames_params">
            <xsl:text>&amp;maxRows=10&amp;style=LONG&amp;lang=es&amp;country=ES</xsl:text>
        </xsl:variable>
        <!-- Geonames username -->
        <xsl:variable name="geonames_username">
            <xsl:text>&amp;username=tcatapano</xsl:text>
        </xsl:variable>
        <!-- When matching a placeNames element:
            create a new PlaceName element
            apply-templates on all attributes (i.e., copy)
            create a new "key" attribute, with the value of the geoNameId field in first result in the response to the query of geonames-
         -->    
        <xsl:element name="placeName" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="key">
                <!-- write out base/domain of geonames URI-->
                <xsl:text>http://www.geonames.org/</xsl:text>
                <!-- write out geonames ID for matched locality by: 
                    1. construct URL for query of GeoNames API by concatenating:
                    * $geonames_api variable
                    * text of the current placeName element
                    * $geogname_params variable
                    * geonames_username variable
                     
                     2. send constructed URL string to document() function which will attempt return the XML response to the query (if any)
                     
                     3. get the value of the geonameId element from the first result in the XML response
                 -->     
                <xsl:value-of
                    select="document(concat($geonames_api, normalize-space() , $geonames_params, $geonames_username))//geoname[1]/geonameId"
                />
            </xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
