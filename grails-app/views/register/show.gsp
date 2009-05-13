<head>
  <meta name="layout" content="main"/>
  <title>User Profile</title>
</head>

<body>

<div class="prepend-1 span-18 append-1">
  <h1>My Account</h1>

  <h2>Customer Profile:</h2>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="dialog">
    <table>
      <tbody>

      <tr class="prop">
        <td valign="top" class="name"><strong>Login Name:</strong></td>
        <td valign="top" class="value">${person.username?.encodeAsHTML()}</td>
      </tr>

      <tr class="prop even">
        <td valign="top" class="name"><strong>First Name:</strong></td>
        <td valign="top" class="value">${person.firstName?.encodeAsHTML()}</td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><strong>Last Name:</strong></td>
        <td valign="top" class="value">${person.lastName?.encodeAsHTML()}</td>
      </tr>

      <!--<tr class="prop">-->
      <!--<td valign="top" class="name">Enabled:</td>-->
      %{--<td valign="top" class="value">${person.enabled}</td>--}%
      <!--</tr>-->

      <tr class="prop even">
        <td valign="top" class="name"><strong>Email:</strong></td>
        <td valign="top" class="value">${person.email?.encodeAsHTML()}</td>
      </tr>

      <tr class="prop">
      <td valign="top" class="name"><strong>Phone:</strong></td>
      <td valign="top" class="value">(${person.areaCode}) ${person.phonePrefix}-${person.phoneSuffix}</td>
      </tr>

      %{--<tr class="prop">--}%
      %{--<td valign="top" class="name">Roles:</td>--}%
      %{--<td valign="top" class="value">--}%
      %{--<ul>--}%
      %{--<g:each var='authority' in="${person.authorities}">--}%
      %{--<li>${authority.authority}</li>--}%
      %{--</g:each>--}%
      %{--</ul>--}%
      %{--</td>--}%
      %{--</tr>--}%

      </tbody>
    </table>
  </div>

  <div class="buttons">
    <g:form>
      <input type="hidden" name="id" value="${person.id}"/>
      <span class="button"><g:actionSubmit class='edit' value="Edit Your Profile"/></span>
    </g:form>
  </div>

  <br/><hr/>

  <div id="shippingAddresses">

    <h2>Saved Shipping Addresses:</h2>

    <p>(<g:link controller="register" action="addShippingAddress" params="${[userId:person.id]}">Add a New Shipping Address</g:link>)</p>
    

    <g:if test="${person.shippingAddresses.size() == 0}">
      None
    </g:if>
    <g:else>
      <ul>
      <g:each in="${person.shippingAddresses}" var="address">
        <li><strong>${address.name}</strong> <g:if test="${address.defaultAddress}"><em>(default)</em></g:if><br/>
        [<g:link action="editShippingAddress" id="${address.id}">Edit this Address</g:link>] [<g:link action="deleteShippingAddress" id="${address.id}">Delete this Address</g:link>]</li>
      </g:each>
    </g:else>
    </ul>

  </div>

</div>
</body>
