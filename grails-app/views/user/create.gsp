<head>
  <meta name="layout" content="main"/>
  <title>Create User</title>
</head>

<body>

<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">Home</a></span>
  <span class="menuButton"><g:link class="list" action="list">User List</g:link></span>
</div>

<div class="body">
  <h1>Create User</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${person}">
    <div class="errors">
      <g:renderErrors bean="${person}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form action="save">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name"><label for="username">Login Name:</label></td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'username', 'errors')}">
            <input type="text" id="username" name="username" value="${person.username?.encodeAsHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><label for="firstName">First Name:</label></td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'firstName', 'errors')}">
            <input type="text" id="firstName" name="firstName" value="${person.firstName?.encodeAsHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><label for="lastName">Last Name:</label></td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'lastName', 'errors')}">
            <input type="text" id="lastName" name="lastName" value="${person.lastName?.encodeAsHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><label for="passwd">Password:</label></td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'passwd', 'errors')}">
            <input type="password" id="passwd" name="passwd" value="${person.passwd?.encodeAsHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><label for="enabled">Enabled:</label></td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'enabled', 'errors')}">
            <g:checkBox name="enabled" value="${person.enabled}"></g:checkBox>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><label for="description">Description:</label></td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'description', 'errors')}">
            <input type="text" id="description" name="description" value="${person.description?.encodeAsHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><label for="email">Email:</label></td>
          <td valign="top" class="value ${hasErrors(bean: person, field: 'email', 'errors')}">
            <input type="text" id="email" name="email" value="${person.email?.encodeAsHTML()}"/>
          </td>
        </tr>

        <tr class='prop'>
          <td valign='top' class='name'><label>Phone:</label></td>
          <td valign='top' class='value'>
            (<g:textField name="areaCode" size="3" value="${person.areaCode}"/>) <g:textField name="phonePrefix" size="3" value="${person.phonePrefix}"/>-<g:textField name="phoneSuffix" size="4" value="${person.phoneSuffix}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name" align="left">Assign Roles:</td>
        </tr>

        <g:each in="${authorityList}">
          <tr>
            <td valign="top" class="name" align="left">${it.authority.encodeAsHTML()}</td>
            <td align="left"><g:checkBox name="${it.authority}"/></td>
          </tr>
        </g:each>

        </tbody>
      </table>
    </div>

    <div class="buttons">
      <span class="button"><input class="save" type="submit" value="Create"/></span>
    </div>

  </g:form>

</div>
</body>
