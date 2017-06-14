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

function checkEntry(){
	var log = document.getElementById('login');
	var mdp = document.getElementById('mdp');
	xhr=getXhr();
	xhr.onload=function(){
		var top = JSON.parse(xhr.responseText);
		var jeux="";
		for(var cpt=0; cpt<top.length;cpt++){
			jeux+="/"+top[cpt].jeu;
		}
	}
	xhr.open("POST", "http://localhost:28080/Projet_SR03/rest/connexion");
	xhr.setRequestHeader('Content-Type','application/json');
	var jsonString = JSON.stringify({login:log.value,mdp:mdp.value});
	xhr.send(jsonString);
}