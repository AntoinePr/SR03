package beans;

import java.io.Serializable;

@SuppressWarnings("serial")
public class LigneCommande implements Serializable{

	private Produit prod;
	private int qte;
	/**
	 * @param prod
	 * @param qte
	 */
	
	public LigneCommande(Produit prod, int qte) {
		super();
		this.prod = prod;
		this.qte = qte;
	}
	/**
	 * 
	 */
	public LigneCommande() {
		super();
	}
	public Produit getProd() {
		return prod;
	}
	public void setProd(Produit prod) {
		this.prod = prod;
	}
	public int getQte() {
		return qte;
	}
	public void setQte(int qte) {
		this.qte = qte;
	}
	public double getTotal(){
		//bisogna recuperare il costo di un singolo prodotto
		double prix = prod.getPrix();
		return (prix*this.qte);
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((prod == null) ? 0 : prod.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		LigneCommande other = (LigneCommande) obj;
		if (prod == null) {
			if (other.prod != null)
				return false;
		} else if (!prod.equals(other.prod))
			//va a controllare se i due prodotti sono uguali utilizzando
			//l'equals di produit che abbiamo ridefinito in precedenza
			return false;
		return true;
	}
	
	
}
