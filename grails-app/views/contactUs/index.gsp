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
  <p>Need to contact us? You can reach us in one of 3 easy ways!</p>
  <ol>
    <li>Fill out the form below, and we'll get back to you within 48 hours (during the week).</li>
    <li>Email us at <a href="mailto:duckduckgoosedesigns@yahoo.com">duckduckgoosedesigns@yahoo.com</a>.</li>
    <li>You can reach us by phone Monday through Friday from 9-4 (CST) at 901-493-7203.</li>
  </ol>
  <p>Any messages received over the weekend or on holidays will be returned within 48 hours from the next business day.</p>
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