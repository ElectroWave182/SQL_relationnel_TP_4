\echo [INFO] Debut du script

\echo [INFO] Creation de la base de donnees resaBateau
DROP DATABASE IF EXISTS resaBateau;
CREATE DATABASE resabateau ENCODING 'UTF8';

\echo [INFO] Connexion a la nouvelle base de donnees resaBateau

\c resabateau

SET DATESTYLE='DMY';


CREATE TABLE Proprietaire
   (
    idProprio INT  PRIMARY KEY,
    nomP VARCHAR(40)  NOT NULL ,
    prenomP VARCHAR(40) NOT NULL,
	emailP VARCHAR(40) UNIQUE
   ) ;
   

CREATE TABLE Bateau
   (
    noImm VARCHAR(40)  PRIMARY KEY,
    nomB VARCHAR(40),
	longueurB INT ,
	largeurB INT 
	CONSTRAINT nnlargeurB NOT NULL
	CONSTRAINT ckLargeurB CHECK (largeurB <= 6),
	leProprio INT NOT NULL
	CONSTRAINT fkBateauProprietaire REFERENCES Proprietaire(idProprio)
   ) ;
   
   
CREATE TABLE Emplacement
   (
    noEmpl INT  PRIMARY KEY,
    longueur INT
	CONSTRAINT nnlongueur NOT NULL
	CONSTRAINT ckLongueur CHECK (longueur>=3 and longueur <= 20),
	leBateau VARCHAR(40)
    CONSTRAINT fkEmplacementBateau REFERENCES Bateau(noImm) DEFAULT NULL,
    dateD DATE DEFAULT NULL,
    dateF DATE DEFAULT NULL
   ) ;
   
CREATE TABLE Reservation
   (numResa INT  PRIMARY KEY,
    dateDebut DATE CONSTRAINT nndateDebut NOT NULL,
    dateFin DATE CONSTRAINT nndateFin NOT NULL,
	lEmplacement INT,
	leBateau VARCHAR(40) CONSTRAINT nnleBateau NOT NULL
	CONSTRAINT fkReservationBateau REFERENCES Bateau(noImm)
   ) ;

