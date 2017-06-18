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
xhr=getXhr();
xhr.onload=function(){
	var top = JSON.parse(xhr.responseText);
	var jeux="";
	for(var cpt=0; cpt<top.length;cpt++){
		jeux+="/"+top[cpt].jeu;
	}
	xhr2=getXhr();
	xhr2.open("GET","http://localhost:28080/Projet_SR03/rest/recherche_jeu"+jeux);
	xhr2.onload=function(){
		var res = JSON.parse(xhr2.responseText);
		for(cpt=0; cpt<res.length;cpt++){
			document.getElementById('games').innerHTML='<div class="TitreJeu">'+res[cpt].nom+"</div><div class='infos'>"+res[cpt].description+'</div>';
		}
	}
	xhr2.send(null);
}
xhr.open("GET", "http://localhost:28080/Projet_SR03/rest/top_ventes");
xhr.send(null);
alert(document.cookie);