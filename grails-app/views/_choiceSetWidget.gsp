<g:if test="${customization.required}">
  <g:set var="noSelection" value="${['':'Select a value...']}"/>
</g:if>
<g:else>
  <g:set var="noSelection" value="${['':'None']}"/>
</g:else>
<label for="customization${customization.id}"><g:if test="${customization.required}"><span class="required">* </span></g:if>${customization.label}: </label>
<g:select id="customization${customization.id}" name="customization${customization.id}" from="${customization.choices}" noSelection="${noSelection}" optionValue="display" optionKey="id"/> <g:if test="${customization.chargeable}">(<g:formatNumber format="\$0.00" number="${customization.price}"/>)</g:if>
<g:javascript>
  document.observe('dom:loaded', function() {
      $('customization${customization.id}').selectedIndex = 0;
  });
</g:javascript>