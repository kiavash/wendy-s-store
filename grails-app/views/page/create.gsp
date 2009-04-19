<%@ page import="com.mattstine.wendysstore.domain.Page" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>Create Page</title>
  <g:javascript>
    document.observe("dom:loaded", function() {

        new Form.Element.Observer('pageContent', 2, function() {
          var pageContent = escape($('pageContent').value);
          new Ajax.Updater('pageContentPreview','${createLink(controller: 'page', action: 'preview')}',{asynchronous:true,evalScripts:true,parameters:'text='+pageContent});
        });

    });
  </g:javascript>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">Home</a></span>
  <span class="menuButton"><g:link class="list" action="list">Page List</g:link></span>
</div>
<div class="body">
  <h1>Create Page</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${pageInstance}">
    <div class="errors">
      <g:renderErrors bean="${pageInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form action="save" method="post">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="sidebarLinkTitle">Sidebar Link Title:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: pageInstance, field: 'sidebarLinkTitle', 'errors')}">
            <input type="text" id="sidebarLinkTitle" name="sidebarLinkTitle" value="${fieldValue(bean: pageInstance, field: 'sidebarLinkTitle')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="pageTitle">Page Title:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: pageInstance, field: 'pageTitle', 'errors')}">
            <input type="text" id="pageTitle" name="pageTitle" value="${fieldValue(bean: pageInstance, field: 'pageTitle')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="pageContent">Page Content:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: pageInstance, field: 'pageContent', 'errors')}">
            <textarea id="pageContent" rows="8" cols="38" name="pageContent">${fieldValue(bean: pageInstance, field: 'pageContent')}</textarea>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" colspan="2">
            <div id="pageContentPreview">${pageInstance?.pageContent?.encodeAsTextile()}</div>
          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><input class="save" type="submit" value="Create"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
