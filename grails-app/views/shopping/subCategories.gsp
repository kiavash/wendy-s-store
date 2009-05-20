<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>${category.name}</title>
  <meta name="layout" content="main"/>
  <g:ifAllGranted role="ROLE_ADMIN">
    <g:javascript>
    function updateRows(list) {
      var children = list.childElements();

      if (children.size() < 3) {

        //If I'm the last row, who cares!
        if (list.next() != null) {
          var prevRow = list.previous();

          if (prevRow != null) {
            var lastChild = prevRow.childElements()[prevRow.childElements().size() - 1].remove();
            list.insert({top:lastChild});
            updateRows(prevRow);
          } else {
            var lastRow = list.up().childElements()[list.up().childElements().size() - 1];
            var lastChild = lastRow.childElements()[lastRow.childElements().size() - 1].remove();
            list.insert({top:lastChild});
            updateRows(lastRow);
          }
        }
      } else if (children.size() == 3) {
        //Do nothing...gets me out of the recursion I hope!
      } else {
        var nextRow = list.next();
        var lastChild = children[children.size() - 1].remove();

        if (nextRow != null) {
          nextRow.insert({top:lastChild});
          updateRows(nextRow);
        } else {
          var topRow = list.up().childElements()[0];
          topRow.insert({top:lastChild});
          updateRows(topRow);
        }
      }

      var i = 0;
      Sortable.sequence(list).each(function(item) {
        var itemId = 'subCategory_' + item;
        if (i < 2) {
          $(itemId).removeClassName('last');
          $(itemId).removeClassName('append-1');
          $(itemId).addClassName('append-1');
        } else {
          $(itemId).removeClassName('last');
          $(itemId).removeClassName('append-1');
          $(itemId).addClassName('last');
        }
        i++;
      });
    }

    document.observe('dom:loaded', function() {
      var subCategoryRows = $$('.product-row');

      var options = {
        constraint: false,
        overlap: 'horizontal',
        containment: subCategoryRows,
        dropOnEmpty: true,
        tag: 'div',
        onUpdate: updateRows
      };

      subCategoryRows.each(function(item) {
        Sortable.create(item, options);
      });

      $('persistOrderingButton').observe('click', function(event) {
          var sortString = '';
          subCategoryRows.each(function(row) {
              sortString += '&';
              sortString += Sortable.serialize(row);
          });
          <g:remoteFunction action="sortCategories" params="sortString" update="ajaxMessage" onSuccess="\$('ajaxMessage').show()"/>
      });
      });
    </g:javascript>
  </g:ifAllGranted>
</head>
<body>
<g:ifAllGranted role="ROLE_ADMIN">
  <div id="ajaxMessage" class="notice" style="display: none"></div>
  <div id="controlContainer" class="prepend-5 span-10 append-5">
    <input id="persistOrderingButton" type="button" value="Save Ordering"/>
  </div>
</g:ifAllGranted>
<div class="span-20 last">
  <h3 class="indent"><g:productCategoryBreadcrumbs category="${category}"/></h3>
  <div class="prepend-1 span-18 append-1">${category?.description?.encodeAsTextile()}</div>
</div>
<div id="subCategoryThumbContainer">
  <g:set var="rowIndex" value="${0}"/>
  <g:each in="${category.subCategories}" var="subCategory" status="index">
    <g:if test="${index % 3 == 0}">
      <div id="subCategoryRow${rowIndex}" class="span-20 last product-row subcategory-row">
    </g:if>
    <div id="subCategory_${subCategory.id}" class="span-6 product <g:if test="${(index % 3 == 2) || ((category.subCategories.size() - index) == 1)}">last</g:if><g:else>append-1</g:else>">
      <g:link controller="shopping" action="category" id="${subCategory.id}">
        <img src="${resource(dir: grailsApplication.config.store.productImages.webPath, file: subCategory?.image?.name)}" width="200">
      </g:link>
    </div>
    <g:if test="${(index % 3 == 2) || ((category.subCategories.size() - index) == 1)}">
      </div>
      <g:set var="rowIndex" value="${rowIndex + 1}"/>
    </g:if>
  </g:each>
</div>
</body>
</html>