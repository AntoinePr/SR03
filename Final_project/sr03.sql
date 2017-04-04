CREATE TABLE Adherent (
	login VARCHAR PRIMARY KEY,
	mdp VARCHAR NOT NULL,
	nom VARCHAR NOT NULL,
	prenom VARCHAR NOT NULL,
	dateNaissance DATE,
	rue VARCHAR,
	cp CHAR(5),
	ville VARCHAR,
	mail VARCHAR
);
CREATE TABLE Editeur(
	raisonSociale VARCHAR UNIQUE NOT NULL,
	siret CHAR(14) PRIMARY KEY
);
CREATE TABLE Jeux(
	nom VARCHAR PRIMARY KEY,
	prix FLOAT,
	description TEXT,
	dateSortie DATE,
	editeur CHAR(14) REFERENCES Editeur(siret) NOT NULL
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

INSERT INTO adherent (login,mdp,nom,prenom,dateNaissance,rue,cp,ville,mail) 
VALUES('jonpie','motDePasse','Jonson','Pierre',TO_DATE('10-12-1990','DD-MM-YYYY'),'40 avenue de Brest','42150','Boston','pierre.jonson@gmail.com');
INSERT INTO adherent (login,mdp,nom,prenom,dateNaissance,rue,cp,ville,mail)
VALUES('marben','motDePasse2','Mare','Benjamin',TO_DATE('23-05-1996','DD-MM-YYYY'),'51 bvd des etats unis','60200','Compiegne','benjamin.mare@etu.utc.fr');
INSERT INTO adherent (login,mdp,nom,prenom,dateNaissance,rue,cp,ville,mail)
VALUES('proant','motDePasse3','Protard','Antoine',TO_DATE('10-02-1994','DD-MM-YYYYY'),'1 rue roger couttolenc','60200','Compiegne','antoine.protard@etu.utc.fr');
INSERT INTO editeur (raisonSociale,siret)
VALUES('Bethesda','48215151100029');
INSERT INTO editeur (raisonSociale,siret)
VALUES('Blizzard','48995245700039');
INSERT INTO jeux (nom,prix,dateSortie,editeur,description)
VALUES('Skyrim',29.99,TO_DATE('07-06-2013','DD-MM-YYYY'),'48215151100029',"Description bien écrite");
INSERT INTO jeux (nom,prix,dateSortie,editeur,description)
VALUES('Starcraft II',39.90,TO_DATE('29-11-2016','DD-MM-YYYY'),'48995245700039',"Desc du jeu trop bien");
INSERT INTO jeux (nom,prix,dateSortie,editeur,description)
VALUES();
INSERT INTO VALUES();
INSERT INTO VALUES();
INSERT INTO VALUES();
INSERT INTO VALUES();
INSERT INTO VALUES();
INSERT INTO VALUES();
INSERT INTO VALUES();
INSERT INTO VALUES();
INSERT INTO VALUES();
INSERT INTO VALUES();
INSERT INTO VALUES();
INSERT INTO VALUES();
INSERT INTO VALUES();
