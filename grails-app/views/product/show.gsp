

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>${fieldValue(bean:productInstance, field:'name')}</title>
        <g:javascript library="prototype"/>
    </head>
    <body>
            <p>
    <g:productCategoryBreadcrumbs category="${productInstance.category}"/>
  </p>
            <div id="product-head" class="span-20 last">
            <h2>${fieldValue(bean:productInstance, field:'name')}</h2>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            </div>
            <div class="span-7"><img src="${createLinkTo(dir: 'images', file: 'pirate_invitation.jpg')}" width="250"></div>
            <div class="span-13 last">
                <p>${fieldValue(bean:productInstance, field:'description')}<br/><br/>
                <strong><g:formatNumber format="\$0.00" number="${productInstance.price}"/></strong></p>
            </div>
            <g:ifAllGranted role="ROLE_ADMIN">

            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${productInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </g:form>
            </div>

            <g:form method="post" action="uploadProductImage" enctype="multipart/form-data">
		      <input type="file" name="newProductImage"/>
              %{--<g:submitToRemote update="imageUploaded"
                      value="Upload Image"
                      url="${[controller:'product',action:'uploadProductImage']}"/>--}%
              <g:submitButton value="Upload Image" name="uploadImage"/>
	        </g:form>

            <div id="imageUploaded"></div>
            </g:ifAllGranted>
    </body>
</html>
