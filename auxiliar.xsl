<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:variable name="Normal" select="mapaExames/calendario/epoca[regime='Normal' and numSemestre='1']"/>
    <xsl:variable name="Recurso" select="mapaExames/calendario/epoca[regime='Recurso' and numSemestre='1']"/>
    <xsl:variable name="Especial" select="mapaExames/calendario/epoca[regime='Especial']"/>
    
    <xsl:template match="/">
        
        <html>
            <head>
                <title>Mapa Exames</title>
            </head>
            <body>
                <xsl:for-each select="mapaExames/curso">
                    <h2><b><center><xsl:value-of select="@nivel"/> em <xsl:value-of select="nome"/></center></b></h2>
                </xsl:for-each>
                <p><b><font size="4">Época <xsl:value-of select="$Normal/regime"/></font></b></p>
                <p><font size="3"><xsl:value-of select="$Normal/format-date(dataInicio,'[D]/[M]/[Y]')"/> a <xsl:value-of select="$Normal/format-date(dataFim,'[D]/[M]/[Y]')"/></font></p>
                
                <table border="1">
                    <tr>
                        <td><b><center>Dia</center></b></td>
                        <td><b><center>Ano</center></b></td>
                        <td><b><center>Unidade Curricular</center></b></td>
                        <td><b><center>Hora</center></b></td>
                        <td><b><center>Sala</center></b></td>
                        <td><b><center>Responsavel</center></b></td>
                    </tr>
                    <xsl:for-each-group select="mapaExames/curso/unidades/unidade[@semestre=$Normal/numSemestre]/exames/exame[epoca=$Normal/regime]" group-by="data">
                        <xsl:sort select="data"/>
                        <xsl:sort select="hora"/>
                        <tr><xsl:call-template name="organizado"/></tr> 
                        
                    </xsl:for-each-group> 
                </table>
                
                <br></br>
                <p><b><font size="4">Época <xsl:value-of select="$Recurso/regime"/></font></b></p>
                <p><font size="3"><xsl:value-of select="$Recurso/format-date(dataInicio,'[D]/[M]/[Y]')"/> a <xsl:value-of select="$Recurso/format-date(dataFim,'[D]/[M]/[Y]')"/></font></p>
                
                <table border="1">
                    <tr>
                        <td><b><center>Dia</center></b></td>
                        <td><b><center>Ano</center></b></td>
                        <td><b><center>Unidade Curricular</center></b></td>
                        <td><b><center>Hora</center></b></td>
                        <td><b><center>Sala</center></b></td>
                        <td><b><center>Responsavel</center></b></td>
                    </tr>
                    <xsl:for-each-group select="mapaExames/curso/unidades/unidade[@semestre=$Recurso/numSemestre]/exames/exame[epoca=$Recurso/regime]" group-by="data">
                        <xsl:sort select="data"/>
                        <xsl:sort select="hora"/>
                        <tr><xsl:call-template name="organizado"/></tr>                   
                    </xsl:for-each-group> 
                </table>
                
                <br></br>
                <p><b><font size="4">Época <xsl:value-of select="$Especial/regime"/></font></b></p>
                <p><font size="3"><xsl:value-of select="$Especial/format-date(dataInicio,'[D]/[M]/[Y]')"/> a <xsl:value-of select="$Especial/format-date(dataFim,'[D]/[M]/[Y]')"/></font></p>
                
                <table border="1">
                    <tr>
                        <td><b><center>Dia</center></b></td>
                        <td><b><center>Ano</center></b></td>
                        <td><b><center>Unidade Curricular</center></b></td>
                        <td><b><center>Hora</center></b></td>
                        <td><b><center>Sala</center></b></td>
                        <td><b><center>Responsavel</center></b></td>
                    </tr>
                    <xsl:for-each-group select="mapaExames/curso/unidades/unidade/exames/exame[epoca=$Especial/regime]" group-by="data">
                        <xsl:sort select="data"/>
                        <xsl:sort select="hora"/>
                        <tr><xsl:call-template name="organizado"/></tr>                   
                    </xsl:for-each-group> 
                </table>
            </body>
        </html>       
    </xsl:template>
    
 
    <xsl:template name="organizado">     
        <td><xsl:call-template name="data"/></td>
        <td><xsl:call-template name="anoUnidade"/></td>
        <td><xsl:call-template name="nomeUC"/></td> 
        <td><xsl:call-template name="hora"/></td> 
        <td><xsl:call-template name="tipoSala"/></td> 
        <td><xsl:call-template name="docente"/></td>  
    </xsl:template>
        
    <xsl:template name="docente">
        <xsl:for-each select="current-group()">
            <p><xsl:value-of select="responsavel"/></p>  
        </xsl:for-each>  
    </xsl:template>
    
    <xsl:template name="nomeUC">
        <xsl:for-each select="current-group()">
            <p><xsl:value-of select="ancestor::node()/ancestor::node()/nomeUC"/> - (<xsl:value-of select="tipologia"/>)</p>  
        </xsl:for-each>  
    </xsl:template>

    <xsl:template name="tipoSala">
        <xsl:for-each select="current-group()">
            <p><xsl:value-of select="sala"/></p>  
        </xsl:for-each>  
    </xsl:template>
          
    <xsl:template name="anoUnidade">
        <xsl:for-each select="current-group()">
            <p><xsl:value-of select="ancestor::node()/ancestor::node()/anoCurricular"/>.º</p>  
        </xsl:for-each>  
    </xsl:template>
    
    <xsl:template name="data">
        <p><center><xsl:value-of select="format-date(data,'[D]')"/></center></p>
        <p><center><xsl:value-of select="format-date(data,'[F]')"/></center></p>
    </xsl:template>
    
    <xsl:template name="hora">
        <xsl:for-each select="current-group()">
            <p><xsl:value-of select="format-time(hora,'[H01]:[m01]')"/></p>
        </xsl:for-each>  
    </xsl:template>
   
    
</xsl:stylesheet>