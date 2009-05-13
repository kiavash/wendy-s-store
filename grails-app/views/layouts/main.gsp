<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="com.mattstine.wendysstore.domain.Page; com.mattstine.wendysstore.domain.ProductCategory" %>
<html>
<head>
  <title>Duck Duck Goose Designs - <g:layoutTitle/></title>
  <p:css name='blueprint/screen'/>
  <!--[if IE]><p:css name='blueprint/ie'/><![endif]-->
  <p:css name='wendysStore'/>
  <link rel="shortcut icon" href="${createLinkTo(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>
  %{--<p:javascript src='prototype.all'/>--}%
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

      new Ajax.InPlaceEditor('headerMessage','${createLink(controller: 'welcomeMessage', action: 'update')}');  

      });
    </g:javascript>
  </g:ifAllGranted>
  <g:layoutHead/>
</head>
<body>
<div id="container" class="container">
  <div id="topBorder" class="span-24">&nbsp;</div>  
  <div id="header" class="span-24">
    <div class="span-15"><p:image src="DuckDuckLogo.jpg"/></div>
    <div class="span-9 last">
      <div id="headerMessage" class="span-9">${application.getAttribute("welcomeMessage")}</div>
      <div id="homeButtom" class="span-3 buttonCell"><g:link controller="home"><p:image src="homeButton.png"/></g:link></div>
      <div id="cartButton" class="span-3 buttonCell"><g:link controller="shopping" action="viewCart"><p:image src="cartButton.png"/></g:link></div>
      <div id="contactUsButton" class="span-3 last buttonCell"><g:link controller="contactUs"><p:image src="contactUsButton.png"/></g:link></div>
    </div>
  </div>
  <div id="bottomBorder" class="span-24">&nbsp;</div>    
  <div id="sidebar" class="span-4">
    <p:image src="shopOurStore.png"/>
    <ul id="productCategoryMenu" class="menu">
      <g:each in="${ProductCategory.findAllByParentCategoryIsNull(sort:'sortIndex', order:'asc')}" var="category">
        <li id="productCategory_${category.id}" class="menuItem"><g:link controller="shopping" action="category" id="${category.id}">${category.name}</g:link></li>
      </g:each>
    </ul>
    <p:image src="information.png"/>
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
      <p:image src="admin.png"/>
      <ul class="menu">
        <li class="menuItem"><g:link controller="orders">Orders</g:link></li>
        <li class="menuItem"><g:link controller="product">Products</g:link></li>
        <li class="menuItem"><g:link controller="productCategory">Categories</g:link></li>
        <li class="menuItem"><g:link controller="customization">Customizations</g:link></li>
        <li class="menuItem"><g:link controller="couponCode">Coupon Codes</g:link></li>
        <li class="menuItem"><g:link controller="page">Pages</g:link></li>
        <li class="menuItem"><g:link controller="user">Users</g:link></li>
        <li class="menuItem"><g:link controller="role">Roles</g:link></li>
        <li class="menuItem"><g:link controller="contactUs" action="showMessages">View Messages</g:link></li>        
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