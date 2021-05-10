
drop database if exists Velomax;
create database Velomax;
use velomax;
#set sql_safe_updates=0;

drop table if exists Byciclette;
drop table if exists Modèle;

drop table if exists Pièce;
drop table if exists Modèle_pièce;
drop table if exists Fournisseur;

drop table if exists Commande;
drop table if exists Sous_Commande;

drop table if exists Contient_C;
drop table if exists Contient_SC;

drop table if exists Boutique_Spécialisée;
drop table if exists Remise_Commerciale;

drop table if exists Individu;
drop table if exists Programme_Fidelio;

CREATE TABLE Velomax.Modèle (
  id_modèle int,
  data_introduction varchar(20),
  date_discontinuation varchar(20),
  nom VARCHAR(20),
  prix_unitaire float,
  grandeur VARCHAR(20),
  ligne_produit VARCHAR(20),
  
  PRIMARY KEY (id_modèle));

CREATE TABLE Velomax.Byciclette (
  id_byciclette int,
  	nomByciclette VARCHAR(255),
    grandeur INT,
    prix_unitaire INT,
    id_modèle INT,
  PRIMARY KEY (id_byciclette),
  FOREIGN KEY (id_modèle) REFERENCES Modèle(id_modèle) );

CREATE TABLE Velomax.Fournisseur (
  siret int,
  nom_fournisseur VARCHAR(20) ,
  nom_contact_fournisseur VARCHAR(20),
  adresse_fournisseur VARCHAR(20),
  n_libelle int,
  
  
  PRIMARY KEY (siret) );
  
CREATE TABLE Velomax.Modèle_pièce (
  id_modèle_p int ,
  description_modèle_pièce VARCHAR(20),
  prix_unitaire_pièce float,
  siret int ,
  PRIMARY KEY (id_modèle_p),
  FOREIGN KEY (siret) REFERENCES Fournisseur(siret) );
  
CREATE TABLE Velomax.Programme_Fidelio (
  id_programme int,
  description_programme VARCHAR(20),
  couts float,
  durée VARCHAR(2),
  rabais float,

  PRIMARY KEY (id_programme) );

CREATE TABLE Velomax.Pièce (
	id_pièce int,

  id_catalogue_fournisseur VARCHAR(8),
  siret int,
 id_modèle_p int,
  PRIMARY KEY (id_pièce),
   FOREIGN KEY (siret) REFERENCES fournisseur(siret) ,
  FOREIGN KEY (id_modèle_p) REFERENCES Modèle_pièce(id_modèle_p) );
 

CREATE TABLE Velomax.Remise_Commerciale (
  id_remise int,
  pourcentage_remise float,
  
  
  
  PRIMARY KEY (id_remise) );

CREATE TABLE Velomax.Boutique_Spécialisée (
  id_compagnie int,
  nom_compagnie VARCHAR(20) ,
  adresse_compagnie VARCHAR(20) ,
  tel_compagnie VARCHAR(12) ,
  courriel_compagnie  VARCHAR(20) ,
  nom_contact_compagnie VARCHAR(20) ,
  id_remise int,
  
  PRIMARY KEY (id_compagnie),
  FOREIGN KEY (id_remise) REFERENCES Remise_Commerciale(id_remise));
  
CREATE TABLE Velomax.Individu (
	id_ind int,
  prenom_ind VARCHAR(20),
  nom_ind VARCHAR(20) ,
  adresse_ind VARCHAR(20) ,
  tel_ind VARCHAR(20) ,
  courriel_ind VARCHAR(30) ,
  programme_individu int,
  
  PRIMARY KEY (id_ind),
  FOREIGN KEY (programme_individu) REFERENCES Programme_Fidelio(id_programme));
  
CREATE TABLE Velomax.Commande (
  id_commande int,
  date_commande varchar(20),
  date_livraison varchar(20),
  adresse_livraison VARCHAR(30),
  id_client_individu int,
  id_client_boutique int,
  PRIMARY KEY (id_commande),
  FOREIGN KEY (id_client_individu) REFERENCES Individu(id_ind),
  FOREIGN KEY (id_client_boutique) REFERENCES Boutique_Spécialisée(id_compagnie) );
  
CREATE TABLE Velomax.Sous_Commande (
  id_sous_commande int,
  date_sous_commande varchar(8),
  date_livraisonsous_commande varchar(8),
 id_commande int,
 siret int,
  PRIMARY KEY (id_sous_commande) ,
  FOREIGN KEY (id_commande) REFERENCES Commande(id_commande),
  FOREIGN KEY (siret) REFERENCES Fournisseur(siret));

CREATE TABLE Velomax.Contient_C (
 id_sous_commande int, 
 id_commande int,
 id_byciclette int,
 id_pièce int, 
  PRIMARY KEY (id_sous_commande) ,
  FOREIGN KEY (id_commande) REFERENCES Commande(id_commande),
  FOREIGN KEY (id_byciclette) REFERENCES Byciclette(id_byciclette),
  FOREIGN KEY (id_pièce) REFERENCES Pièce(id_pièce));
  
CREATE TABLE Velomax.Contient_SC (

id_sous_commande int,
id_pièce int,
  FOREIGN KEY (id_sous_commande) REFERENCES Sous_Commande(id_sous_commande),
  FOREIGN KEY (id_pièce) REFERENCES Pièce(id_pièce));

insert into remise_commerciale(id_remise, pourcentage_remise) values (1,20);
insert into remise_commerciale(id_remise, pourcentage_remise) values (2,30);
insert into remise_commerciale(id_remise, pourcentage_remise) values (3,40);
insert into remise_commerciale(id_remise, pourcentage_remise) values (4,50);

insert into boutique_spécialisée(id_compagnie, nom_compagnie, adresse_compagnie, tel_compagnie, courriel_compagnie, nom_contact_compagnie, id_remise) values (1,"compagnie1","Paris","0652947658","adresse1","Gilbert",1);
insert into boutique_spécialisée(id_compagnie, nom_compagnie, adresse_compagnie, tel_compagnie, courriel_compagnie, nom_contact_compagnie, id_remise) values (2,"compagnie2","Londres","0652947658","adresse2","Max",3);
insert into boutique_spécialisée(id_compagnie, nom_compagnie, adresse_compagnie, tel_compagnie, courriel_compagnie, nom_contact_compagnie, id_remise) values (3,"compagnie3","NewYork","0652947658","adresse3","Jean",4);
insert into boutique_spécialisée(id_compagnie, nom_compagnie, adresse_compagnie, tel_compagnie, courriel_compagnie, nom_contact_compagnie, id_remise) values (4,"compagnie4","Berlin","0652947658","adresse4","Léonard",2);

insert into modèle(id_modèle, data_introduction, date_discontinuation, nom, prix_unitaire, grandeur, ligne_produit) values (1,"4 avril 1999","30 mai 2005","Speed+",250,120,4);
insert into modèle(id_modèle, data_introduction, date_discontinuation, nom, prix_unitaire, grandeur, ligne_produit) values (2,"8 avril 1999","30 juin 2008","AirForce",400,160,3);
insert into modèle(id_modèle, data_introduction, date_discontinuation, nom, prix_unitaire, grandeur, ligne_produit) values (3,"12 avril 1999","30 décembre 2007","Billy",108,74,1);
insert into modèle(id_modèle, data_introduction, date_discontinuation, nom, prix_unitaire, grandeur, ligne_produit) values (4,"22 avril 1999","30 janvier 2020","Light",800,250,1);

insert into fournisseur(siret, nom_fournisseur, nom_contact_fournisseur, adresse_fournisseur, n_libelle) values (1,"veloProd","Romain Girodet","Rouen",1);
insert into fournisseur(siret, nom_fournisseur, nom_contact_fournisseur, adresse_fournisseur, n_libelle) values (2,"CreationVelo","Léonard Desportes","Chambly",2);
insert into fournisseur(siret, nom_fournisseur, nom_contact_fournisseur, adresse_fournisseur, n_libelle) values (3,"Industrie2Roues","Maxime Dennery","Lille",1);
insert into fournisseur(siret, nom_fournisseur, nom_contact_fournisseur, adresse_fournisseur, n_libelle) values (4,"ArtisaVélo","Maher Rebai","Strasbourg",1);

insert into programme_fidelio(id_programme, description_programme, couts, durée, rabais) values (1,"programme1",500,"8",20);
insert into programme_fidelio(id_programme, description_programme, couts, durée, rabais) values (2,"programme2",600,"10",25);
insert into programme_fidelio(id_programme, description_programme, couts, durée, rabais) values (3,"programme3",1400,"70",30);
insert into programme_fidelio(id_programme, description_programme, couts, durée, rabais) values (4,"programme4",550,"40",70);

insert into individu(id_ind, prenom_ind, nom_ind, adresse_ind, tel_ind, courriel_ind, programme_individu) values (1,"anais","dede","adresse","06","adresse_electronique",2);
insert into individu(id_ind, prenom_ind, nom_ind, adresse_ind, tel_ind, courriel_ind, programme_individu) values (2,"chris","fr","adresse","06","adresse_electronique",1);
insert into individu(id_ind, prenom_ind, nom_ind, adresse_ind, tel_ind, courriel_ind, programme_individu) values (3,"bernard","poix","adresse","06","adresse_electronique",3);
insert into individu(id_ind, prenom_ind, nom_ind, adresse_ind, tel_ind, courriel_ind, programme_individu) values (4,"michel","tong","adresse","06","adresse_electronique",3);

insert into commande(id_commande, date_commande, date_livraison, adresse_livraison, id_client_individu, id_client_boutique) values (1,"7 mars 1975","4 février 1976","adresse",1,1);
insert into commande(id_commande, date_commande, date_livraison, adresse_livraison, id_client_individu, id_client_boutique) values (2,"10 mars 1975","25 février 1976","adresse",2,2);
insert into commande(id_commande, date_commande, date_livraison, adresse_livraison, id_client_individu, id_client_boutique) values (3,"4 mars 1975","28 février 1976","adresse",3,3);
insert into commande(id_commande, date_commande, date_livraison, adresse_livraison, id_client_individu, id_client_boutique) values (4,"11 mars 1975","12 février 1976","adresse",4,4);

insert into modèle_pièce(id_modèle_p, description_modèle_pièce, prix_unitaire_pièce, siret) values (1,"modèle1",120,4);
insert into modèle_pièce(id_modèle_p, description_modèle_pièce, prix_unitaire_pièce, siret) values (2,"modèle2",200,4);
insert into modèle_pièce(id_modèle_p, description_modèle_pièce, prix_unitaire_pièce, siret) values (3,"modèle3",45,3);
insert into modèle_pièce(id_modèle_p, description_modèle_pièce, prix_unitaire_pièce, siret) values (4,"modèle4",78,1);

insert into pièce(id_pièce, siret, id_catalogue_fournisseur, id_modèle_p) values (1,3,335,2);
insert into pièce(id_pièce, siret, id_catalogue_fournisseur, id_modèle_p) values (2,4,355,3);
insert into pièce(id_pièce, siret, id_catalogue_fournisseur, id_modèle_p) values (3,2,147,3);
insert into pièce(id_pièce, siret, id_catalogue_fournisseur, id_modèle_p) values (4,1,963,2);



#select * from remise_commerciale;
#select * from boutique_spécialisée; 
#select * from modèle;
#select * from fournisseur;
#select * from programme_fidelio;
select * from individu;
#select * from commande;
select * from modèle_pièce;
select * from pièce;

  
  

  
     