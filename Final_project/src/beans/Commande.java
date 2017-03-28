package beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Commande implements Serializable{

	private List<LigneCommande> lignes;

	/**
	 * 
	 */
	public Commande() {
		lignes = new ArrayList<LigneCommande>();
	}

	public List<LigneCommande> getLignes() {
		return lignes;
	}

	public void setLignes(List<LigneCommande> lignes) {
		this.lignes = lignes;
	}
	
	public double getTotal(){
		double total = 0;
	
		for (LigneCommande lc : lignes){
			total+=lc.getTotal();
		}
		//for(int i=0;i<lignes.size();i++){
		//	total = total + lignes.get(i).getTotal();
		//}
		return total;
	}
	
}
