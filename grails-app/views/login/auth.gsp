<html>
<head>
<meta name="layout" content="main" />
<title>Login</title>
</head>
<body>
	<div id="login" class="prepend-5 span-10 append-5">
		<div id="form">
			<g:if test="${flash.message}">
			<div class="notice">${flash.message}</div>
			</g:if>
			<h2>Please Login..</h2>
			<form action="${postUrl}" method="POST" id="loginForm">
                <fieldset>
				<p>
					<label for="j_username">Username</label>
					<input type="text" class="text" name="j_username" id="j_username" value="${request.remoteUser}" />
				</p>
				<p>
					<label for="j_password">Password</label>
					<input type="password" class="text" name="j_password" id="j_password" />
				</p>
				<p>
					<label for="remember_me">Remember me!</label><br/>
					<input type="checkbox" name="_spring_security_remember_me" id="remember_me"
					<g:if test="${hasCookie}">checked="checked"</g:if> />
				</p>
				<p>
					<input type="submit" value="Login" />
				</p>

                <p>
                  <g:link controller="register">Register for an Account</g:link>
                </p>
                </fieldset>
			</form>
		</div>
	</div>
<script type="text/javascript">
<!--
(function(){
	document.forms['loginForm'].elements['j_username'].focus();
})();
// -->
</script>
</body>
</html>