<g:set var="rowIndex" value="${0}"/>
<g:each in="${products}" var="product" status="index">
  <g:if test="${index % 3 == 0}">
    <div id="productRow${rowIndex}" class="span-20 last product-row">
  </g:if>
  <div id="product_${product.id}" class="span-6 product <g:if test="${(index % 3 == 2) || ((products.size() - index) == 1)}">last</g:if><g:else>append-1</g:else>">
    <img src="${resource(dir: grailsApplication.config.store.productImages.webPath, file: product?.thumbnailImage?.name)}" width="230" class="productImage">
    <h3><g:link controller="product" action="show" id="${product.id}">${product.name}</g:link></h3>
  </div>
  <g:if test="${(index % 3 == 2) || ((products.size() - index) == 1)}">
    </div>
    <g:set var="rowIndex" value="${rowIndex + 1}"/>
  </g:if>
</g:each>