package dto;

public class InfoJeuObject {
	private String nom;
	private String prix;
	private String description;
	private String datesortie;
	private String raisonsociale;
	public String getRaisonsociale() {
		return raisonsociale;
	}
	public void setRaisonsociale(String raisonsociale) {
		this.raisonsociale = raisonsociale;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getPrix() {
		return prix;
	}
	public void setPrix(String prix) {
		this.prix = prix;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDatesortie() {
		return datesortie;
	}
	public void setDatesortie(String datesortie) {
		this.datesortie = datesortie;
	}
}
