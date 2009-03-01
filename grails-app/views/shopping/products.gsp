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
<g:render template="/productThumbs" model="${[products:category.products]}"/>
</body>
</html>