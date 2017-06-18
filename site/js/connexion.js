function getXhr(){
	var xhr = null; 
	if(window.XMLHttpRequest) // Firefox et autres
	   xhr = new XMLHttpRequest(); 
	else if(window.ActiveXObject){ // Internet Explorer 
	   try {
				xhr = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			}
	}
	else { // XMLHttpRequest non supporté par le navigateur 
	   alert("Votre navigateur ne supporte pas les objets XMLHTTPRequest..."); 
	   xhr = false; 
	}
	return xhr;
}

function checkEntryCon(){
	var log = document.getElementById('login');
	var mdp = document.getElementById('mdp');
	var jsonString = JSON.stringify({login:log.value,mdp:mdp.value});
	$.ajax({
	  type: "POST",
	  url: "http://localhost:28080/Projet_SR03/rest/connexion",
	  data: jsonString,
	  contentType: "application/json; charset=utf-8",
	  success: function(data,status){
	  	if(status=='success'){
	  		document.cookie = "token="+data.token;
	  		window.location = "./acceuil.html";
	  	}
	  },
	  error: function(data,status,error){
	  	if(status=='error'){
	  		document.getElementById('errorMessage').textContent = "Identifiants inconnus";
	  	}
	  },
	  failure: function(errMsg) {
        document.getElementById('errorMessage').textContent = "Problème de communication avec le serveur, merci de bien vouloir réessayer ultérieurement";
	  },
	  async: false,
	  dataType: 'json'
	});
}

function checkEntryIns(){
	var log = document.getElementById('login2');
	var mdp1 = document.getElementById('mdp1');
	var mdp2 = document.getElementById('mdp2');
	var nom = document.getElementById('nom');
	var prenom = document.getElementById('prenom');
	var date = document.getElementById('date');
	var rue = document.getElementById('rue');
	var cp = document.getElementById('cp');
	var ville = document.getElementById('ville');
	var mail = document.getElementById('mail');
	if(mdp1.value!=mdp2.value){
		document.getElementById('errorMessage').textContent = "Les mots de passes doivent être identique";
	}
	else{
		var jsonString = JSON.stringify({login:log.value,mdp:mdp1.value,nom:nom.value,prenom:prenom.value,datenaissance:date.value,rue:rue.value,cp:cp.value,ville:ville.value,mail:mail.value});
		$.ajax({
		  type: "POST",
		  url: "http://localhost:28080/Projet_SR03/rest/creer_compte",
		  data: jsonString,
		  contentType: "application/json; charset=utf-8",
		  success: function(data,status){
		  	if(status=='success'){
		  		document.getElementById('newsMessage').textContent = "Compte crée, vous pouvez maintenant vous connecter";
		  	}
		  },
		  error: function(data,status,error){
		  	if(status=='error'){
		  		document.getElementById('errorMessage').textContent = "Création du compte impossible";
		  	}
		  },
		  failure: function(errMsg) {
	        document.getElementById('errorMessage').textContent = "Problème de communication avec le serveur, merci de bien vouloir réessayer ultérieurement";
		  },
		  async: false,
		  dataType: 'json'
		});
	}
}