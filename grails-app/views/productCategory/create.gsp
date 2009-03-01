<%@ page import="com.mattstine.wendysstore.domain.ProductCategory" %>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Create a New Category</title>
    </head>
    <body>
        
        <div class="body">
            <h1>Create a New Category</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${productCategoryInstance}">
            <div class="errors">
                <g:renderErrors bean="${productCategoryInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:productCategoryInstance,field:'name','errors')}">
                                    <input type="text" id="name" name="name" value="${fieldValue(bean:productCategoryInstance,field:'name')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                              <td valign="top" class="name">
                                <label for="parentCategory">Parent Category:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:productCategoryInstance,field:'parentCategory','errors')}">
                                <g:select id="parentCategory.id" name="parentCategory.id" from="${ProductCategory.findAllMinusMe(productCategoryInstance)}"
                                  value="${productCategoryInstance?.parentCategory?.id}" optionValue="breadcrumbs" optionKey="id"
                                  noSelection="${['null':'No Parent']}"
                                />
                              </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Create" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
