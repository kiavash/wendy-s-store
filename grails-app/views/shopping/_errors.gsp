<div class="error">
  <ul>
    <g:each in="${errors}" var="error">
      <li>${error}</li>
    </g:each>
  </ul>
</div>
<script type="javascript">
  $('ajaxMessage').removeClassName('message').setStyle({visibility: 'visible'});
</script>