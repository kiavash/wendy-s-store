<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>${fieldValue(bean: productCategoryInstance, field: 'name')}</title>
  <script type="text/javascript" src="${createLinkTo(dir: 'js/dojo', file: 'dojo.js')}"
          djConfig="parseOnLoad:true, isDebug:true"></script>
  <g:javascript>
    dojo.require("dojo.io.iframe");

    function submitForm() {
      dojo.io.iframe.send({
        form: 'uploadCategoryImageForm',
        load: function (data) {
          dojo.byId('categoryImageContainer').innerHTML = data;
        }
      });
    }
  </g:javascript>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">Home</a></span>
  <span class="menuButton"><g:link class="list" action="list">Category List</g:link></span>
  <span class="menuButton"><g:link class="create" action="create">New Category</g:link></span>
</div>
<div class="body">
  <h1>${fieldValue(bean: productCategoryInstance, field: 'name')}</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="dialog">
    <table>
      <tbody>

      <tr class="prop">
        <td valign="top" class="name">Id:</td>

        <td valign="top" class="value">${fieldValue(bean: productCategoryInstance, field: 'id')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Name:</td>

        <td valign="top" class="value">${fieldValue(bean: productCategoryInstance, field: 'name')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Description:</td>

        <td valign="top" class="value">${fieldValue(bean: productCategoryInstance, field: 'description')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Parent Category:</td>

        <td valign="top" class="value">${fieldValue(bean: productCategoryInstance, field: 'parentCategory.name')}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Subcategories:</td>

        <td valign="top" style="text-align:left;" class="value">
          <ul>
            <g:each var="s" in="${productCategoryInstance.subCategories}">
              <li><g:link controller="productCategory" action="show" id="${s.id}">${s?.name?.encodeAsHTML()}</g:link></li>
            </g:each>
          </ul>
        </td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Products:</td>

        <td valign="top" style="text-align:left;" class="value">
          <ul>
            <g:each var="p" in="${productCategoryInstance.products}">
              <li><g:link controller="product" action="show" id="${p.id}">${p?.name?.encodeAsHTML()}</g:link></li>
            </g:each>
          </ul>
        </td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">Image:</td>

        <td id="categoryImageContainer" valign="top" style="text-align:left;" class="value">
          <img src="${resource(dir: grailsApplication.config.store.productImages.webPath, file: productCategoryInstance?.image?.name)}" width="200" class="productImage">
        </td>

      </tr>

      </tbody>
    </table>
  </div>
  <div class="buttons">
    <g:form>
      <input type="hidden" name="id" value="${productCategoryInstance?.id}"/>
      <span class="button"><g:actionSubmit class="edit" value="Edit"/></span>
      <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
    </g:form>

    <g:form name="uploadCategoryImageForm" method="post" action="uploadCategoryImage" enctype="multipart/form-data">
      <input type="hidden" name="id" value="${productCategoryInstance?.id}"/>
      <input type="file" name="newCategoryImage"/>
      <input class="add" type="button" name="uploadImage" value="Upload Image" onclick="submitForm()"/>
    </g:form>
  </div>
</div>
</body>
</html>
