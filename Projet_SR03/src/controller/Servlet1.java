package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ConnexionBDD;

/**
 * Servlet implementation class Servlet1
 */
@WebServlet("/Servlet1")
public class Servlet1 extends HttpServlet {

	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servlet1() {
        super();
        // TODO Auto-generated constructor stub
    }

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();
		
		
		Connection cnx =  ConnexionBDD.getInstance().getCnx();
		
		try {
			out.print("<html><body>");
			out.print("<h1>Page fonctionnelle</h1>");
			if(cnx == null){
				out.print("<h1>Connexion null</h1>");
			}
			else{
				Statement statement = cnx.createStatement();
				ResultSet resultat = statement.executeQuery( "SELECT *  FROM achat;" );
				out.print("<h1>Page de reponse de Servlet1</h1>");
				while ( resultat.next() ) {
				    String jeu = resultat.getString( "jeu" );
				    String adh = resultat.getString( "adh" );

				    out.print(jeu);
				    out.print("  ");
				    out.print(adh);
				    out.print("\n");
				}
			}
			out.print("</body></html>");
			out.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();		
		}		
	}
}
