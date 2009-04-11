<%@ page import="com.mattstine.wendysstore.domain.Customization" %>
<g:set var="customizationList" value="${Customization.list()}"/>
<select id="customizations" name="customizations" multiple="true">
  <g:each var="customization" in="${customizationList}">
    <g:if test="${productInstance?.customizations?.contains(customization)}">
      <option value="${customization.id}" selected>${customization.label}</option>
    </g:if>
    <g:else>
      <option value="${customization.id}">${customization.label}</option>
    </g:else>
  </g:each>

</select>