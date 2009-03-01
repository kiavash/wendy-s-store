<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>${category.breadcrumbs}</title>
  <meta name="layout" content="main"/>
</head>
<body>
<div class="span-20 last">
  <g:productCategoryBreadcrumbs category="${category}"/>
</div>
<g:each in="${category.products}" var="product" status="index">
<g:if test="${index % 3 == 0}">
<div class="span-20 last product-row">
</g:if>
<div class="span-5 prepend-1 product">
<img src="${createLinkTo(dir: 'images', file: 'bagshoes_note_main.gif')}">
  <h3><g:link controller="product" action="show" id="${product.id}">${product.name}</g:link></h3>
  
</div>

<g:if test="${index % 3 == 2}">
</div>
</g:if>
</g:each>

</body>
</html>