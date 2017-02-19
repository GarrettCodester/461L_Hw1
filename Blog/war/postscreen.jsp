<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="java.util.Collections" %>

<%@ page import="blog.Blogpost" %>

<%@ page import="com.googlecode.objectify.*" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>

<%@ page import="com.google.appengine.api.datastore.Query" %>

<%@ page import="com.google.appengine.api.datastore.Entity" %>

<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>

<%@ page import="com.google.appengine.api.datastore.Key" %>

<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 

<html>

   <head>
   <link type="text/css" rel="stylesheet" href="/stylesheets/poster.css" />
 </head>

 

  <body>

 

<%

    String blogName = request.getParameter("blogName");

    if (blogName == null) {

        blogName = "Meme Blog 1.337";

    }

    pageContext.setAttribute("blogName", blogName);

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>

<p>Hello, ${fn:escapeXml(user.nickname)}! 

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.</p>

<%

    } else {

%>

<p>Hello! You must

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

to create posts.</p>

<%

    }

%>

 

<%


ObjectifyService.register(Blogpost.class);

List<Blogpost> bposts = ObjectifyService.ofy().load().type(Blogpost.class).list();   

Collections.sort(bposts); 

 
	%>
    <form action="/ofysign" method="post">
    
      <b>Topic:</b>
      
	  <input type="text" name="title"><br>
	  
	  <b>Content:</b>

      <div><textarea name="content" rows="3" cols="60"></textarea></div>

      <div><input type="submit" name="submitbutton" value="Post" /></div>
      
      <div><input type="submit" name="cancelbutton" value="Cancel" /></div>

      <input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>

    </form>
    <%

 %>

  </body>

</html>

