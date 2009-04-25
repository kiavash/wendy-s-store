<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="com.mattstine.wendysstore.domain.Page; com.mattstine.wendysstore.domain.ProductCategory" %>
<html>
<head>
  <title>Duck Duck Goose Designs - <g:layoutTitle/></title>
  <link rel="stylesheet" href="${createLinkTo(dir: 'css/blueprint', file: 'screen.css')}" type="text/css" media="screen, projection">
  <link rel="stylesheet" href="${createLinkTo(dir: 'css/blueprint', file: 'print.css')}" type="text/css" media="print">
  <!--[if IE]><link rel="stylesheet" href="${createLinkTo(dir: 'css/blueprint', file: 'ie.css')}" type="text/css" media="screen, projection"><![endif]-->
  <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'wendysStore.css')}" type="text/css">
  <link rel="shortcut icon" href="${createLinkTo(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>
  <g:javascript library="scriptaculous"/>
  <g:ifAllGranted role="ROLE_ADMIN">
    <g:javascript>
    document.observe('dom:loaded', function() {

      Sortable.create('productCategoryMenu', {onUpdate:function() {
          <g:remoteFunction controller="productCategory" action="sortMenu" params="Sortable.serialize('productCategoryMenu')"/>
      }});

      Sortable.create('pageMenu', {only:'sortable', onUpdate:function() {
          <g:remoteFunction controller="page" action="sortMenu" params="Sortable.serialize('pageMenu')"/>
      }});

      });
    </g:javascript>
  </g:ifAllGranted>
  <g:layoutHead/>
</head>
<body>
<div id="container" class="container">
  <div id="topBorder" class="span-24">&nbsp;</div>  
  <div id="header" class="span-24">
    <div class="span-15"><img src="${createLinkTo(dir: 'images', file: 'DuckDuckLogo.jpg')}" alt="Duck Duck Goose Designs"/></div>
    <div class="span-9 last">
      <div id="headerMessage" class="span-9">Grand Opening!</div>
      <div id="homeButtom" class="span-3 buttonCell"><g:link controller="home"><img src="${createLinkTo(dir: 'images', file: 'homeButton.png')}" alt="Home"/></g:link></div>
      <div id="cartButton" class="span-3 buttonCell"><g:link controller="shopping" action="viewCart"><img src="${createLinkTo(dir: 'images', file: 'cartButton.png')}" alt="Cart"/></g:link></div>
      <div id="contactUsButton" class="span-3 last buttonCell"><img src="${createLinkTo(dir: 'images', file: 'contactUsButton.png')}" alt="Contact Us"/></div>
    </div>
  </div>
  <div id="bottomBorder" class="span-24">&nbsp;</div>    
  <div id="sidebar" class="span-4">
    <img src="${createLinkTo(dir: 'images', file: 'shopOurStore.png')}" alt="Shop Our Store" class="sidebarHeading"/>
    <ul id="productCategoryMenu" class="menu">
      <g:each in="${ProductCategory.findAllByParentCategoryIsNull(sort:'sortIndex', order:'asc')}" var="category">
        <li id="productCategory_${category.id}" class="menuItem"><g:link controller="shopping" action="category" id="${category.id}">${category.name}</g:link></li>
      </g:each>
    </ul>
    <img src="${createLinkTo(dir: 'images', file: 'information.png')}" alt="Information" class="sidebarHeading"/>
    <ul id="pageMenu" class="menu">
      <g:each in="${Page.findAll(sort:'sortIndex', order:'asc')}" var="page">
        <li id="page_${page.id}" class="menuItem sortable"><g:link controller="page" action="show" id="${page.id}">${page.sidebarLinkTitle}</g:link></li>
      </g:each>
      <g:isNotLoggedIn>
        <li class="menuItem"><g:link controller="login">Login</g:link></li>
      </g:isNotLoggedIn>
      <g:isLoggedIn>
        <li class="menuItem"><g:link controller="register">My Account</g:link></li>
        <li class="menuItem"><g:link controller="logout">Logout</g:link></li>
      </g:isLoggedIn>
    </ul>
    <g:ifAllGranted role="ROLE_ADMIN">
      <img src="${createLinkTo(dir: 'images', file: 'admin.png')}" alt="Administration" class="sidebarHeading"/>
      <ul class="menu">
        <li class="menuItem"><g:link controller="product">Manage Products</g:link></li>
        <li class="menuItem"><g:link controller="productCategory">Manage Categories</g:link></li>
        <li class="menuItem"><g:link controller="customization">Manage Customizations</g:link></li>
        <li class="menuItem"><g:link controller="page">Manage Pages</g:link></li>
        <li class="menuItem"><g:link controller="user">Manage Users</g:link></li>
        <li class="menuItem"><g:link controller="role">Manage Roles</g:link></li>
      </ul>
    </g:ifAllGranted>
  </div>
  <div id="main" class="span-20 last">
    <g:layoutBody/>
  </div>
  <hr>
  <div id="footer" class="span-24">
    <p>&copy;2009 Duck Duck Goose Designs. All Rights Reserved.<br/>
      Web Development by <a href="http://www.mattstine.com">Matt Stine</a>.</p>
  </div>
  <div id="footBorder" class="span-24">&nbsp;</div>    
</div>
</body>
</html>