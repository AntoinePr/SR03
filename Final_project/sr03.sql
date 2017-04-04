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
VALUES('Skyrim',29.99,TO_DATE('07-06-2013','DD-MM-YYYY'),'48215151100029',"The Elder Scrolls V : Skyrim. Sorti fin 2011, Skyrim r�invente le jeu de r�le en monde ouvert tout en repoussant les contraintes du gameplay et de la technologie pour offrir un univers de jeu plein de vie et de r�alisme. 6 ans apr�s la sortie de The Elder Scrolls IV : Oblivion�, 4�me volet de cette saga, The Elder Scrolls V : Skyrim�, a �t� �lu jeu de l�ann�e 2011.   - The Elder Scrolls V : Skyrim - Dawnguar. Sorti en aout 2012, Dawnguard� est la premi�re extension officielle du jeu de l�ann�e 2011, The Elder Scrolls V: Skyrim�. Le seigneur vampire Harkon est revenu au pouvoir. � l'aide des Parchemins des Anciens, il cherche � r�aliser l�impensable : �teindre le soleil. Rejoindrez-vous l�ancien ordre de la Garde de l�aube pour contrecarrer ce projet ? Ou choisirez-vous d�incarner un seigneur vampire ? Dans ce contenu comprenant une nouvelle s�rie de qu�tes de faction et des lieux in�dits, c�est � vous de prendre la d�cision finale.   - The Elder Scrolls V : Skyrim - Hearthfire : Sortie en Septembre 2012, et deuxi�me extension officielle de The Elder Scrolls V: Skyrim, Hearthfire� vous permettra d'acheter des terres et de construire votre demeure comme bon vous semblera, d'une petite chaumi�re � un domaine contenant armurerie, laboratoire d'alchimie, �curie, jardin et bien plus. Servez-vous des nouveaux outils tels que la table de dessin et l'�tabli du charpentier pour transformer pierres, argile et bois en charpentes et meubles. Vous pourrez m�me cr�er un v�ritable foyer en adoptant un enfant.   - The Elder Scrolls V : Skyrim � Dragonborn : Sortie fin 2012 sur PC et Xbox 360�, puis d�but 2013 sur PlayStation�3, cette derni�re extension officielle de The Elder Scrolls V: Skyrim, vous invitera � partir pour l'�le de Solstheim, au large de Morrowind. D�couvrez de nouveaux donjons, des villes et des qu�tes in�dites et explorez les �tendues d�sertiques recouvertes de cendres ou les vall�es glaciales de cet environnement inconnu. Gagnez en puissance gr�ce � de nouveaux cris qui soumettent vos ennemis � votre volont� et permettent de dompter les dragons eux-m�mes. Votre destin�e est li�e � celle de Solstheim et elle ne tient qu'� un fil car vous devrez affronter le plus redoutable des adversaires : le premier Enfant de dragon.");
INSERT INTO jeux (nom,prix,dateSortie,editeur,description)
VALUES('Starcraft II',39.90,TO_DATE('29-11-2016','DD-MM-YYYY'),'48995245700039',"Avec des millions de joueurs d�j� engag�s dans le combat, StarCraft� II a marqu� l�histoire du jeu vid�o. � vous maintenant de conqu�rir l�espace � la t�te de vastes arm�es de Terrans, de Protoss et de Zergs. Tenez-vous pr�t pour la guerre interstellaire, commandant. Vous �tes attendu de pied ferme sur le front.

Points forts

- Menez d�immenses campagnes militaires � Plongez au c�ur de trois campagnes en solo palpitantes et menez � bien plus de 70 missions.

- Combattez avec ou contre les autres � Alliez-vous � d�autres joueurs gr�ce au mode Commandant en coop ou mesurez-vous � eux gr�ce aux ligues comp�titives de tous niveaux. ");
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
