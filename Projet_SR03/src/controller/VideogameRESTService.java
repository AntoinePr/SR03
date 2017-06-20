// http://localhost:8080/Projet_SR03/rest

package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.NotAuthorizedException;
import javax.ws.rs.POST;
import javax.ws.rs.Produces;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

import model.ProjectManager;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import dao.Secured;

import dtio.CreerCompteInputObject;
import dtio.AcheterPanierInputObject;
import dtio.ConnexionInputObject;

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
	@Secured
	@Path("/test")
	@Produces(MediaType.TEXT_PLAIN)
    public String getMessage() {
		System.out.println("Endpoint 'test' called");
        return "Hello " + getUser();
    }
	
	@GET
	@Secured
	@Path("/achats")
	@Produces(MediaType.APPLICATION_JSON)
    public Response feedAchats(ContainerRequestContext requestContext) {
		System.out.println("Endpoint 'achats' called");
		String feeds = null;
		try {
			// Extract token from header
	        String authorizationHeader = 
	            requestContext.getHeaderString(HttpHeaders.AUTHORIZATION);
		System.out.println(authorizationHeader);
	        if (authorizationHeader == null || !authorizationHeader.startsWith("Token ")) {
	        	throw new NotAuthorizedException("Authorization header must be provided");
	        }
	        String token = authorizationHeader.substring("Token".length()).trim();
	        
			ArrayList<InfoJeuObject> feedData = null;
			ProjectManager projectManager= new ProjectManager();
			feedData = projectManager.GetAchats(token);
			Gson gson = new Gson();
			feeds = gson.toJson(feedData);
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
			return Response.status(401).build();
		}		
		return Response.ok(feeds, MediaType.APPLICATION_JSON).build();
	}
	
	// Permet d'obtenir toutes les infos de la BDD sur un jeu en particulier
	@GET
	@Path("/info_jeu/{jeu}")
	@Produces(MediaType.APPLICATION_JSON)
    public Response feedInfoJeu(@PathParam("jeu") String jeu) {
		System.out.println("Endpoint 'info_jeu/{jeu}' called");
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
			return Response.status(500).build();
		}		
		return Response.ok(feeds, MediaType.APPLICATION_JSON).build();
	}
	
	// Permet de trouver tous les jeux qui match la chaine de caractère en entrée
	@GET
	@Path("/recherche_jeu/{jeu}")
	@Produces(MediaType.APPLICATION_JSON)
    public Response feedRechercheJeu(@PathParam("jeu") String jeu) {
		System.out.println("Endpoint 'recherche_jeu/{jeu}' called");
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
			return Response.status(500).build();
		}		
		return Response.ok(feeds, MediaType.APPLICATION_JSON).build();
	}
	
	// Renvoie les 1 jeux les plus vendus
	@GET
	@Path("/top_ventes")
	@Produces(MediaType.APPLICATION_JSON)
    public Response feedTopVentes() {
		System.out.println("Endpoint 'top_ventes' called");
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
			return Response.status(500).build();
		}		
		return Response.ok(feeds, MediaType.APPLICATION_JSON).build();
	}
	
	// Permet d'acheter un panier d'article
	@POST
	@Secured
	@Path("/acheter_panier")
	@Produces(MediaType.APPLICATION_JSON)
    public Response feedAcheterPanier(String input, @Context ContainerRequestContext requestContext) {
		System.out.println("Endpoint 'acheter_panier' called");
		String feeds = null;
		try {
			// Extract token from header
	        String authorizationHeader = 
	            requestContext.getHeaderString(HttpHeaders.AUTHORIZATION);
	        if (authorizationHeader == null || !authorizationHeader.startsWith("Token ")) {
	        	throw new NotAuthorizedException("Authorization header must be provided");
	        }
	        String token = authorizationHeader.substring("Token".length()).trim();
	        
	        // Parse the input json
	        Gson gson = new Gson();
	        AcheterPanierInputObject params = gson.fromJson(input, AcheterPanierInputObject.class);
	        
			ProjectManager projectManager= new ProjectManager();
			String[] ajouts;
			ajouts = projectManager.PostAcheterPanier(
					token, 
					params.getJeux());
			feeds = gson.toJson(ajouts);
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
			return Response.status(401).build();
		}		
		return Response.ok(feeds, MediaType.APPLICATION_JSON).build();
	}
	
	// Permet la connexion d'un utilisateur, génération d'un token
	@POST
	@Path("/connexion")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response postConnexion(String input){
		System.out.println("Endpoint 'connexion' called");
		String feeds = null;
		try {
			Gson gson = new Gson();
			ConnexionInputObject params = gson.fromJson(input, ConnexionInputObject.class);
			
			ProjectManager projectManager= new ProjectManager();
			String token = "";
			token = projectManager.PostConnexion(
					params.getLogin(), 
					params.getMdp()
					);
			if (token == "") {
				// If the token is empty we raise an exception
				IOException e = new IOException();
				throw e;
			}
			
			JsonObject result =new JsonObject();
			result.addProperty("token", token);
			feeds = result.toString();
			//feeds = result.toString();
		} 
		catch (Exception e) {
			System.out.println(e.getMessage());
			return Response.status(401).build();
		}
		return Response.ok(feeds, MediaType.APPLICATION_JSON).build();
	}
	
	// Permet la création d'un nouveau compte
	@POST
	@Path("/creer_compte")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response postCreerCompte(String input){
		System.out.println("Endpoint 'creer_compte' called");
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
			return Response.status(500).build();
		}
		return Response.ok(feeds, MediaType.APPLICATION_JSON).build();
	}
}
