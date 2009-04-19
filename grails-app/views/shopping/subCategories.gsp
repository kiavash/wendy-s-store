<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>${category.name}</title>
    <meta name="layout" content="main" />
  </head>
  <body>
  <h3 class="indent"><g:productCategoryBreadcrumbs category="${category}"/></h3>
    <ul>
      <g:each in="${category.subCategories}" var="subCategory">
        <li><g:link controller="shopping" action="category" id="${subCategory.id}">${subCategory.name}</g:link> </li>
      </g:each>
    </ul>
  </body>
</html>