package blog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;

import java.util.Date;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
 

public class OfySignGuestbookServlet extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse resp)

        throws IOException {
    	
    	if (req.getParameter("submitbutton") != null) {
    		UserService userService = UserServiceFactory.getUserService();
            User user = userService.getCurrentUser();
            String title = req.getParameter("title");
            String content = req.getParameter("content");
            if ((!title.equals("")) && (!content.equals(""))) {
            	Blogpost bpost = new Blogpost(user, content, title);
                ofy().save().entity(bpost).now();
            }
            resp.sendRedirect("/blogmain.jsp");
    	} else if (req.getParameter("showbutton") != null) {
    		resp.sendRedirect("/blogmain.jsp");
    	} else if (req.getParameter("postbutton") != null) {
    		resp.sendRedirect("/postscreen.jsp");
    	} else if (req.getParameter("cancelbutton") != null) {
    		resp.sendRedirect("/blogmain.jsp");
    	} else if (req.getParameter("suscribebutton") != null) {
    		resp.sendRedirect("/subscribe.jsp");

    	}

    }
}