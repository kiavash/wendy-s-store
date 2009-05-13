<%@ page import="com.mattstine.wendysstore.domain.ProductCategory" %>


<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>Editing Category #${fieldValue(bean: productCategoryInstance, field: 'id')}</title>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">Home</a></span>
  <span class="menuButton"><g:link class="list" action="list">Category List</g:link></span>
  <span class="menuButton"><g:link class="create" action="create">New Category</g:link></span>
</div>
<div class="body">
  <h1>Editing Category #${fieldValue(bean: productCategoryInstance, field: 'id')}</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${productCategoryInstance}">
    <div class="errors">
      <g:renderErrors bean="${productCategoryInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form method="post">
    <input type="hidden" name="id" value="${productCategoryInstance?.id}"/>
    <input type="hidden" name="version" value="${productCategoryInstance?.version}"/>
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="name">Name:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: productCategoryInstance, field: 'name', 'errors')}">
            <input type="text" id="name" name="name" value="${fieldValue(bean: productCategoryInstance, field: 'name')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="description">Description:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: productCategoryInstance, field: 'description', 'errors')}">
            <g:textArea name="description" id="description" value="${fieldValue(bean:productCategoryInstance,field:'description')}" rows="20" cols="40"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="parentCategory">Parent Category:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: productCategoryInstance, field: 'parentCategory', 'errors')}">
            <g:select id="parentCategory.id" name="parentCategory.id" from="${ProductCategory.findAllMinusMe(productCategoryInstance)}"
                    value="${productCategoryInstance?.parentCategory?.id}" optionValue="name" optionKey="id"
                    noSelection="${['null':'No Parent']}"/>
          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><g:actionSubmit class="save" value="Update"/></span>
      <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
