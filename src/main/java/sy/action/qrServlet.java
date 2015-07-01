package sy.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.h2.engine.User;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import sy.model.base.Syuser;
import sy.service.UserManager;
import sy.service.base.SyuserServiceI;
import sy.service.base.impl.SyuserServiceImpl;

/**
 * Servlet implementation class qrServlet
 */
public class qrServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public qrServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	System.out.println("----------");
		RequestDispatcher dispatcher = request.getRequestDispatcher("static/share.jsp");
		String userId=request.getParameter("vcard");
		if(userId!=null){
			ServletContext servletContext = this.getServletContext();    
			WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);    
			SyuserServiceI userService = (SyuserServiceImpl) wac.getBean("syuserServiceImpl");//Spring 配置 中的 bean id   
			Syuser u=userService.getById(userId);
			if(u!=null){
				request.setAttribute("user", u);
			}
		}
		dispatcher.forward(request, response); 
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
