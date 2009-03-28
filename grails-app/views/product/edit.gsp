<%@ page import="com.mattstine.wendysstore.domain.ProductCategory" %>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Editing Product #${fieldValue(bean:productInstance, field:'id')}</title>
      <gui:resources components="['richEditor']"/>
      
    </head>
    <body>
        
        <div class="body">
            <h1>Editing Product #${fieldValue(bean:productInstance, field:'id')}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${productInstance}">
            <div class="errors">
                <g:renderErrors bean="${productInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${productInstance?.id}" />
                <input type="hidden" name="version" value="${productInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:productInstance,field:'name','errors')}">
                                    <input type="text" id="name" name="name" value="${fieldValue(bean:productInstance,field:'name')}"/>
                                </td>
                            </tr>

                            %{--<tr class="prop">-->
                                <td valign="top" class="name">
                                    <label for="price">Price:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:productInstance,field:'price','errors')}">
                                    <input type="text" id="price" name="price" value="${fieldValue(bean:productInstance,field:'price')}" />
                                </td>
                            </tr>--}%

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description">Description:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:productInstance,field:'description','errors')}">
                                  <g:textArea name="description" id="description" value="${fieldValue(bean:productInstance,field:'description')}" rows="20" cols="40"/>
                                </td>
                            </tr>

                        <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="categories">Categories:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:productInstance,field:'categories','errors')}">
                                  <g:select id="category.id" name="category.id" from="${ProductCategory.list()}"
                                  value="${productInstance?.category?.id}" optionValue="breadcrumbs" optionKey="id"
                                />


                                    

                                </td>
                            </tr>

                        <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="featured">Featured:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:productInstance,field:'featured','errors')}">
                                  <g:checkBox name="featured" value="${true}" checked="${fieldValue(bean:productInstance,field:'featured')}"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
