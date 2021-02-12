<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>
    <xsl:template match="/">
        <html lang="pl" xml:lang="pl">
            <head>
                <title><xsl:value-of select="//nagłówek"/></title>
                <style type="text/css">
                    body {
                        font-family:monospace;
                        font-size:15px;
                        background: rgb(192,181,255);
                        background: linear-gradient(0deg, rgba(192,181,255,0.6814075972185749) 0%, rgba(247,216,149,1) 100%); 
                    }
                    
                    table,th,td {
                        border: 2px solid black;
                    }
                    
                    table {
                        text-align:center;
                        border-collapse: collapse;
                    }
                    
                    td {
                        padding:5px;
                        width:9.2%;
                    }
                    
                    h1, h2{
                        text-align:center;
                        outline:3px dotted;
                        color:#4d3b37;
                        padding:10px 0;
                        text-transform: uppercase;
                    }
                    
                    h3 {
                        text-align:center;
                        outline:3px dotted;
                        color:#4d3b37;
                        padding:10px 0;
                    }
                    
                    h4 {
                        text-align:center;
                    }
                    
                    #autorzy {
                        margin:0;
                        color:darkblue;
                    }
                    
                    #tab1 {
                        width:45%;
                        float:right;
                    }
                    
                    #tab2 {
                        width:45%;
                    }
                    
                    #tab2 + h2 {
                        clear:both;
                    }
                    
                    a {
                        color: black;
                        text-decoration: none;
                     }
                    
                    a:hover {
                        text-decoration:underline;
                    }
                </style>
            </head>
            <body>
                <p id="autorzy"><xsl:text>Autorzy: </xsl:text><xsl:value-of select="//autorzy"/></p>
                <h1><xsl:value-of select="//nagłówek"/></h1>
                <table>
                    <thead>
                        <tr>
                            <th abbr="tl" rowspan="2">Tytuł</th>
                            <th abbr="reż" rowspan="2">Reżyseria</th>
                            <th abbr="scen" rowspan="2">Scenariusz</th>
                            <th abbr="bxoff" rowspan="2" colspan="2">Boxoffice</th>
                            <th abbr="oc" colspan="2">Ocena</th>
                            <th abbr="prem" colspan="2">Premiera</th>
                            <th abbr="wyp" colspan="2">Wypożyczenie</th>
                            <th abbr="wypoż" rowspan="2">Ilość dni wypożyczenia</th>
                        </tr>
                        <tr>
                            <th abbr="fWeb">Filmweb</th>
                            <th abbr="imdb">IMDb</th>
                            <th abbr="św">Świat</th>
                            <th abbr="pl">Polska</th>
                            <th abbr="dWyp">Data wyp.</th>
                            <th abbr="dZw">Data zwrotu</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="//listaFilmów/film"/>
                    </tbody>
                </table>
                
                <h2>Liczebność filmów</h2>
                <table id="tab1">
                    <thead>
                        <tr>
                            <th colspan="2">Gatunek</th>
                        </tr>
                    </thead>
                    <tbody>
                           <xsl:apply-templates select="//gatunkiRaport/gatunek"/>
                    </tbody>
                </table>
                <table id="tab2">
                    <thead>
                        <tr>
                            <th colspan="2">Kraj produkcji</th>
                        </tr>
                    </thead>
                    <tbody>
                           <xsl:apply-templates select="//krajeRaport/kraj"/>
                    </tbody>
                </table>
                <h2>Podsumowanie</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Nazwa</th>
                            <th>Typ</th>
                            <th>Wartość</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="//filmyRaport"/>
                    </tbody>
                </table>
                <h3>
                    <xsl:text>Data wygenerowania: </xsl:text>
                    <xsl:value-of select="//reportDate"/>
                </h3>
                <h4>
                    <xsl:value-of select="//prawa_autorskie"/>
                </h4>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="//listaFilmów/film">
        <tr>
            <td><a href="#"><xsl:value-of select="tytuł"/></a></td>
            <td><a href="#"><xsl:value-of select="reżyser"/></a></td>
            <td><a href="#"><xsl:value-of select="scenariusz"/></a></td>
            <td><a href="#"><xsl:value-of select="boxoffice[@waluta = 'USD']"/>
                <xsl:text> USD </xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="boxoffice[@waluta = 'PLN']"/>
                <xsl:text> PLN </xsl:text></a></td>
            <td><a href="{oceny/filmweb/@link}"><xsl:value-of select="oceny/filmweb"/></a></td>
            <td><a href="{oceny/imdb/@link}"><xsl:value-of select="oceny/imdb"/></a></td>
            <td><a href="#"><xsl:value-of select="premiera/świat"/></a></td>
            <td><a href="#"><xsl:value-of select="premiera/polska"/></a></td>
            <td><a href="#"><xsl:value-of select="wypożyczenie/początek"/></a></td>
            <td><a href="#"><xsl:value-of select="wypożyczenie/koniec"/></a></td>
            <td><a href="#"><xsl:value-of select="wypożyczenie/ilość_dni"/></a></td>
        </tr>
    </xsl:template>
    
    <xsl:template match="//gatunkiRaport/gatunek">
        <tr>
            <td><a href="#"><xsl:value-of select="nazwa"/></a></td>
            <td><a href="#"><xsl:value-of select="ilość_filmów"/></a></td>
        </tr>
    </xsl:template>
    
    <xsl:template match="//krajeRaport/kraj">
        <tr>
            <td><a href="#"><xsl:value-of select="nazwa"/></a></td>
            <td><a href="#"><xsl:value-of select="ilość_filmów"/></a></td>
        </tr>
    </xsl:template>
    
    <xsl:template match="//filmyRaport">
        <tr>
            <td rowspan="2"><a href="#"><xsl:text>Ilość filmów</xsl:text></a></td>
            <td><a href="#"><xsl:text>Dostępnych</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="dostępne_filmy"/></a></td>
        </tr>
        <tr>
            <td><a href="#"><xsl:text>Niedostępnych</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="niedostępne_filmy"/></a></td>
        </tr>
        <tr>
            <td rowspan="2"><a href="#"><xsl:text>Średnia wartość boxoffice</xsl:text></a></td>
            <td><a href="#"><xsl:text>USD</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="śr_boxoffice[@waluta = 'USD']"/></a></td>
        </tr>
        <tr>
            <td><a href="#"><xsl:text>PLN</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="śr_boxoffice[@waluta = 'PLN']"/></a></td>
        </tr>
        <tr>
            <td rowspan="2"><a href="#"><xsl:text>Średnia ocen</xsl:text></a></td>
            <td><a href="#"><xsl:text>Filmweb</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="śr_filmweb"/></a></td>
        </tr>
        <tr>
            <td><a href="#"><xsl:text>IMDb</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="śr_imdb"/></a></td>
        </tr>
        <tr>
            <td rowspan="2"><a href="#"><xsl:text>Najwyżej oceniony film</xsl:text></a></td>
            <td><a href="#"><xsl:text>Filmweb</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="max_ocena_filmweb"/></a></td>
        </tr>
        <tr>
            <td><a href="#"><xsl:text>IMDb</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="max_ocena_imdb"/></a></td>
        </tr>
        <tr>
            <td rowspan="2"><a href="#"><xsl:text>Najniżej oceniony film</xsl:text></a></td>
            <td><a href="#"><xsl:text>Filmweb</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="min_ocena_filmweb"/></a></td>
        </tr>
        <tr>
            <td><a href="#"><xsl:text>IMDb</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="min_ocena_imdb"/></a></td>
        </tr>
        <tr>
            <td rowspan="2"><a href="#"><xsl:text>Najstarsza premiera</xsl:text></a></td>
            <td><a href="#"><xsl:text>Polska</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="najstarsza_premiera_polska"/></a></td>
        </tr>
        <tr>
            <td><a href="#"><xsl:text>Świat</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="najstarsza_premiera_świat"/></a></td>
        </tr>
        <tr>
            <td rowspan="2"><a href="#"><xsl:text>Najnowsza premiera</xsl:text></a></td>
            <td><a href="#"><xsl:text>Polska</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="najnowsza_premiera_polska"/></a></td>
        </tr>
        <tr>
            <td><a href="#"><xsl:text>Świat</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="najnowsza_premiera_świat"/></a></td>
        </tr>
        <tr>
            <td><a href="#"><xsl:text>Kurs waluty użyty do przeliczenia boxoffice</xsl:text></a></td>
            <td><a href="#"><xsl:text>PLN</xsl:text></a></td>
            <td><a href="#"><xsl:value-of select="kursUSD"/></a></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
