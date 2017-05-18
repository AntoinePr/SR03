// http://localhost:8080/Projet_SR03/rest/test
// http://localhost:8080/Projet_SR03/rest/achats
// http://localhost:8080/Projet_SR03/rest/info_jeu/Skyrim

package controller;

import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

import model.ProjectManager;
import com.google.gson.Gson;

import dto.AchatsObject;
import dto.InfoJeuObject;
import dto.TopVentesObject;

@Path("/rest")
public class VideogameRESTService {
	
	@GET
	public Response getUser() {
		return Response.status(200).entity("getUser is called").build();
	}

	@GET
	@Path("/test")
	@Produces(MediaType.TEXT_PLAIN)
    public String getMessage() {
        return "Hello " + getUser();
    }
	
	@GET
	@Path("/achats")
	@Produces(MediaType.APPLICATION_JSON)
    public String feedAchats() {
		String feeds = null;
		try {
			ArrayList<AchatsObject> feedData = null;
			ProjectManager projectManager= new ProjectManager();
			feedData = projectManager.GetAchats();
			Gson gson = new Gson();
			feeds = gson.toJson(feedData);
		} 
		catch (Exception e) {
			System.out.println("Exception Error");
		}		
        return feeds;
	}
	
	@GET
	@Path("/info_jeu/{jeu}")
	@Produces(MediaType.APPLICATION_JSON)
    public String feedInfoJeu(@PathParam("jeu") String jeu) {
		String feeds = null;
		try {
			ArrayList<InfoJeuObject> feedData = null;
			ProjectManager projectManager= new ProjectManager();
			feedData = projectManager.GetInfoJeu(jeu);
			Gson gson = new Gson();
			feeds = gson.toJson(feedData);
		} 
		catch (Exception e) {
			System.out.println("Exception Error");
		}		
        return feeds;
	}
	
	@GET
	@Path("/top_ventes")
	@Produces(MediaType.APPLICATION_JSON)
    public String feedTopVentes() {
		String feeds = null;
		try {
			ArrayList<TopVentesObject> feedData = null;
			ProjectManager projectManager= new ProjectManager();
			feedData = projectManager.GetTopVentes();
			Gson gson = new Gson();
			feeds = gson.toJson(feedData);
		} 
		catch (Exception e) {
			System.out.println("Exception Error");
		}		
        return feeds;
	}
}