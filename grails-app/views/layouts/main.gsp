<%@ page import="com.mattstine.wendysstore.domain.ProductCategory" %>
<html>
<head>
  <title>Duck Duck Goose Designs - <g:layoutTitle/></title>
  <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'main.css')}"/>
  <link rel="stylesheet" href="${createLinkTo(dir: 'css/blueprint', file: 'screen.css')}" type="text/css" media="screen, projection">
  <link rel="stylesheet" href="${createLinkTo(dir: 'css/blueprint', file: 'print.css')}" type="text/css" media="print">
  <!--[if IE]><link rel="stylesheet" href="${createLinkTo(dir: 'css/blueprint', file: 'ie.css')}" type="text/css" media="screen, projection"><![endif]-->
  <link rel="stylesheet" href="${createLinkTo(dir: 'css/blueprint/plugins/fancy-type', file: 'screen.css')}" type="text/css" media="screen, projection">
  <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'wendysStore.css')}" type="text/css">
  <link rel="shortcut icon" href="${createLinkTo(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>
  <g:layoutHead/>
  <g:javascript library="application"/>
  <nav:resources/>
</head>
<body>
<div id="container" class="container">
  <div id="header" class="span-24">
    <div id="spinner" class="spinner" style="display:none;">
      <img src="${createLinkTo(dir: 'images', file: 'spinner.gif')}" alt="Spinner"/>
    </div>
    <div class="logo"><img src="${createLinkTo(dir: 'images', file: 'DuckDuckLogo.jpg')}" alt="Grails"/></div>
  </div>
  <hr>
  <div id="sidebar" class="span-4">
    <h2>Categories:</h2>
    <ul>
      <g:each in="${ProductCategory.findAllByParentCategoryIsNull()}" var="category">
        <li><g:link controller="shopping" action="category" id="${category.id}">${category.name}</g:link></li>
      </g:each>
    </ul>
    <h2>Links:</h2>
    <ul>
      <li><g:link controller="home">Home</g:link> </li>
      <li><g:link controller="shopping" action="viewCart">View Cart</g:link> </li>
      <g:isNotLoggedIn>
        <li><g:link controller="login">Login</g:link></li>
      </g:isNotLoggedIn>
      <g:isLoggedIn>
        <li><g:link controller="logout">Logout</g:link></li>
      </g:isLoggedIn>
    </ul>
    <g:ifAllGranted role="ROLE_ADMIN">
    <h2>Admin:</h2>
      <nav:render/>
      
    </g:ifAllGranted>
  </div>
  <div id="main" class="span-20 last">
    <g:ifAllGranted role="ROLE_ADMIN">
      <div id="menu" class="span-20 last">
        <nav:renderSubItems/>
      </div>
    </g:ifAllGranted>
    <g:layoutBody/>
  </div>
  <hr>
  <div id="footer" class="span-24">
    <p class="alt">&copy;2009 Duck Duck Goose Designs. All Rights Reserved.</p>
    <p class="alt">Web Development by <a href="http://www.mattstine.com">Matt Stine</a>.</p>
  </div>
</div>
</body>
</html>