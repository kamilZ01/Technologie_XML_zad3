<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="text" encoding="utf-8" indent="yes"/>
    <xsl:template match="/">
       
    <xsl:text>Autorzy:</xsl:text>
        <xsl:text>&#13;&#13;</xsl:text>
        <xsl:apply-templates select="//autorzy" />
        <xsl:text>&#13;</xsl:text>
        <xsl:value-of select="concat(//nagłówek,':')"/>
        <xsl:text>&#13;</xsl:text>
        <xsl:apply-templates select="//listaFilmów" />
        <xsl:text>Liczebność filmów wg. gatunku:&#13;</xsl:text>
        <xsl:apply-templates select="//gatunkiRaport" />
        <xsl:text>Liczebność filmów wg. kraju produkcji:&#13;</xsl:text>
        <xsl:apply-templates select="//krajeRaport" />
        <xsl:text>Podsumowanie:&#13;</xsl:text>
        <xsl:apply-templates select="//filmyRaport" />
        <xsl:text>Data wygenerowanie raportu: </xsl:text>
        <xsl:value-of select="//reportDate" />
        <xsl:text>&#13;&#13;</xsl:text> 
        <xsl:value-of select="//prawa_autorskie" />       
    </xsl:template>
    
    <xsl:template match="//autorzy">
        <xsl:for-each select="autor">
            <xsl:variable name="i" select="position()" />
            <xsl:value-of select="concat('Autor ',$i,': ',.,'&#13;')" />
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="//listaFilmów" >
        <xsl:variable name="spacje" select="25" />
        <xsl:for-each select="film">
            <xsl:variable name="tytułN" select="'Tytuł:'" />
            <xsl:value-of select="$tytułN" />
            <xsl:call-template name="odstęp">
                <xsl:with-param name="ilość_spacji" select="$spacje - string-length($tytułN)" />
            </xsl:call-template>
            <xsl:value-of select="concat(tytuł,'&#13;')" />
            
            <xsl:variable name="reżyserN" select="'Reżyser:'" />
            <xsl:value-of select="$reżyserN" />
            <xsl:call-template name="odstęp">
                <xsl:with-param name="ilość_spacji" select="$spacje - string-length($reżyserN)" />
            </xsl:call-template>
            <xsl:value-of select="concat(reżyser,'&#13;')" />
            
            <xsl:variable name="scenariuszN" select="'Scenariusz:'" />
            <xsl:value-of select="$scenariuszN" />
            <xsl:call-template name="odstęp">
                <xsl:with-param name="ilość_spacji" select="$spacje - string-length($scenariuszN)" />
            </xsl:call-template>
            <xsl:value-of select="concat(scenariusz,'&#13;')" />
            
            <xsl:variable name="boxofficeN" select="'Boxoffice:'" />
            <xsl:value-of select="$boxofficeN" />
            <xsl:call-template name="odstęp">
                <xsl:with-param name="ilość_spacji" select="$spacje - string-length($boxofficeN)" />
            </xsl:call-template>
            <xsl:value-of select="concat(boxoffice[@waluta = 'USD'],' USD (',boxoffice[@waluta = 'PLN'],' PLN)&#13;')" />
            
            <xsl:variable name="ocenaFilmwebN" select="'Ocena Filmweb:'" />
            <xsl:value-of select="$ocenaFilmwebN" />
            <xsl:call-template name="odstęp">
                <xsl:with-param name="ilość_spacji" select="$spacje - string-length($ocenaFilmwebN)" />
            </xsl:call-template>
            <xsl:value-of select="concat(oceny/filmweb,'&#13;')" />
            
            <xsl:variable name="ocenaIMDBN" select="'Ocena IMDb:'" />
            <xsl:value-of select="$ocenaIMDBN" />
            <xsl:call-template name="odstęp">
                <xsl:with-param name="ilość_spacji" select="$spacje - string-length($ocenaIMDBN)" />
            </xsl:call-template>
            <xsl:value-of select="concat(oceny/imdb,'&#13;')" />
            
            <xsl:variable name="premieraPLN" select="'Premiera Polska:'" />
            <xsl:value-of select="$premieraPLN" />
            <xsl:call-template name="odstęp">
                <xsl:with-param name="ilość_spacji" select="$spacje - string-length($premieraPLN)" />
            </xsl:call-template>
            <xsl:value-of select="concat(premiera/polska,'&#13;')" />
            
            <xsl:variable name="premieraŚwiatN" select="'Premiera Świat:'" />
            <xsl:value-of select="$premieraŚwiatN" />
            <xsl:call-template name="odstęp">
                <xsl:with-param name="ilość_spacji" select="$spacje - string-length($premieraŚwiatN)" />
            </xsl:call-template>
            <xsl:value-of select="concat(premiera/świat,'&#13;')" />
            
            <xsl:variable name="dataWypożyczeniaN" select="'Data wypożyczenia:'" />
            <xsl:value-of select="$dataWypożyczeniaN" />
            <xsl:call-template name="odstęp">
                <xsl:with-param name="ilość_spacji" select="$spacje - string-length($dataWypożyczeniaN)" />
            </xsl:call-template>
            <xsl:value-of select="concat(wypożyczenie/początek,'&#13;')" />
            
            <xsl:variable name="dataZwrotuN" select="'Data zwrotu:'" />
            <xsl:value-of select="$dataZwrotuN" />
            <xsl:call-template name="odstęp">
                <xsl:with-param name="ilość_spacji" select="$spacje - string-length($dataZwrotuN)" />
            </xsl:call-template>
            <xsl:value-of select="concat(wypożyczenie/koniec,'&#13;')" />
            
            <xsl:variable name="ilośćDniN" select="'Ilość dni wypożyczenia:'" />
            <xsl:value-of select="$ilośćDniN" />
            <xsl:call-template name="odstęp">
                <xsl:with-param name="ilość_spacji" select="$spacje - string-length($ilośćDniN)" />
            </xsl:call-template>
            <xsl:value-of select="concat(wypożyczenie/ilość_dni,'&#13;')" />
          
            <xsl:text>&#13;</xsl:text>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="//gatunkiRaport" >
        <xsl:variable name="spacje" select="15" />
        <xsl:for-each select="gatunek">
            <xsl:variable name="gatunekN" select="nazwa" />
            <xsl:value-of select="concat($gatunekN,':')" />
            <xsl:call-template name="odstęp">
                <xsl:with-param name="ilość_spacji" select="$spacje - string-length($gatunekN)" />
            </xsl:call-template>
            <xsl:value-of select="ilość_filmów" />
            <xsl:text>&#13;</xsl:text>
        </xsl:for-each>
        <xsl:text>&#13;</xsl:text>
    </xsl:template>
    
    <xsl:template match="//krajeRaport" >
        <xsl:variable name="spacje" select="30" />
        <xsl:for-each select="kraj">
            <xsl:variable name="krajProdukcjiN" select="nazwa" />
            <xsl:value-of select="concat($krajProdukcjiN,':')" />
            <xsl:call-template name="odstęp">
                <xsl:with-param name="ilość_spacji" select="$spacje - string-length($krajProdukcjiN)" />
            </xsl:call-template>
            <xsl:value-of select="ilość_filmów" />
            <xsl:text>&#13;</xsl:text>
        </xsl:for-each>
        <xsl:text>&#13;</xsl:text>
    </xsl:template>
    
    <xsl:template match="//filmyRaport" >
        <xsl:variable name="spacje" select="40" />
        <xsl:variable name="dostępneFilmyN" select="'Dostępne filmy (ilość):'" />
        <xsl:value-of select="$dostępneFilmyN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($dostępneFilmyN)" />
        </xsl:call-template>
        <xsl:value-of select="dostępne_filmy" />
        <xsl:text>&#13;</xsl:text>
        
        <xsl:variable name="niedostępneFilmyN" select="'Niedostępne filmy (ilość):'" />
        <xsl:value-of select="$niedostępneFilmyN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($niedostępneFilmyN)" />
        </xsl:call-template>
        <xsl:value-of select="niedostępne_filmy" />
        <xsl:text>&#13;</xsl:text>   
        
        <xsl:variable name="śrboxofficeN" select="'Średnia wartość boxoffice:'" />
        <xsl:value-of select="$śrboxofficeN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($śrboxofficeN)" />
        </xsl:call-template>
        <xsl:value-of select="concat(śr_boxoffice[@waluta = 'USD'],' USD (',śr_boxoffice[@waluta = 'PLN'],' PLN)')" />
        <xsl:text>&#13;</xsl:text>
        
        <xsl:variable name="śrFilmwebN" select="'Średni ocen Filmweb:'" />
        <xsl:value-of select="$śrFilmwebN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($śrFilmwebN)" />
        </xsl:call-template>
        <xsl:value-of select="śr_filmweb" />
        <xsl:text>&#13;</xsl:text>
        
        <xsl:variable name="śrImdbN" select="'Średni ocen IMDb:'" />
        <xsl:value-of select="$śrImdbN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($śrImdbN)" />
        </xsl:call-template>
        <xsl:value-of select="śr_imdb" />
        <xsl:text>&#13;</xsl:text>
        
        <xsl:variable name="maxFilmwebN" select="'Najwyżej oceniony film wg. Filmweb:'" />
        <xsl:value-of select="$maxFilmwebN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($maxFilmwebN)" />
        </xsl:call-template>
        <xsl:value-of select="max_ocena_filmweb" />
        <xsl:text>&#13;</xsl:text>
        
        <xsl:variable name="maxImdbN" select="'Najwyżej oceniony film wg. IMDb:'" />
        <xsl:value-of select="$maxFilmwebN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($maxFilmwebN)" />
        </xsl:call-template>
        <xsl:value-of select="max_ocena_imdb" />
        <xsl:text>&#13;</xsl:text>
        
        <xsl:variable name="minFilmwebN" select="'Najniżej oceniony film wg. Filmweb:'" />
        <xsl:value-of select="$minFilmwebN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($minFilmwebN)" />
        </xsl:call-template>
        <xsl:value-of select="min_ocena_filmweb" />
        <xsl:text>&#13;</xsl:text>
        
        <xsl:variable name="minImdbN" select="'Najniżej oceniony film wg. IMDb:'" />
        <xsl:value-of select="$minFilmwebN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($minFilmwebN)" />
        </xsl:call-template>
        <xsl:value-of select="min_ocena_imdb" />
        <xsl:text>&#13;</xsl:text>
        
        <xsl:variable name="najstarszapremieraŚwiatN" select="'Najstarsza premiera Świat:'" />
        <xsl:value-of select="$najstarszapremieraŚwiatN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($najstarszapremieraŚwiatN)" />
        </xsl:call-template>
        <xsl:value-of select="najstarsza_premiera_świat" />
        <xsl:text>&#13;</xsl:text>
        
        <xsl:variable name="najstarszapremieraPolskaN" select="'Najstarsza premiera Polska:'" />
        <xsl:value-of select="$najstarszapremieraPolskaN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($najstarszapremieraPolskaN)" />
        </xsl:call-template>
        <xsl:value-of select="najstarsza_premiera_polska" />
        <xsl:text>&#13;</xsl:text>
        
        <xsl:variable name="najnowszapremieraŚwiatN" select="'Najnowsza premiera Świat:'" />
        <xsl:value-of select="$najnowszapremieraŚwiatN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($najnowszapremieraŚwiatN)" />
        </xsl:call-template>
        <xsl:value-of select="najnowsza_premiera_świat" />
        <xsl:text>&#13;</xsl:text>
        
        <xsl:variable name="najnowszapremieraPolskaN" select="'Najnowsza premiera Polska:'" />
        <xsl:value-of select="$najnowszapremieraPolskaN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($najnowszapremieraPolskaN)" />
        </xsl:call-template>
        <xsl:value-of select="najnowsza_premiera_polska" />
        <xsl:text>&#13;</xsl:text>
        
        <xsl:variable name="kursUSDN" select="'Kurs USD dla przelicznika Boxoffice:'" />
        <xsl:value-of select="$kursUSDN" />
        <xsl:call-template name="odstęp">
            <xsl:with-param name="ilość_spacji" select="$spacje - string-length($kursUSDN)" />
        </xsl:call-template>
        <xsl:value-of select="kursUSD" />
        <xsl:text>&#13;&#13;</xsl:text> 
    </xsl:template>
    
    <xsl:template name="odstęp" >
        <xsl:param name = "ilość_spacji" />
        <xsl:for-each select="1 to $ilość_spacji">
            <xsl:text> </xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
