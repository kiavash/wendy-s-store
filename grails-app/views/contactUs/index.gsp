<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Contact Us</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <script type="text/javascript" src="http://api.recaptcha.net/js/recaptcha_ajax.js"></script>
  <g:javascript>
    document.observe('dom:loaded', function() {

      Recaptcha.create('${publicKey}', 'recaptcha_container', {theme: 'white'});

      $('sendButton').observe('click', function() {
        new Ajax.Updater('ajaxMessage','${createLink(controller: 'contactUs', action: 'sendMessage')}',{evalScripts: true, parameters: Form.serialize(this.form)});
      });

    });
  </g:javascript>
</head>
<body>
<g:isLoggedIn>
  <g:set var="name" value="${loggedInUserInfo(field:'firstName') + ' ' + loggedInUserInfo(field:'lastName')}"/>
  <g:set var="email" value="${loggedInUserInfo(field:'email')}"/>
</g:isLoggedIn>
<div class="prepend-1 span-18 append-1">
  <h2>Contact Us</h2>
  <div id="ajaxMessage" class="notice" style="display: none"></div>
  <g:form name="contactUsForm">
    <fieldset>
      <p><label for="name">Name</label><br/>
        <g:textField name="msg.name" value="${name}" class="text"/></p>

      <p><label for="name">Email</label><br/>
        <g:textField name="msg.email" value="${email}" class="text"/></p>

      <p><label for="name">Message</label><br/>
        <g:textArea name="msg.message"/></p>

      <div id="recaptcha_container"></div>

      <p></p>
      
      <p><input id="sendButton" name="sendButton" value="Send" type="button"/></p>
    </fieldset>
  </g:form>
</div>
</body>
</html>