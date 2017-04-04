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
	description VARCHAR,
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
VALUES('Skyrim',29.99,TO_DATE('07-06-2013','DD-MM-YYYY'),'48215151100029',"The Elder Scrolls V : Skyrim. Sorti fin 2011, Skyrim réinvente le jeu de rôle en monde ouvert tout en repoussant les contraintes du gameplay et de la technologie pour offrir un univers de jeu plein de vie et de réalisme. 6 ans après la sortie de The Elder Scrolls IV : Oblivion™, 4ème volet de cette saga, The Elder Scrolls V : Skyrim®, a été élu jeu de l’année 2011.   - The Elder Scrolls V : Skyrim - Dawnguar. Sorti en aout 2012, Dawnguard™ est la première extension officielle du jeu de l’année 2011, The Elder Scrolls V: Skyrim®. Le seigneur vampire Harkon est revenu au pouvoir. À l'aide des Parchemins des Anciens, il cherche à réaliser l’impensable : éteindre le soleil. Rejoindrez-vous l’ancien ordre de la Garde de l’aube pour contrecarrer ce projet ? Ou choisirez-vous d’incarner un seigneur vampire ? Dans ce contenu comprenant une nouvelle série de quêtes de faction et des lieux inédits, c’est à vous de prendre la décision finale.   - The Elder Scrolls V : Skyrim - Hearthfire : Sortie en Septembre 2012, et deuxième extension officielle de The Elder Scrolls V: Skyrim, Hearthfire™ vous permettra d'acheter des terres et de construire votre demeure comme bon vous semblera, d'une petite chaumière à un domaine contenant armurerie, laboratoire d'alchimie, écurie, jardin et bien plus. Servez-vous des nouveaux outils tels que la table de dessin et l'établi du charpentier pour transformer pierres, argile et bois en charpentes et meubles. Vous pourrez même créer un véritable foyer en adoptant un enfant.   - The Elder Scrolls V : Skyrim – Dragonborn : Sortie fin 2012 sur PC et Xbox 360™, puis début 2013 sur PlayStation®3, cette dernière extension officielle de The Elder Scrolls V: Skyrim, vous invitera à partir pour l'île de Solstheim, au large de Morrowind. Découvrez de nouveaux donjons, des villes et des quêtes inédites et explorez les étendues désertiques recouvertes de cendres ou les vallées glaciales de cet environnement inconnu. Gagnez en puissance grâce à de nouveaux cris qui soumettent vos ennemis à votre volonté et permettent de dompter les dragons eux-mêmes. Votre destinée est liée à celle de Solstheim et elle ne tient qu'à un fil car vous devrez affronter le plus redoutable des adversaires : le premier Enfant de dragon.");
INSERT INTO jeux (nom,prix,dateSortie,editeur,description)
VALUES('Starcraft II',39.90,TO_DATE('29-11-2016','DD-MM-YYYY'),'48995245700039',"Avec des millions de joueurs déjà engagés dans le combat, StarCraft® II a marqué l’histoire du jeu vidéo. À vous maintenant de conquérir l’espace à la tête de vastes armées de Terrans, de Protoss et de Zergs. Tenez-vous prêt pour la guerre interstellaire, commandant. Vous êtes attendu de pied ferme sur le front.

Points forts

- Menez d’immenses campagnes militaires – Plongez au cœur de trois campagnes en solo palpitantes et menez à bien plus de 70 missions.

- Combattez avec ou contre les autres – Alliez-vous à d’autres joueurs grâce au mode Commandant en coop ou mesurez-vous à eux grâce aux ligues compétitives de tous niveaux. ");
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
