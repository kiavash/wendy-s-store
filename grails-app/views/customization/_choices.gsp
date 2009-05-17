<h2>Manage Choices:</h2>
<div class="dialog span-20 last" style="text-align: center">
  <g:hasErrors bean="${customizationChoiceInstance}">
      <div class="errors">
        <g:renderErrors bean="${customizationChoiceInstance}" as="list"/>
      </div>
    </g:hasErrors>
  <g:form name="addChoiceForm" method="post">
    <input type="hidden" name="customizationId" value="${customizationInstance?.id}"/>
    <input type="hidden" name="id" value="${customizationChoiceInstance?.id}"/>
    <label for="label">Label:</label><g:textField name="label" value="${customizationChoiceInstance.label}"/>
    <label for="chargeable">Chargeable:</label><g:checkBox id="chargeable" name="chargeable" value="${customizationChoiceInstance?.chargeable}"/>
    <label for="price">Price:</label><g:textField id="price" name="price" value="${customizationChoiceInstance.price}"/>
    <label for="sortIndex">Sort Index:</label><g:textField id="sortIndex" name="sortIndex" value="${customizationChoiceInstance.sortIndex}"/>
    <span class="button">
      <g:if test="${customizationChoiceInstance?.id == null}">
        <g:actionSubmit class="add" value="Add Choice" action="addChoice"/>
      </g:if>
      <g:else>
        <g:actionSubmit class="add" value="Update Choice" action="updateChoice"/>
      </g:else>
    </span>
  </g:form>
</div>
<div class="list span-20 last" style="text-align: center">
  <table class="datatable">
    <thead>
    <tr>

      <g:sortableColumn property="label" title="Label"/>

      <g:sortableColumn property="chargeable" title="Chargeable"/>

      <g:sortableColumn property="price" title="Price"/>

      <g:sortableColumn property="sortIndex" title="Sort Index"/>

      <th>&nbsp;</th>

      <th>&nbsp;</th>

    </tr>
    </thead>
    <tbody>
    <g:each in="${customizationInstance.choices}" status="i" var="customizationChoiceInstance">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

        <td>${fieldValue(bean: customizationChoiceInstance, field: 'label')}</td>

        <td><g:if test="${customizationChoiceInstance.chargeable}">Yes</g:if><g:else>No</g:else></td>

        <td><g:formatNumber number="${customizationChoiceInstance.price}" format="\$0.00"/></td>

        <td>${customizationChoiceInstance.sortIndex}</td>

        <td class="buttons">
          <g:form action="editChoice">
            <g:hiddenField name="id" value="${customizationChoiceInstance.id}"/>
            <g:hiddenField name="customizationId" value="${customizationInstance.id}"/>
            <span class="button"><g:submitButton name="editCustomizationChoice" class="edit" value="Edit"/></span>
          </g:form>
        </td>

        <td class="buttons">
          <g:form action="deleteChoice">
            <g:hiddenField name="customizationId" value="${customizationInstance.id}"/>
            <g:hiddenField name="id" value="${customizationChoiceInstance.id}"/>
            <span class="button"><g:submitButton class="delete" name="deleteCustomizationChoice" onclick="return confirm('Are you sure?');" value="Delete"/></span>
          </g:form>

        </td>

      </tr>
    </g:each>
    </tbody>
  </table>
</div>