package controller;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.Path;

import dao.ConnexionBDD;

import model.ProjectManager;
import com.google.gson.Gson;

import dto.AchatsObject;

@Path("/bdd")
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
	@Path("/getachats")
	@Produces(MediaType.TEXT_PLAIN)
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
}