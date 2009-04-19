<%@ page import="com.mattstine.wendysstore.domain.Page" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>Show Page</title>
  <g:javascript>
    document.observe("dom:loaded", function() {

          var pageContent = escape($('content').innerHTML);
          new Ajax.Updater('pageContent','${createLink(controller: 'page', action: 'preview')}',{asynchronous:true,evalScripts:true,parameters:'text='+pageContent});

    });
  </g:javascript>
</head>
<body>
<div id="content" style="display: none">${pageInstance.pageContent}</div>
<g:ifAllGranted role="ROLE_ADMIN">
  <div class="nav">
    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">Home</a></span>
    <span class="menuButton"><g:link class="list" action="list">Page List</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">New Page</g:link></span>
  </div>
</g:ifAllGranted>
<div class="prepend-2 span-16 append-2">
  <g:if test="${flash.message}">
    <div class="prepend-2 span-16 append-2 message">${flash.message}</div>
  </g:if>
  <h2>${pageInstance.pageTitle}</h2>

  <div id="pageContent"></div>
  <g:ifAllGranted role="ROLE_ADMIN">
    <div class="buttons">
      <g:form>
        <input type="hidden" name="id" value="${pageInstance?.id}"/>
        <span class="button"><g:actionSubmit class="edit" value="Edit"/></span>
        <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
      </g:form>
    </div>
  </g:ifAllGranted>
</div>
</body>
</html>
