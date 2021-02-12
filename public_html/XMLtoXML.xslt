<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
 xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
    <xsl:variable name="kursUSD" select="3.80"/>
    <xsl:template match="/">
        <xsl:element name="filmy">
            <xsl:element name="autorzy">
                <xsl:apply-templates select="//autorzy/twórca"/>
            </xsl:element>
            
            <xsl:element name="nagłówek">
                <xsl:value-of select="normalize-space(//dane_techniczne/tytuł)"/>
            </xsl:element>
            
            <xsl:element name="listaFilmów">
                <xsl:for-each select="//film">
                    <xsl:sort select="dane/boxoffice" order="descending" data-type="number" />
                         <xsl:element name="film">
                            <xsl:attribute name="id">
                                 <xsl:value-of select="@id"/>
                            </xsl:attribute>
                            <xsl:element name="tytuł">
                            <xsl:choose>
                                <xsl:when test="string(dane/tytuł_pl) = ''">
                                    <xsl:value-of select="dane/tytuł_org"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy select="dane/concat(tytuł_org,' (',tytuł_pl,')')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            </xsl:element>
                            <xsl:element name="reżyser">
                               <xsl:value-of select="dane/reżyseria"/>
                            </xsl:element>
                            <xsl:element name="scenariusz">
                                <xsl:value-of select="dane/scenariusz"/>
                            </xsl:element>
                            <xsl:apply-templates select="dane/boxoffice"/>
                            <xsl:apply-templates select="oceny"/>
                            <xsl:apply-templates select="premiery"/>
                            <xsl:apply-templates select="wypożyczenie"/>
                        </xsl:element>
                </xsl:for-each>
            </xsl:element>
            
            <xsl:element name="gatunkiRaport">
                <xsl:for-each select="//gatunki/gatunek">
                    <xsl:element name="gatunek">
                    <xsl:variable name="gatunek" select="@gatunek_id" />
                    <xsl:element name="nazwa">
                     <xsl:value-of select="."/>
                    </xsl:element>
                    <xsl:element name="ilość_filmów">
                     <xsl:value-of select="count(//filmy/film[contains(@gatunek,$gatunek)])" />
                    </xsl:element>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        
            <xsl:element name="krajeRaport">
                <xsl:for-each select="//kraje/kraj">
                <xsl:element name="kraj">
                <xsl:variable name="kraj" select="@kraj_id" />
                    <xsl:element name="nazwa">
                        <xsl:value-of select="."/>
                    </xsl:element>
                    <xsl:element name="ilość_filmów">
                        <xsl:value-of select="count(//filmy/film[contains(@kraj,$kraj)])" />
                    </xsl:element>
                </xsl:element>
                </xsl:for-each>
            </xsl:element>
            
            <xsl:element name="filmyRaport">
                <xsl:variable name="śr_boxofficeUSD" select="avg(//film/dane/boxoffice)" />
                <xsl:element name="dostępne_filmy">
                    <xsl:value-of select="count(//film/wypożyczenie/data_zwrotu[. != ''])" />
                </xsl:element>
                <xsl:element name="niedostępne_filmy">
                    <xsl:value-of select="count(//film/wypożyczenie/data_zwrotu[. = ''])" />
                </xsl:element>
                <xsl:element name="śr_boxoffice">
                    <xsl:attribute name="waluta">
                        <xsl:value-of select="string('USD')"/>
                    </xsl:attribute>
                    <xsl:value-of select="format-number($śr_boxofficeUSD, '###,###')" />
                </xsl:element>
                <xsl:element name="śr_boxoffice">
                    <xsl:attribute name="waluta">
                        <xsl:value-of select="string('PLN')"/>
                    </xsl:attribute>
                    <xsl:value-of select="format-number($śr_boxofficeUSD * $kursUSD, '###,###')" />
                </xsl:element>
                <xsl:element name="śr_filmweb">
                    <xsl:value-of select="format-number(avg(//film/oceny/filmweb), '#.0')" />
                </xsl:element>
                <xsl:element name="śr_imdb">
                    <xsl:value-of select="format-number(avg(//film/oceny/imdb), '#.0')" />
                </xsl:element>
                <xsl:element name="max_ocena_filmweb">
                    <xsl:variable name="wartosc">
                        <xsl:for-each select="//film">
                            <xsl:sort select="oceny/filmweb" order="descending" />
                                <xsl:if test="position() = 1">
                                    <xsl:value-of select="dane/tytuł_org"/>
                                    <xsl:text> (</xsl:text>
                                    <xsl:value-of select="oceny/filmweb"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:value-of select="$wartosc"/>
                </xsl:element>
                <xsl:element name="min_ocena_filmweb">
                    <xsl:variable name="wartosc">
                        <xsl:for-each select="//film">
                            <xsl:sort select="oceny/filmweb" order="ascending" />
                                <xsl:if test="position() = 1">
                                    <xsl:value-of select="dane/tytuł_org"/>
                                    <xsl:text> (</xsl:text>
                                    <xsl:value-of select="oceny/filmweb"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:value-of select="$wartosc"/>
                </xsl:element>       
                <xsl:element name="max_ocena_imdb">
                    <xsl:variable name="wartosc">
                        <xsl:for-each select="//film">
                            <xsl:sort select="oceny/imdb" order="descending" />
                                <xsl:if test="position() = 1">
                                    <xsl:value-of select="dane/tytuł_org"/>
                                    <xsl:text> (</xsl:text>
                                    <xsl:value-of select="oceny/imdb"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:value-of select="$wartosc"/>
                </xsl:element> 
                <xsl:element name="min_ocena_imdb">
                    <xsl:variable name="wartosc">
                        <xsl:for-each select="//film">
                            <xsl:sort select="oceny/imdb" order="ascending" />
                                <xsl:if test="position() = 1">
                                    <xsl:value-of select="dane/tytuł_org"/>
                                    <xsl:text> (</xsl:text>
                                    <xsl:value-of select="oceny/imdb"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:value-of select="$wartosc"/>
                </xsl:element>
                <xsl:element name="najstarsza_premiera_świat">
                    <xsl:variable name="wartosc">
                        <xsl:for-each select="//film">
                            <xsl:sort select="premiery/świat" order="ascending" />
                                <xsl:if test="position() = 1">
                                    <xsl:value-of select="dane/tytuł_org"/>
                                    <xsl:text> (</xsl:text>
                                    <xsl:value-of select="premiery/świat"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:value-of select="$wartosc"/>
                </xsl:element>
                <xsl:element name="najnowsza_premiera_świat">
                    <xsl:variable name="wartosc">
                        <xsl:for-each select="//film">
                            <xsl:sort select="premiery/świat" order="descending" />
                                <xsl:if test="position() = 1">
                                    <xsl:value-of select="dane/tytuł_org"/>
                                    <xsl:text> (</xsl:text>
                                    <xsl:value-of select="premiery/świat"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:value-of select="$wartosc"/>
                </xsl:element>
                <xsl:element name="najstarsza_premiera_polska">
                    <xsl:variable name="wartosc">
                        <xsl:for-each select="//film">
                            <xsl:sort select="premiery/polska" order="ascending" />
                                <xsl:if test="position() = 1">
                                    <xsl:value-of select="dane/tytuł_org"/>
                                    <xsl:text> (</xsl:text>
                                    <xsl:value-of select="premiery/polska"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:value-of select="$wartosc"/>
                </xsl:element>
                <xsl:element name="najnowsza_premiera_polska">
                    <xsl:variable name="wartosc">
                        <xsl:for-each select="//film">
                            <xsl:sort select="premiery/polska" order="descending" />
                                <xsl:if test="position() = 1">
                                    <xsl:value-of select="dane/tytuł_org"/>
                                    <xsl:text> (</xsl:text>
                                    <xsl:value-of select="premiery/polska"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:value-of select="$wartosc"/>
                </xsl:element>
                <xsl:element name="kursUSD">
                    <xsl:value-of select="$kursUSD"/>
                </xsl:element>
            </xsl:element>
        
            <xsl:element name="reportDate">
                <xsl:value-of select="format-dateTime(current-dateTime(),'[D01].[M01].[Y0001]')" />
                <xsl:text>r.</xsl:text>
            </xsl:element>
        
            <xsl:element name="prawa_autorskie">
                <xsl:value-of select="//prawa_autorskie" />
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="//autorzy/twórca">
        <xsl:element name="autor">
            <xsl:value-of select="@nrIndeksu"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="dane/boxoffice">
        <xsl:variable name="boxUSD" select="number(replace(string(.), ' ', ''))"/>
        <xsl:element name="boxoffice">
           <xsl:attribute name="waluta">
                <xsl:value-of select="@waluta"/>
            </xsl:attribute>
            <xsl:value-of select="format-number($boxUSD, '###,###')"/>
        </xsl:element>
        <xsl:element name="boxoffice">
            <xsl:attribute name="waluta">
                <xsl:value-of select="string('PLN')"/>
            </xsl:attribute>
            <xsl:value-of select="format-number($boxUSD * $kursUSD, '###,###')"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="oceny">
        <xsl:element name="oceny">
            <xsl:element name="filmweb">
                <xsl:attribute name="link">
                    <xsl:value-of select="../bazy_filmowe/@filmweb"/>
                </xsl:attribute>
                <xsl:value-of select="filmweb"/>
            </xsl:element>
            <xsl:element name="imdb">
                <xsl:attribute name="link">
                    <xsl:value-of select="../bazy_filmowe/@imdb"/>
                </xsl:attribute>
                <xsl:value-of select="imdb"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="premiery">
        <xsl:element name="premiera">
            <xsl:element name="polska">
                <xsl:value-of select="polska"/>
            </xsl:element>
            <xsl:element name="świat">
                <xsl:value-of select="świat"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
     <xsl:template match="wypożyczenie">
        <xsl:element name="wypożyczenie">
            <xsl:element name="początek">
                <xsl:value-of select="data_wypożyczenia"/>
            </xsl:element>
            <xsl:element name="koniec">
                <xsl:choose>
                    <xsl:when test="data_zwrotu = ''">
                        <xsl:value-of select="string('-')" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="data_zwrotu"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:element>
            <xsl:element name="ilość_dni">
                <xsl:choose>
                    <xsl:when test="data_zwrotu = ''">
                        <xsl:value-of select="string('-')" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="days-from-duration(xs:date(data_zwrotu) - xs:date(data_wypożyczenia))" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:element> 
        </xsl:element>
    </xsl:template>
 
</xsl:stylesheet>
