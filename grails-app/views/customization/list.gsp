<%@ page import="com.mattstine.wendysstore.domain.Customization" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>Customization List</title>
</head>
<body>
<div class="body">
  <h1>Customization List</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="list">
    <table>
      <thead>
      <tr>

        <g:sortableColumn property="id" title="Customization ID"/>

        <g:sortableColumn property="label" title="Label"/>

        <th>Type</th>

        <g:sortableColumn property="required" title="Required"/>

        <g:sortableColumn property="chargeable" title="Chargeable"/>


        <g:sortableColumn property="price" title="Price"/>

      </tr>
      </thead>
      <tbody>
      <g:each in="${customizationInstanceList}" status="i" var="customizationInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td><g:link action="show" id="${customizationInstance.id}">${fieldValue(bean: customizationInstance, field: 'id')}</g:link></td>

          <td>${fieldValue(bean: customizationInstance, field: 'label')}</td>
          <td>${fieldValue(bean: customizationInstance, field: 'type.labelText')}</td>

          <td><g:if test="${customizationInstance.required}">Yes</g:if><g:else>No</g:else> </td>

          <td><g:if test="${customizationInstance.chargeable}">Yes</g:if><g:else>No</g:else> </td>


          <td>${fieldValue(bean: customizationInstance, field: 'price')}</td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate total="${customizationInstanceTotal}"/>
  </div>
</div>
</body>
</html>
