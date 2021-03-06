<xsl:stylesheet xmlns:lta="http://www.w3.org/2005/08/lta/"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="lta">

  <xsl:param name="startBold">&lt;span class="element"&gt;</xsl:param>
  <xsl:param name="endBold">&lt;/span&gt;</xsl:param>
  <xsl:param name="startItalic">&lt;span class="attribute"&gt;</xsl:param>
  <xsl:param name="endItalic">&lt;/span&gt;</xsl:param>
  <xsl:param name="startRed">&lt;span style="color:red"&gt;</xsl:param>
  <xsl:param name="endRed">&lt;/span&gt;</xsl:param>
  <xsl:param name="spaceCharacter">&#160;</xsl:param>
  <xsl:param name="startRTL">&lt;span dir="rtl"&gt;</xsl:param>
  <xsl:param name="endRTL">&lt;/span&gt;</xsl:param>
  <xsl:param name="startAval">&lt;span class="aval"&gt;</xsl:param>
  <xsl:param name="endAval">&lt;/span&gt;</xsl:param>
  <xsl:template name="lineBreak">
    <xsl:param name="id"/>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>


  <xsl:template match="text()" mode="verbatim">
    <xsl:choose>
      <xsl:when test="normalize-space(.)=''">
        <xsl:for-each select="following-sibling::*[1]">
          <xsl:call-template name="lineBreak">
            <xsl:with-param name="id">7</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="makeIndent"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="wraptext">
          <xsl:with-param name="indent">
            <xsl:for-each select="parent::*">
              <xsl:call-template name="makeIndent"/>
            </xsl:for-each>
          </xsl:with-param>
          <xsl:with-param name="text">
            <xsl:value-of select="."/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="comment()" mode="verbatim">
    <xsl:text>&#10;&lt;!--</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>--&gt;&#10;</xsl:text>

  </xsl:template>


  <xsl:template name="wraptext">
    <xsl:param name="indent"/>
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="$text='&#10;'"/>
      <xsl:when test="contains($text,'&#10;')">
        <xsl:value-of select="substring-before($text,'&#10;')"/>
        <xsl:call-template name="lineBreak">

          <xsl:with-param name="id">6</xsl:with-param>
        </xsl:call-template>
        <xsl:value-of select="$indent"/>
        <xsl:call-template name="wraptext">
          <xsl:with-param name="indent">
            <xsl:value-of select="$indent"/>
          </xsl:with-param>
          <xsl:with-param name="text">

            <xsl:value-of select="substring-after($text,'&#10;')"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="verbatim">
    <xsl:choose>
      <xsl:when test="not(preceding-sibling::node())">
        <xsl:call-template name="lineBreak">
          <xsl:with-param name="id">2</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="makeIndent"/>
      </xsl:when>

      <xsl:when test="preceding-sibling::node()[1]/self::*">
        <xsl:call-template name="lineBreak">
          <xsl:with-param name="id">1</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="makeIndent"/>
      </xsl:when>
      <xsl:when test="preceding-sibling::node()[1]/self::text()"> </xsl:when>

      <xsl:otherwise>
        <xsl:call-template name="lineBreak">
          <xsl:with-param name="id">9</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="makeIndent"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:value-of disable-output-escaping="yes" select="$startBold"/>
    <xsl:text>&lt;</xsl:text>
    <xsl:choose>
      <xsl:when test="namespace-uri()='http://www.w3.org/2005/08/lta/'">
        <xsl:text>lta:</xsl:text>
        <xsl:value-of select="local-name(.)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="local-name(.)"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of disable-output-escaping="yes" select="$endBold"/>
    <xsl:if test="not(parent::*)">
      <xsl:text disable-output-escaping="yes">&#160;&lt;span class="attribute"&gt;xmlns:lta&lt;/span&gt;="&lt;span class="aval"&gt;http://www.w3.org/2008/05/lta/&lt;/span&gt;"</xsl:text>
    </xsl:if>

    <xsl:for-each select="@*">
      <xsl:if
        test="count(../@*)&gt;3 or string-length(.) &gt; 60 or string-length(../@*)&gt;60 or namespace-uri()='http://www.w3.org/2005/11/its'">
        <xsl:call-template name="lineBreak">

          <xsl:with-param name="id">5</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="makeIndent"/>
      </xsl:if>
      <xsl:text>&#160;</xsl:text>
      <xsl:value-of disable-output-escaping="yes" select="$startItalic"/>
      <xsl:choose>
        <xsl:when test="namespace-uri()='http://www.w3.org/2008/05/lta/'">

          <xsl:text>lta:</xsl:text>
        </xsl:when>
      </xsl:choose>
      <xsl:value-of select="local-name(.)"/>
      <xsl:value-of disable-output-escaping="yes" select="$endItalic"/>
      <xsl:text>="</xsl:text>
      <xsl:value-of disable-output-escaping="yes" select="$startAval"/>
      <xsl:value-of select="."/>
      <xsl:value-of disable-output-escaping="yes" select="$endAval"/>
      <xsl:text>"</xsl:text>
    </xsl:for-each>
    <xsl:choose>
      <xsl:when test="child::node()">
        <xsl:value-of select="$startBold" disable-output-escaping="yes"/>
        <xsl:text>&gt;</xsl:text>
        <xsl:value-of select="$endBold" disable-output-escaping="yes"/>
        <xsl:apply-templates mode="verbatim"/>

        <xsl:choose>
          <xsl:when test="child::node()[last()]/self::text()[normalize-space(.)='']">
            <xsl:call-template name="lineBreak">
              <xsl:with-param name="id">3</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="makeIndent"/>
          </xsl:when>
          <xsl:when test="child::node()[last()]/self::comment()">
            <xsl:call-template name="lineBreak">

              <xsl:with-param name="id">4</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="makeIndent"/>
          </xsl:when>
          <xsl:when test="child::node()[last()]/self::*">
            <xsl:call-template name="lineBreak">
              <xsl:with-param name="id">5</xsl:with-param>
            </xsl:call-template>

            <xsl:call-template name="makeIndent"/>
          </xsl:when>
        </xsl:choose>
        <xsl:value-of disable-output-escaping="yes" select="$startBold"/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:choose>
          <xsl:when test="namespace-uri()='http://www.w3.org/2005/08/lta/'">
            <xsl:text>lta:</xsl:text>
            <xsl:value-of select="local-name(.)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="local-name(.)"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&gt;</xsl:text>        
        <xsl:value-of disable-output-escaping="yes" select="$endBold"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>/&gt;</xsl:text>
        <xsl:value-of disable-output-escaping="yes" select="$endBold"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="makeIndent">
    <xsl:for-each select="ancestor::*">
      <xsl:value-of select="$spaceCharacter"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
