package beans;
import java.io.Serializable;


public class Utilisateur implements Serializable, Comparable<Utilisateur>{

		private int id;
		private String nom;
		private String tel;
		private String username;
		private String pwd;
		
		
		
		
		public Utilisateur() {
	
		}
		
		public Utilisateur(int id, String nom, String tel, String username, String pwd) {
			super();
			this.nom = nom;
			this.tel = tel;
			this.username = username;
			this.pwd = pwd;
			this.id = id;
		}





		public String getNom() {
			return nom;
		}
		public void setNom(String nom) {
			this.nom = nom;
		}
		public String getTel() {
			return tel;
		}
		public void setTel(String tel) {
			this.tel = tel;
		}
		public String getUsername() {
			return username;
		}
		public void setUsername(String username) {
			this.username = username;
		}
		public String getPwd() {
			return pwd;
		}
		public void setPwd(String pwd) throws Exception {
			if(pwd.length()<4)
				throw new Exception("Erreur : longeur de mot de passe <4");
			else
				this.pwd = pwd;
		}
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}

		@Override
		public int compareTo(Utilisateur o) {
			return this.nom.compareTo(o.nom);
		}
		
		
		
		
}
