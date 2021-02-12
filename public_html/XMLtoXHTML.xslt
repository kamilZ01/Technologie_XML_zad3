<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" omit-xml-declaration="yes" />
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
                        color:#4d3b37;   
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
                            <th rowspan="2">Tytuł</th>
                            <th rowspan="2">Reżyseria</th>
                            <th rowspan="2">Scenariusz</th>
                            <th rowspan="2" colspan="2">Boxoffice</th>
                            <th colspan="2">Ocena</th>
                            <th colspan="2">Premiera</th>
                            <th colspan="2">Wypożyczenie</th>
                            <th rowspan="2">Ilość dni wypożyczenia</th>
                        </tr>
                        <tr>
                            <th>Filmweb</th>
                            <th>IMDb</th>
                            <th>Świat</th>
                            <th>Polska</th>
                            <th>Data wyp.</th>
                            <th>Data zwrotu</th>
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
            <td><xsl:value-of select="tytuł"/></td>
            <td><xsl:value-of select="reżyser"/></td>
            <td><xsl:value-of select="scenariusz"/></td>
            <td><xsl:value-of select="boxoffice[@waluta = 'USD']"/>
                <xsl:text> USD </xsl:text></td>
            <td><xsl:value-of select="boxoffice[@waluta = 'PLN']"/>
                <xsl:text> PLN </xsl:text></td>
            <td><a href="{oceny/filmweb/@link}"><xsl:value-of select="oceny/filmweb"/></a></td>
            <td><a href="{oceny/imdb/@link}"><xsl:value-of select="oceny/imdb"/></a></td>
            <td><xsl:value-of select="premiera/świat"/></td>
            <td><xsl:value-of select="premiera/polska"/></td>
            <td><xsl:value-of select="wypożyczenie/początek"/></td>
            <td><xsl:value-of select="wypożyczenie/koniec"/></td>
            <td><xsl:value-of select="wypożyczenie/ilość_dni"/></td>
        </tr>
    </xsl:template>
    
    <xsl:template match="//gatunkiRaport/gatunek">
        <tr>
            <td><xsl:value-of select="nazwa"/></td>
            <td><xsl:value-of select="ilość_filmów"/></td>
        </tr>
    </xsl:template>
    
    <xsl:template match="//krajeRaport/kraj">
        <tr>
            <td><xsl:value-of select="nazwa"/></td>
            <td><xsl:value-of select="ilość_filmów"/></td>
        </tr>
    </xsl:template>
    
    <xsl:template match="//filmyRaport">
        <tr>
            <td rowspan="2"><xsl:text>Ilość filmów</xsl:text></td>
            <td><xsl:text>Dostępnych</xsl:text></td>
            <td><xsl:value-of select="dostępne_filmy"/></td>
        </tr>
        <tr>
            <td><xsl:text>Niedostępnych</xsl:text></td>
            <td><xsl:value-of select="niedostępne_filmy"/></td>
        </tr>
        <tr>
            <td rowspan="2"><xsl:text>Średnia wartość boxoffice</xsl:text></td>
            <td><xsl:text>USD</xsl:text></td>
            <td><xsl:value-of select="śr_boxoffice[@waluta = 'USD']"/></td>
        </tr>
        <tr>
            <td><xsl:text>PLN</xsl:text></td>
            <td><xsl:value-of select="śr_boxoffice[@waluta = 'PLN']"/></td>
        </tr>
        <tr>
            <td rowspan="2"><xsl:text>Średnia ocen</xsl:text></td>
            <td><xsl:text>Filmweb</xsl:text></td>
            <td><xsl:value-of select="śr_filmweb"/></td>
        </tr>
        <tr>
            <td><xsl:text>IMDb</xsl:text></td>
            <td><xsl:value-of select="śr_imdb"/></td>
        </tr>
        <tr>
            <td rowspan="2"><xsl:text>Najwyżej oceniony film</xsl:text></td>
            <td><xsl:text>Filmweb</xsl:text></td>
            <td><xsl:value-of select="max_ocena_filmweb"/></td>
        </tr>
        <tr>
            <td><xsl:text>IMDb</xsl:text></td>
            <td><xsl:value-of select="max_ocena_imdb"/></td>
        </tr>
        <tr>
            <td rowspan="2"><xsl:text>Najniżej oceniony film</xsl:text></td>
            <td><xsl:text>Filmweb</xsl:text></td>
            <td><xsl:value-of select="min_ocena_filmweb"/></td>
        </tr>
        <tr>
            <td><xsl:text>IMDb</xsl:text></td>
            <td><xsl:value-of select="min_ocena_imdb"/></td>
        </tr>
        <tr>
            <td rowspan="2"><xsl:text>Najstarsza premiera</xsl:text></td>
            <td><xsl:text>Polska</xsl:text></td>
            <td><xsl:value-of select="najstarsza_premiera_polska"/></td>
        </tr>
        <tr>
            <td><xsl:text>Świat</xsl:text></td>
            <td><xsl:value-of select="najstarsza_premiera_świat"/></td>
        </tr>
        <tr>
            <td rowspan="2"><xsl:text>Najnowsza premiera</xsl:text></td>
            <td><xsl:text>Polska</xsl:text></td>
            <td><xsl:value-of select="najnowsza_premiera_polska"/></td>
        </tr>
        <tr>
            <td><xsl:text>Świat</xsl:text></td>
            <td><xsl:value-of select="najnowsza_premiera_świat"/></td>
        </tr>
        <tr>
            <td><xsl:text>Kurs waluty użyty do przeliczenia boxoffice</xsl:text></td>
            <td><xsl:text>PLN</xsl:text></td>
            <td><xsl:value-of select="kursUSD"/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
