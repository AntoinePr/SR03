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
function getCookie(name){
	var value = "; " + document.cookie;
	var parts = value.split("; " + name + "=");
	if (parts.length == 2) return parts.pop().split(";").shift();
}
function initCookie(){
	var name=getCookie("path");
	if(name!=null){
		var d = new Date();
	    d.setTime(d.getTime() + (exdays*24*60*60*1000));
	    var expires = "expires="+ d.toUTCString();
	    document.cookie = expires + ";path=/";
	}
}
initCookie();
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
			$("#games").html("<div class='TitreJeu' id='"+cpt+"'>"+res[cpt].nom+"</div><div class='infos id='"+cpt+"'>"+res[cpt].description+'</div>'+"<input type='button' name='Ajouter' value='Ajouter' onClick='addToCart("+cpt+");'/>");
		}
	}
	xhr2.send(null);
}
xhr.open("GET", "http://localhost:28080/Projet_SR03/rest/top_ventes");
xhr.send(null);