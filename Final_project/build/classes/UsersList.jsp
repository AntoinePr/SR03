<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="beans.Utilisateur"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Liste des utilisateurs</title>
</head>
<body>
<h1>Users List</h1>
<h4>Trier par</h4>
Tri :
<form method="post" action="GestionUsers">
	<input name="sortType" type="radio" value="1"/>nom
	<input name="sortType" type="radio" value="2"/>username
	<input type="hidden" name="action" value="sort" />
	<input type="submit" value="Trier" />
</form>

<table border="1">
<tr>
	<th>ID</th>
	<th>
		<a href="GestionUsers?action=sort">NOM</a>
	</th>
	<th>TEL</th>
	<th>USERNAME</th>
	<th>ACTIONS</th>
</tr>
	<%
		Object obj = request.getAttribute("listeU");
		if(obj!=null){
			List<Utilisateur> lu = (List<Utilisateur>)obj;
			for(Utilisateur u : lu){
	%>
			<tr>
				<td><%=u.getId()%></td>
				<td><%=u.getNom()%></td>
				<td><%=u.getTel()%></td>
				<td><%=u.getUsername()%></td>
				<td>
					<a href="GestionUsers?action=supprimer&id=<%=u.getId()%>">Supprimer</a>
					<a href="GestionUsers?action=modifier&id=<%=u.getId()%>">Modifier</a>	
				</td>
			</tr>
	<%
			}
			
			
		}
	%>
</table>

<h3>
<a href="GestionUsers">Ajout</a>
/Modif</h3>

<form method="post" action="GestionUsers">
		<label for="Nom">Nom :</label>
		<input type="text" name="nom" id="nom" value="${uModif.nom}"/>
		<br />
		<label for="Tel">Tel :</label>
		<input type="text" name="tel" id="tel" value="${uModif.tel}"/>
		<br />
		<label for="Username">Username :</label>
		<input type="text" name="username" id="username" value="${uModif.username}"/>
		<br />
		<label for="Pwd">Password :</label>
		<input type="text" name="pwd" id="pwd" value="${uModif.pwd}"/>
		<br />
		<input type="hidden" name=id value="${uModif.id}"/>
		<input type="submit" value="Valider" />
	</form>

</body>
</html>