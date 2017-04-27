package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.AchatsObject;

public class Project {
	
	public ArrayList<AchatsObject> GetAchats(Connection connection) throws Exception {
		ArrayList<AchatsObject> feedData = new ArrayList<AchatsObject>();
		try {
			String query;
			query = "SELECT adh, jeu FROM achats";
			PreparedStatement ps = connection.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				AchatsObject feedObject = new AchatsObject();
				feedObject.setAdh(rs.getString("adh"));
				feedObject.setJeu(rs.getString("jeu"));
				feedData.add(feedObject);
			}
		}
		catch(Exception e) {
			throw e;
		}
		return feedData;
	}	
}
