// http://localhost:8080/Projet_SR03/rest

package controller;

import java.util.ArrayList;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

import model.ProjectManager;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import dtio.CreerCompteInputObject;

import dto.AchatsObject;
import dto.InfoJeuObject;
import dto.RechercheJeuObject;
import dto.TopVentesObject;

@Path("/rest")
public class VideogameRESTService {
	
	@GET
	public Response getUser() {
		return Response.status(200).entity("getUser is called").build();
	}

	// Sert à tester le bon fonctionnement du serveur
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
	
	// Permet d'obtenir toutes les infos de la BDD sur un jeu en particulier
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
			System.out.println(e.getMessage());
		}		
        return feeds;
	}
	
	// Permet de trouver tous les jeux qui match la chaine de caractère en entrée
	@GET
	@Path("/recherche_jeu/{jeu}")
	@Produces(MediaType.APPLICATION_JSON)
    public String feedRechercheJeu(@PathParam("jeu") String jeu) {
		String feeds = null;
		try {
			ArrayList<RechercheJeuObject> feedData = null;
			ProjectManager projectManager= new ProjectManager();
			feedData = projectManager.GetRechercheJeu(jeu);
			Gson gson = new Gson();
			feeds = gson.toJson(feedData);
		} 
		catch (Exception e) {
			System.out.println(e.getMessage());
		}		
        return feeds;
	}
	
	// Renvoie les 1 jeux les plus vendus
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
			System.out.println(e.getMessage());
		}		
        return feeds;
	}
	
	// Permet la création d'un nouveau compte
	@POST
	@Path("/creer_compte")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public String postCreerCompte(String input){
		String feeds = null;
		try {
			Gson gson = new Gson();
			CreerCompteInputObject params = gson.fromJson(input, CreerCompteInputObject.class);
			
			ProjectManager projectManager= new ProjectManager();
			Boolean success = false;
			success = projectManager.PostCreerCompte(
					params.getLogin(), 
					params.getMdp(),
					params.getNom(),
					params.getPrenom(),
					params.getDatenaissance(),
					params.getRue(),
					params.getCp(),
					params.getVille(),
					params.getMail()
					);
			
			JsonObject result =new JsonObject();
			result.addProperty("success", success);
			feeds = result.toString();
		} 
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return feeds;
	}
}