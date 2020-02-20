<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:x="http://purl.org/net/xml2rfc/ext"
               xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'
               version="1.0"
               exclude-result-prefixes="rdf x"
>

<xsl:output indent="yes" omit-xml-declaration="yes"/>

<!-- character translation tables -->
<xsl:variable name="lcase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="ucase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

<xsl:template match="/">
  <xsl:variable name="table">
    <table align="left" anchor="iana.header.registration.table">
      <thead>
        <tr>
          <th>Field Name</th>
          <th>Status</th>
          <th>Reference</th>
        </tr>
      </thead>
      <xsl:text>&#10;</xsl:text>
      <tbody>
        <xsl:apply-templates select="//section[iref[@item='Fields' and @primary='true']]">
          <xsl:sort select="translate(iref[@item='Fields' and @primary='true']/@subitem,$ucase,$lcase)"/>
        </xsl:apply-templates>
      </tbody>
    </table>
    <xsl:text>&#10;</xsl:text>
  </xsl:variable>

  <xsl:comment>AUTOGENERATED FROM extract-header-defs.xslt, do not edit manually</xsl:comment>
  <xsl:text>&#10;</xsl:text>
  <xsl:copy-of select="$table"/>
  <xsl:comment>(END)</xsl:comment>
  <xsl:text>&#10;</xsl:text>
  
  <!-- check against current version -->
  <xsl:variable name="oldtable" select="//texttable[@anchor='iana.header.registration.table']" />

  <xsl:variable name="s">
    <xsl:apply-templates select="$table//texttable" mode="tostring"/>
  </xsl:variable>
  
  <xsl:variable name="s1">
    <xsl:apply-templates select="$oldtable" mode="tostring"/>
  </xsl:variable>

  <xsl:if test="$s != $s1">
    <xsl:message>WARNING: table contained inside source document needs to be updated</xsl:message>
    <xsl:message><xsl:value-of select="$s"/></xsl:message>
    <xsl:message><xsl:value-of select="$s1"/></xsl:message>
  </xsl:if>

</xsl:template>

<xsl:template match="*" mode="tostring">
  <xsl:text>&lt;</xsl:text>
  <xsl:value-of select="name()"/>
  <xsl:for-each select="@*">
    <xsl:sort select="name()"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="name()"/>
    <xsl:text>=</xsl:text>
    <xsl:value-of select="."/>
  </xsl:for-each>
  <xsl:text>&gt;</xsl:text>
  
  <xsl:apply-templates select="node()" mode="tostring"/>
  
  <xsl:text>&lt;/</xsl:text>
  <xsl:value-of select="name()"/>
  <xsl:text>&gt;</xsl:text>

</xsl:template>

<xsl:template match="text()" mode="tostring">
  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="table/text()" mode="tostring"/>
<xsl:template match="tr/text()" mode="tostring"/>
<xsl:template match="thead/text()" mode="tostring"/>
<xsl:template match="tbody/text()" mode="tostring"/>
<xsl:template match="td[xref]/text()" mode="tostring"/>

<xsl:template match="section">
  <xsl:variable name="status" xmlns:p2="urn:ietf:id:draft-ietf-httpbis-p2-semantics#">
    <xsl:choose>
      <xsl:when test="rdf:Description/p2:status"><xsl:value-of select="rdf:Description/p2:status"/></xsl:when>
      <xsl:otherwise>standard</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="t" select="iref[@item='Fields']/@subitem"/>
  <xsl:text>&#10;</xsl:text>
  <tr>
    <td><xsl:value-of select="$t"/></td>
    <td><xsl:value-of select="$status"/></td>
    <td><xref target="{@anchor}"/></td>
  </tr>  
</xsl:template>

</xsl:transform>
