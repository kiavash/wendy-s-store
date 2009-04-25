<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Contact Us</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
</head>
<body>
<g:isLoggedIn>
  <g:set var="name" value="${loggedInUserInfo(field:'firstName') + ' ' + loggedInUserInfo(field:'lastName')}"/>
  <g:set var="email" value="${loggedInUserInfo(field:'email')}"/>
</g:isLoggedIn>
<div class="prepend-1 span-18 append-1">
  <h2>Contact Us</h2>
  <div id="ajaxMessage" class="notice" style="display: none"></div>
  <g:form>
    <fieldset>
      <p><label for="name">Name</label><br/>
        <g:textField name="msg.name" value="${name}" class="text"/></p>

      <p><label for="name">Email</label><br/>
        <g:textField name="msg.email" value="${email}" class="text"/></p>

      <p><label for="name">Message</label><br/>
        <g:textArea name="msg.message"/></p>

      <p>
        <recaptcha:ifEnabled>
          <recaptcha:recaptcha theme="white"/>
        </recaptcha:ifEnabled>
      </p>

      <p></p>
      

      <p><g:submitToRemote url="[controller: 'contactUs', action: 'sendMessage']" name="sendMessageButton" value="Send" update="ajaxMessage"/></p>
    </fieldset>
  </g:form>
</div>
</body>
</html>