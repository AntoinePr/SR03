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
	var name=getCookie("cpt");
	if(name=="NaN"||name=="undefined"||name==null){
		var d = new Date();
	    d.setTime(d.getTime() + (24*60*60*1000));
	    var expires = "expires="+ d.toUTCString();
	    document.cookie =expires + ";path=/";
	    document.cookie = "cpt=0";
	}
}
initCookie();
$.ajax({
      type: "GET",
      url: "http://localhost:8080/Projet_SR03/rest/top_ventes",
      contentType: "application/json; charset=utf-8",
      crossDomain: true,
      success: function(data,status){
        if(status=='success'){
          for(var cpt=0; cpt<data.length;cpt++){
		    $.ajax({
		      type: "GET",
		      url: "http://localhost:8080/Projet_SR03/rest/info_jeu/"+data[cpt].jeu,
		      contentType: "application/json; charset=utf-8",
		      crossDomain: true,
		      success: function(datas,status){
		        if(status=='success'){
		          $("#games").append('<div class="TitreJeu" id="'+cpt+'">'+datas[0].nom+"</div><div class='infos' id='"+cpt+"'>"+datas[0].description+"<br>"+datas[0].prix+"€<br>"+datas[0].datesortie+"<br>"+datas[0].raisonsociale+'</div>'+"<input type='button' name='Ajouter' value='Ajouter' onClick='addToCart(\""+datas[0].nom+"\");'/>");
		        }
		      },
		      error: function(data,status,error){
		        if(status=='error'){
		          $("#errorMessage").html("Jeu invalide");
		        }
		      },
		      failure: function(errMsg) {
		          $("#errorMessage").html("Problème de communication avec le serveur, merci de bien vouloir réessayer ultérieurement");
		      },
		      async: true,
		      dataType: 'json'
		    });
		  	}
    	}
  	   },
  		error: function(data,status,error){
        if(status=='error'){
          $("#errorMessage").html("Jeu invalide");
        }
      },
      failure: function(errMsg) {
          $("#errorMessage").html("Problème de communication avec le serveur, merci de bien vouloir réessayer ultérieurement");
      },
      async: true,
      dataType: 'json'
    });