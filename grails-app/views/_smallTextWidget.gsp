<label for="customization${customization.id}"><g:if test="${customization.required}"><span class="required">* </span></g:if>${customization.label}</label>: <g:textField id="customization${customization.id}" name="customization${customization.id}" /> <g:if test="${customization.chargeable}">(<g:formatNumber format="\$0.00" number="${customization.price}"/>)</g:if>