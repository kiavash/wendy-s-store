<%@ page import="com.mattstine.wendysstore.domain.USState" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Add Shipping Address</title>
  <meta name="layout" content="main"/>
</head>
<body>
<div class="prepend-5 span-10 append-5">
  <h1>Add Shipping Address:</h1>

  <g:if test="${flash.message}">
    <div class="notice">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${address}">
    <div class="error">
      <g:renderErrors bean="${address}" as="list"/>
    </div>
  </g:hasErrors>

  <g:form action="saveShippingAddress">
    <g:hiddenField name="userId" value="${userId}"/>  
    <fieldset>

      <p><label>Default shipping address?</label><br/><g:checkBox name="defaultAddress" value="${address.defaultAddress}"/></p>

      <p><label>Name for this address (e.g. "Home")</label><br/>
      <g:textField name="name" class="text" value="${address.name}"/></p>

      <p><label for="addressLineOne">Address Line 1</label><br/>
      <g:textField name="addressLineOne" class="text" value="${address.addressLineOne}"/></p>

      <p><label for="addressLineTwo">Address Line 2</label><br/>
      <g:textField name="addressLineTwo" class="text" value="${address.addressLineTwo}"/></p>

      <p><label for="city">City</label><br/>
      <g:textField name="city" class="text" value="${address.city}"/></p>

      <p><label for="state">State</label><br/>
      <g:select name="state" from="${USState.values()}" optionValue="longName" value="${address.state}"/></p>

      <p><label for="zipCode">Zip Code</label><br/>
      <g:textField name="zipCode" class="text" value="${address.zipCode}"/></p>

      <p><label>Phone</label><br/>
      (<g:textField name="areaCode" size="3" value="${address.areaCode}"/>) <g:textField name="phonePrefix" size="3" value="${address.phonePrefix}"/>-<g:textField name="phoneSuffix" size="4" value="${address.phoneSuffix}"/></p>

      <p><g:submitButton name="addBtn" value="Add Shipping Address"/></p>

    </fieldset>
  </g:form>
</div>
</body>
</html>