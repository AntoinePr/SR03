CREATE TABLE Adherent (
	login VARCHAR PRIMARY KEY,
	mdp VARCHAR NOT NULL,
	nom VARCHAR NOT NULL,
	prenom VARCHAR NOT NULL,
	dateNaissance DATE,
	rue VARCHAR,
	cp CHAR(5),
	ville VARCHAR
);
CREATE TABLE Editeur(
	raisonSociale VARCHAR UNIQUE NOT NULL,
	siret INTEGER PRIMARY KEY,
	CHECK(siret>0)
);
CREATE TABLE Jeux(
	nom VARCHAR PRIMARY KEY,
	prix FLOAT,
	description VARCHAR,
	dateSortie DATE,
	editeur INTEGER REFERENCES Editeur(siret)
);
CREATE TABLE Type(
	nomType VARCHAR PRIMARY KEY
);
CREATE TABLE Plateforme(
	nomPlateforme VARCHAR PRIMARY KEY
);
CREATE TABLE Commentaire(
	jeu VARCHAR REFERENCES Jeux(nom),
	adh VARCHAR REFERENCES Adherent(login),
	description VARCHAR,
	dateCom DATE,
	PRIMARY KEY(jeu,adh,dateCom)
);
CREATE TABLE Achats(
	jeu VARCHAR REFERENCES Jeux(nom),
	adh VARCHAR REFERENCES Adherent(login),
	PRIMARY KEY(jeu,adh)
);
CREATE TABLE Support(
	jeu VARCHAR REFERENCES Jeux(nom),
	platef VARCHAR REFERENCES Plateforme(nomPlateforme),
	PRIMARY KEY(jeu,platef)
);
CREATE TABLE Appartient(
	jeu VARCHAR REFERENCES Jeux(nom),
	typ VARCHAR REFERENCES Type(nomType),
	PRIMARY KEY(jeu,typ)
);
