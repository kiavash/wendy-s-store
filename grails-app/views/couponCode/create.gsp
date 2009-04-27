<%@ page import="com.mattstine.wendysstore.domain.CouponCode" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>Create CouponCode</title>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">Home</a></span>
  <span class="menuButton"><g:link class="list" action="list">CouponCode List</g:link></span>
</div>
<div class="body">
  <h1>Create CouponCode</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${couponCodeInstance}">
    <div class="errors">
      <g:renderErrors bean="${couponCodeInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form action="save" method="post">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="code">Code:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: couponCodeInstance, field: 'code', 'errors')}">
            <input type="text" id="code" name="code" value="${fieldValue(bean: couponCodeInstance, field: 'code')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="type">Type:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: couponCodeInstance, field: 'type', 'errors')}">
            <g:select from="${com.mattstine.wendysstore.domain.CouponCodeType?.values()}" value="${couponCodeInstance?.type}" name="type" optionValue="labelText"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="amount">Amount:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: couponCodeInstance, field: 'amount', 'errors')}">
            <input type="text" id="amount" name="amount" value="${fieldValue(bean: couponCodeInstance, field: 'amount')}"/>
          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><input class="save" type="submit" value="Create"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
