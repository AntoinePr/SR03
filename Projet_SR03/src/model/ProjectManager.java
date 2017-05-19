package model;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ConnexionBDD;
import dao.Project;

import dto.InfoJeuObject;
import dto.RechercheJeuObject;
import dto.TopVentesObject;

public class ProjectManager {
	
	public ArrayList<InfoJeuObject> GetAchats(String token) throws Exception {
		ArrayList<InfoJeuObject> feeds = null;
		try {
			Connection connection =  ConnexionBDD.getInstance().getCnx();
			Project project= new Project();
			String login = project.GetLoginFromToken(connection, token);
			feeds=project.GetAchats(connection, login);
		}
		catch (Exception e){
			throw e;
		}
		return feeds;
	}
	
	public ArrayList<InfoJeuObject> GetInfoJeu(String jeu) throws Exception {
		ArrayList<InfoJeuObject> feeds = null;
		try {
			Connection connection =  ConnexionBDD.getInstance().getCnx();
			Project project= new Project();
			feeds=project.GetInfoJeu(connection, jeu);
		}
		catch (Exception e){
			throw e;
		}
		return feeds;
	}
	
	public ArrayList<RechercheJeuObject> GetRechercheJeu(String jeu) throws Exception {
		ArrayList<RechercheJeuObject> feeds = null;
		try {
			Connection connection =  ConnexionBDD.getInstance().getCnx();
			Project project= new Project();
			feeds=project.GetRechercheJeu(connection, jeu);
		}
		catch (Exception e){
			throw e;
		}
		return feeds;
	}
	
	public ArrayList<TopVentesObject> GetTopVentes() throws Exception {
		ArrayList<TopVentesObject> feeds = null;
		try {
			Connection connection =  ConnexionBDD.getInstance().getCnx();
			Project project= new Project();
			feeds=project.GetTopVentes(connection);
		}
		catch (Exception e){
			throw e;
		}
		return feeds;
	}
	
	public String PostConnexion(
			String login, 
			String mdp) throws Exception {
		String token = "";
		try {
			Connection connection =  ConnexionBDD.getInstance().getCnx();
			Project project= new Project();
			project.CheckUserInfo(connection, login, mdp);
			token = project.GenerateToken(connection, login, mdp);
		}
		catch (Exception e){
			throw e;
		}
		return token;
	}
	
	public Boolean PostCreerCompte(
			String login, 
			String mdp,
			String nom,
			String prenom,
			String datenaissance,
			String rue,
			Integer cp,
			String ville,
			String mail) throws Exception {
		Boolean success = false;
		try {
			Connection connection =  ConnexionBDD.getInstance().getCnx();
			Project project= new Project();
			success = project.PostCreerCompte(
					connection, 
					login, 
					mdp,
					nom,
					prenom,
					datenaissance,
					rue,
					cp,
					ville,
					mail);
		}
		catch (Exception e){
			throw e;
		}
		return success;
	}
}
