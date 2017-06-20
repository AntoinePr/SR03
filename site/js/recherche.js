
function getCookie(name){
	var value = "; " + document.cookie;
	var parts = value.split("; " + name + "=");
	if (parts.length == 2) return parts.pop().split(";").shift();
}
function initCookie(){
	var name=getCookie("expires");
	if(name=="NaN"||name=="undefined"||name==null){
		var d = new Date();
	    d.setTime(d.getTime() + (24*60*60*1000));
	    var expires = "expires="+ d.toUTCString();
	    document.cookie =expires + ";path=/";
	}
}
function checkEntry(){
	initCookie();
	var recherche = document.getElementById('search');
	$("#errorMessage").html("");
	$("#newsMessage").html("");
	$.ajax({
	  type: "GET",
	  url: "http://localhost:8080/Projet_SR03/rest/info_jeu/"+recherche.value,
	  contentType: "application/json; charset=utf-8",
	  success: function(data,status){
	  	if(status=='success'){
			for(cpt=0; cpt<data.length;cpt++){
				$("#games").html('<div class="TitreJeu" id="'+cpt+'">'+data[cpt].nom+"</div><div class='infos' id='"+cpt+"'>"+data[cpt].description+"<br>"+data[cpt].prix+"€<br>"+data[cpt].datesortie+"<br>"+data[cpt].raisonsociale+'</div>'+"<input type='button' name='Ajouter' value='Ajouter' onClick='addToCart(\""+data[cpt].nom+"\");'/>");
			}
	  	}
	  },
	  error: function(data,status,error){
	  	if(status=='error'){
	  		$("#errorMessage").html("Produit introuvable");
	  	}
	  },
	  failure: function(errMsg) {
        $("#errorMessage").html("Problème de communication avec le serveur, merci de bien vouloir réessayer ultérieurement");
	  },
	  async: false,
	  dataType: 'json'
	});
}
function addToCart(name){
	initCookie();
	//stocker produit dans document.cookie
	document.cookie=name+"="+name;
	$("#newsMessage").html("Ajout au panier du jeu "+name+" réussi");	
}