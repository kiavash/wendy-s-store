<head>
  <meta name="layout" content="main"/>
  <title>Edit Profile</title>
</head>

<body>

<div class="body">
  <h1>Edit your profile:</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${person}">
    <div class="errors">
      <g:renderErrors bean="${person}" as="list"/>
    </div>
  </g:hasErrors>

  <g:form>
    <input type="hidden" name="id" value="${person.id}"/>
    <input type="hidden" name="version" value="${person.version}"/>
    <div class="dialog">
      <table>
        <tbody>
        <tr class='prop'>
          <td valign='top' class='name'><label for='username'>Login Name:</label></td>
          <td valign='top' class='value ${hasErrors(bean: person, field: 'username', 'errors')}'>
            <input type="hidden" name='username' value="${person.username?.encodeAsHTML()}"/>
            <div style="margin:3px">${person.username?.encodeAsHTML()}</div>
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

        <tr class='prop'>
          <td valign='top' class='name'><label for='passwd'>Password:</label></td>
          <td valign='top' class='value ${hasErrors(bean: person, field: 'passwd', 'errors')}'>
            <input type="password" name='passwd' value=""/>
          </td>
        </tr>

        <tr class='prop'>
          <td valign='top' class='name'><label for='enabled'>Confirm Password:</label></td>
          <td valign='top' class='value ${hasErrors(bean: person, field: 'passwd', 'errors')}'>
            <input type="password" name='repasswd'/>
          </td>
        </tr>

        <tr class='prop'>
          <td valign='top' class='name'><label for='email'>Email:</label></td>
          <td valign='top' class='value ${hasErrors(bean: person, field: 'email', 'errors')}'>
            <input type="text" name='email' value="${person.email?.encodeAsHTML()}"/>
          </td>
        </tr>

        <!--<tr class='prop'>-->
          <!--<td valign='top' class='name'><label for='emailShow'>Show Email:</label></td>-->
          %{--<td valign='top' class='value ${hasErrors(bean: person, field: 'emailShow', 'errors')}'>--}%
            %{--<g:checkBox name='emailShow' value="${person.emailShow}"></g:checkBox>--}%
          <!--</td>-->
        <!--</tr>-->

        </tbody>
      </table>
    </div>

    <div class="buttons">
      <span class="button"><g:actionSubmit class='save' value="Update"/></span>
    </div>

  </g:form>

</div>
</body>
