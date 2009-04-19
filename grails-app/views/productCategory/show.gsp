

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>${fieldValue(bean:productCategoryInstance, field:'name')}</title>
    </head>
    <body>
        <div class="nav">
		<span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
		<span class="menuButton"><g:link class="list" action="list">Category List</g:link></span>
		<span class="menuButton"><g:link class="create" action="create">New Category</g:link></span>
	</div>
        <div class="body">
            <h1>${fieldValue(bean:productCategoryInstance, field:'name')}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                    
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:productCategoryInstance, field:'id')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Name:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:productCategoryInstance, field:'name')}</td>
                            
                        </tr>

                        <tr class="prop">
                          <td valign="top" class="name">Parent Category:</td>

                          <td valign="top" class="value">${fieldValue(bean:productCategoryInstance, field:'parentCategory.name')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Subcategories:</td>

                            <td  valign="top" style="text-align:left;" class="value">
                                <ul>
                                <g:each var="s" in="${productCategoryInstance.subCategories}">
                                    <li><g:link controller="productCategory" action="show" id="${s.id}">${s?.name?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>

                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Products:</td>
                            
                            <td  valign="top" style="text-align:left;" class="value">
                                <ul>
                                <g:each var="p" in="${productCategoryInstance.products}">
                                    <li><g:link controller="product" action="show" id="${p.id}">${p?.name?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${productCategoryInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
