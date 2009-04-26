<g:renderErrors bean="${message}" as="list"/>
<script type="javascript">
  $('ajaxMessage').removeClassName('notice').addClassName('error');
  if (!$('ajaxMessage').visible()) {
    $('ajaxMessage').toggle();
  }

  Recaptcha.reload();
</script>