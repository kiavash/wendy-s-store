<html>
<head>
  <meta name="layout" content="main"/>
  <title>User Registration</title>
</head>

<body>

<div class="prepend-5 span-10 append-5">
  <h2>Register for an account:</h2>
  <g:if test="${flash.message}">
    <div class="notice">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${person}">
    <div class="error">
      <g:renderErrors bean="${person}" as="list"/>
    </div>
  </g:hasErrors>

  <g:form action="save">
    <fieldset>

<p><label for='username'>Login Name:</label><br/>
 <input type="text" name='username' value="${person?.username?.encodeAsHTML()}" class="text"/></p>

    <p><label for="firstName">First Name:</label><br/>
      <input type="text" id="firstName" name="firstName" value="${person.firstName?.encodeAsHTML()}" class="text"/>
    </p>

    <p><label for="lastName">Last Name:</label><br/>
      <input type="text" id="lastName" name="lastName" value="${person.lastName?.encodeAsHTML()}" class="text"/>
    </p>

    <p><label for='passwd'>Password:</label><br/>
      <input type="password" name='passwd' value="${person?.passwd?.encodeAsHTML()}" class="text"/>
    </p>

    <p><label for='enabled'>Confirm Password:</label><br/>
 <input type="password" name='repasswd' value="${person?.passwd?.encodeAsHTML()}" class="text"/>
  </p>

    <p><label for='email'>Email:</label><br/>
      <input type="text" name='email' value="${person?.email?.encodeAsHTML()}" class="text"/>
    </p>

    <p><label>Phone</label><br/>
      (<g:textField name="areaCode" size="3" value="${person.areaCode}"/>) <g:textField name="phonePrefix" size="3" value="${person.phonePrefix}"/>-<g:textField name="phoneSuffix" size="4" value="${person.phoneSuffix}"/></p>  

    <p>
      <recaptcha:ifEnabled>
        <recaptcha:recaptcha theme="white"/>
      </recaptcha:ifEnabled>
    </p>

      <p></p>

    <p><input type="submit" value="Register Me"/></p>


    </fieldset>

  </g:form>
</div>
</body>
</html>