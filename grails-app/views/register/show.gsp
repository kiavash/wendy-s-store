<head>
  <meta name="layout" content="main"/>
  <title>User Profile</title>
</head>

<body>

<div class="body">
  <h1>Your profile:</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="dialog">
    <table>
      <tbody>

      <tr class="prop">
        <td valign="top" class="name">Login Name:</td>
        <td valign="top" class="value">${person.username?.encodeAsHTML()}</td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name">First Name:</td>
        <td valign="top" class="value">${person.firstName?.encodeAsHTML()}</td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name">Last Name:</td>
        <td valign="top" class="value">${person.lastName?.encodeAsHTML()}</td>
      </tr>

      <!--<tr class="prop">-->
      <!--<td valign="top" class="name">Enabled:</td>-->
      %{--<td valign="top" class="value">${person.enabled}</td>--}%
      <!--</tr>-->

      <tr class="prop">
        <td valign="top" class="name">Email:</td>
        <td valign="top" class="value">${person.email?.encodeAsHTML()}</td>
      </tr>

      <tr class="prop">
      <td valign="top" class="name">Phone:</td>
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
      <span class="button"><g:actionSubmit class='edit' value="Edit"/></span>
    </g:form>
  </div>

  <div id="shippingAddresses">
    <h2>Shipping Addresses:</h2>

    <g:if test="${person.shippingAddresses.size() == 0}">
      None
    </g:if>
    <g:else>
      <ul>
      <g:each in="${person.shippingAddresses}" var="address">
        <li>${address.name} <g:if test="${address.defaultAddress}">(default)</g:if> [<g:link action="editShippingAddress" id="${address.id}">Edit</g:link>] [<g:link action="deleteShippingAddress" id="${address.id}">Delete</g:link>]</li>
      </g:each>
    </g:else>
    </ul>

    <p>(<g:link controller="register" action="addShippingAddress" params="${[userId:person.id]}">Add Shipping Address</g:link>)</p>
  </div>

</div>
</body>
