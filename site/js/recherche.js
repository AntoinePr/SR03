function checkEntry(){
	var recherche = document.getElementById('search');
	alert(recherche.value);
	$.ajax({
	  type: "GET",
	  url: "http://localhost:28080/Projet_SR03/rest/recherche_jeu/"+recherche.value,
	  contentType: "application/json; charset=utf-8",
	  success: function(data,status){
	  	if(status=='success'){
			for(cpt=0; cpt<data.length;cpt++){
				document.getElementById('games').innerHTML='<div class="TitreJeu" id="'+cpt+'">'+data[cpt].nom+"</div><div class='infos' id='"+cpt+"'>"+data[cpt].description+'</div>'+"<input type='button' name='Ajouter' value='Ajouter' onClick='addToCart("+cpt+");'/>";
			}
	  	}
	  },
	  error: function(data,status,error){
	  	if(status=='error'){
	  		document.getElementById('errorMessage').textContent = "Produit introuvable";
	  	}
	  },
	  failure: function(errMsg) {
        document.getElementById('errorMessage').textContent = "Problème de communication avec le serveur, merci de bien vouloir réessayer ultérieurement";
	  },
	  async: false,
	  dataType: 'json'
	});
}
function addToCart(cpt){
	//ajouter au panier le produit
	alert(cpt);
	var jeu=document.getElementById(cpt);
	var nomJeu=jeu.innerText;
	//stocker dans document.cookie
	//rediriger vers page du panier
}