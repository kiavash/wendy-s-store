<g:each in="${products}" var="product" status="index">
  <g:if test="${index % 3 == 0}">
    <div class="span-20 last product-row">
  </g:if>
  <div class="span-5 prepend-1 product">
    <img src="${createLinkTo(dir: 'images', file: 'pirate_invitation.jpg')}" width="192">
    <h3><g:link controller="product" action="show" id="${product.id}">${product.name}</g:link></h3>

  </div>

  <g:if test="${(index % 3 == 2) || ((products.size() - index) == 1)}">
    </div>
  </g:if>
</g:each>