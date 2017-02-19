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
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
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
      	<form action="/ofysign" method="post">
			<div><input type="submit" name="postbutton" value="New Post" /></div>
			<div><input type="submit" name="subscribebutton" value="Subscribe" /></div>
			<input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>
		</form>
		<%

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

    if (bposts.isEmpty()) {

        %>

        <h1>${fn:escapeXml(blogName)}</h1>

        <%

    } else {

        %>

        <h1>${fn:escapeXml(blogName)}</h1>

        <%

        for (Blogpost bpost : bposts) {

            pageContext.setAttribute("bpost_content",

                                     bpost.getContent());
            
            pageContext.setAttribute("bpost_title",

                                     bpost.getTitle());

            if (bpost.getUser() == null) {

                %>

                <p>An anonymous person wrote:</p>

                <%

            } else {

                pageContext.setAttribute("bpost_user",

                                         bpost.getUser());

                %>

                <h1><b>${fn:escapeXml(bpost_title)}</b></h1>

                <%

            }

            %>

            <blockquote>${fn:escapeXml(bpost_content)}</blockquote>

            <%
            
             %>

                <p>posted by <b>${fn:escapeXml(bpost_user.nickname)}</b></p>

            <%

        }

    }
    		%>
    
   		<form action="/ofysign" method="post">
			<div><input type="submit" name="showbutton" value="Show All Posts" /></div>
			<input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>
		</form>
		
		<%

%>

 

  </body>

</html>

