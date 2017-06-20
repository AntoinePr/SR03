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
function parseCookie(){
  var cookies = document.cookie;
  var cookieArray = Array();
  cookies.split("; ").forEach(function(element){cookieArray.push([element.split("=")[0], element.split("=")[1]]);});
  return cookieArray;
}
function getGames(){
  var liste = parseCookie();
  var taille=liste.length;
  var newListe=new Array();
  for(var cpt=0; cpt<taille;cpt++){
    if(liste[cpt][0]!="path"&&liste[cpt][0]!="cpt"&&liste[cpt][0]!="expires"&&liste[cpt][0]!="token")
      newListe.push(liste[cpt]);
  }
  return newListe;
}
initCookie();
var cptGlobal=getCookie("cpt");
var jeux="";
var string=getGames();
var cptGlobal=string.length;
for(var cpt=0; cpt<cptGlobal;cpt++){
  if(string[cpt][1]!=""){
    $.ajax({
      type: "GET",
      url: "http://localhost:8080/Projet_SR03/rest/info_jeu/"+string[cpt][0],
      contentType: "application/json; charset=utf-8",
      crossDomain: true,
      success: function(data,status){
        if(status=='success'){
          $("#games").append('<div class="TitreJeu" id="'+cpt+'">'+data[0].nom+"</div><div class='infos' id='"+0+"'>"+data[0].description+"<br>"+data[0].prix+"€<br>"+data[0].datesortie+"<br>"+data[0].raisonsociale+'</div>'+"<input type='button' name='Enlever' value='Enlever' onClick='eraseFromCart(\""+data[0].nom+"\");'/>");
        }
      },
      error: function(data,status,error){
        if(status=='error'){
          $("#errorMessage").html("Panier invalide");
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
function voirAchats(){
  var string = getGames();
  var cptGlobal=string.length;
  for(var cpt=0; cpt<cptGlobal;cpt++){
    jeux=jeux+"/"+string[cpt][0];
  }
  $.ajax({
    type: "GET",
    url: "http://localhost:8080/Projet_SR03/rest/achats",
    contentType: "application/json; charset=utf-8",
    success: function(data,status){
      if(status=='success'){
        for(cpt=0; cpt<data.length;cpt++){
          $("#games").html('<div class="TitreJeu" id="'+cpt+'">'+data[cpt].nom+"</div><div class='infos' id='"+cpt+"'>"+data[cpt].description+"<br>"+data[cpt].prix+"€<br>"+data[cpt].datesortie+"<br>"+data[cpt].raisonsociale+'</div>');
        }
      }
    },
    error: function(data,status,error){
      if(status=='error'){
        $("#errorMessage").html("Panier invalide");
      }
    },
    failure: function(errMsg) {
        $("#errorMessage").html("Problème de communication avec le serveur, merci de bien vouloir réessayer ultérieurement");
    },
    async: true,
    headers: {'Authorization': "Token "+getCookie("token")}
  });
}
function acheter(){
  var string = getGames();
  var cptGlobal=string.length;
  jeux='{"jeux":['
  if (cptGlobal>0)
    jeux+='"'+string[0][0]+'"';
  else
    return null;
  for(var cpt=1; cpt<cptGlobal;cpt++){
    jeux+=',"'+string[cpt][0]+'"';
  }
  jeux+=']}';
  alert(jeux);
  $.ajax({
    type: "POST",
    url: "http://localhost:8080/Projet_SR03/rest/acheter_panier",
    data: jeux,
    contentType: "application/json; charset=utf-8",
    success: function(data,status){
      if(status=='success'){
        for(cpt=0; cpt<data.length;cpt++){
          $("#games").html('Jeux achetés: <div class="TitreJeu" id="'+cpt+'">'+data[cpt].nom+"</div>");
        }
      }
    },
    error: function(data,status,error){
      if(status=='error'){
        $("#errorMessage").html("Panier invalide");
      }
    },
    failure: function(errMsg) {
        $("#errorMessage").html("Problème de communication avec le serveur, merci de bien vouloir réessayer ultérieurement");
    },
    async: true,
    dataType: 'json',
    headers: {'Authorization': "Token "+getCookie("token")}
  });
}
function eraseFromCart(name){
  document.cookie = name + "=;";
  window.location = "./panier.html";
}