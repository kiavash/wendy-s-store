<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>${fieldValue(bean: productInstance, field: 'name')}</title>
  <script type="text/javascript" src="${createLinkTo(dir: 'js/dojo', file: 'dojo.js')}"
          djConfig="parseOnLoad:true, isDebug:true"></script>
  <g:javascript>
    dojo.require("dojo.io.iframe");

    function submitForm() {
      dojo.io.iframe.send({
        form: 'uploadProductImageForm',
        load: function (data) {
          dojo.byId('productImage').innerHTML = data;
        }
      });
    }
  </g:javascript>
  <g:javascript library="scriptaculous"/>
  <script type="text/javascript" src="${resource(dir: 'js', file: 'lightbox.js')}"></script>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'lightbox.css')}" type="text/css" media="screen"/>
</head>
<body>
<p>
  <g:productCategoryBreadcrumbs category="${productInstance.category}"/>
</p>
<div id="product-head" class="span-20 last">
  <h2>${fieldValue(bean: productInstance, field: 'name')}</h2>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div id="ajaxMessage" class="message" style="visibility: hidden"></div>
</div>
<div id="productContainer" class="span-20 last">
  <div id="productImage" class="span-7" style="text-align: center"><a href="${resource(dir: grailsApplication.config.store.productImages.webPath, file: productInstance?.fullSizeImage?.name)}" rel="lightbox"><img src="${resource(dir: grailsApplication.config.store.productImages.webPath, file: productInstance?.mediumImage?.name)}" width="250"><br/>Click to Enlarge</a></div>
  <div class="span-13 last">
  <p>${fieldValue(bean: productInstance, field: 'description')}<br/><br/>
    <g:form name="addToCartForm">
      <g:if test="${productInstance.prices.size() > 1}">
        <g:select id="priceId" name="priceId" from="${productInstance.prices}"
                optionValue="display" optionKey="id"/>
      </g:if>
      <g:else>
        <g:if test="${productInstance.prices.size() == 1}">
          <g:hiddenField name="priceId" value="${productInstance.prices[0].id}"/>
          <strong><g:formatNumber format="\$0.00" number="${productInstance.prices[0].price}"/></strong></p>
        </g:if>
        <g:else>
          <strong>No Price Set!!!</strong>
        </g:else>
      </g:else>
      <g:hiddenField name="id" value="${productInstance.id}"/>
      <g:textField name="quantity" value="1"/>
      <g:submitToRemote name="addToCartButton"
              value="Add to Cart"
              update="ajaxMessage"
              url="[controller:'shopping',action:'addProductToCart']"/>
    </g:form>
  </div>
</div>
<g:ifAllGranted role="ROLE_ADMIN">
  <div id="buttonContainer" class="span-20 last">
    <div class="span-5">&nbsp;</div>
    <div class="buttons span-10" style="text-align: center">
      <g:form>
        <input type="hidden" name="id" value="${productInstance?.id}"/>
        <span class="button"><g:actionSubmit class="edit" value="Edit"/></span>
        <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
      </g:form>

      <g:form name="uploadProductImageForm" method="post" action="uploadProductImage" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${productInstance?.id}"/>
        <input type="file" name="newProductImage"/>
        <span class="button"><input class="add" type="button" name="uploadImage" value="Upload Image" onclick="submitForm()"/></span>
      </g:form>

    </div>

    <div class="span-5 last">&nbsp;</div>
  </div>
  <div class="dialog span-20 last" style="text-align: center">
    <g:form name="addPriceForm" method="post">
      <input type="hidden" name="productId" value="${productInstance?.id}"/>
      <input type="hidden" name="id" value="${priceInstance?.id}"/>
      <label for="description">Description:</label><g:textField name="description" value="${priceInstance.description}"/>
      <label for="price">Price:</label><g:textField name="price" value="${priceInstance.price}"/>
      <span class="button">
        <g:if test="${priceInstance?.id == null}">
          <g:actionSubmit class="add" value="Add Price" action="addPrice"/>
        </g:if>
        <g:else>
          <g:actionSubmit class="add" value="Update Price" action="updatePrice"/>
        </g:else>
      </span>
    </g:form>
  </div>
  <div class="list span-20 last" style="text-align: center">
    <table class="datatable">
      <thead>
      <tr>

        <g:sortableColumn property="name" title="Description"/>

        <g:sortableColumn property="price" title="Price"/>

        <th>&nbsp;</th>

        <th>&nbsp;</th>

      </tr>
      </thead>
      <tbody>
      <g:each in="${productInstance.prices}" status="i" var="priceInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td>${fieldValue(bean: priceInstance, field: 'description')}</td>

          <td><g:formatNumber number="${priceInstance.price}" format="\$0.00"/></td>

          <td class="buttons">
            <g:form action="editPrice">
              <g:hiddenField name="id" value="${priceInstance.id}"/>
              <g:hiddenField name="productId" value="${productInstance.id}"/>
              <span class="button"><g:submitButton name="editPrice" class="edit" value="Edit"/></span>
            </g:form>
          </td>

          <td class="buttons">
            <g:form action="deletePrice">
              <g:hiddenField name="productId" value="${productInstance.id}"/>
              <g:hiddenField name="id" value="${priceInstance.id}"/>
              <span class="button"><g:submitButton class="delete" name="deletePrice" onclick="return confirm('Are you sure?');" value="Delete"/></span>
            </g:form>

          </td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>

</g:ifAllGranted>
</body>
</html>
