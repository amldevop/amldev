SHOW DATABASES; -- Permet de voir toutes les BDD

CREATE DATABASE cours_sql_entreprise ; -- Permet de créer une BDD

USE cours_sql_entreprise ; -- Permet de préciser sur quel BDD on souhaite agir.

DROP DATABASE cours_sql_entreprise ; -- Permet de supprimer la BDD

DROP TABLE employes ; -- Permet de supprimer une Table

TRUNCATE nom_de_la_table ; -- Permet de vider une Table

-- ###### REQUETE DE SELECTION ###### -- 

-- Affichage complet des employes
SELECT id_employes, prenom, nom, sexe, service, date_embauche, salaire FROM employes ;
SELECT * FROM employes ;
-- Affiche moi tout depuis la TABLE employes


-- Quels sont les noms et prénoms des employés de l'entreprise ?
SELECT prenom, nom FROM employes ;

-- EXERCICE : 
-- Quels sont les différents services occupés par les employés ?
SELECT service FROM employes ; 
-- J'ai tous les services mais il y a des doublons. 


-- DISTINCT 
-- Affichage des services sans doublons 
SELECT DISTINCT service FROM employes ; 
-- DISTINCT permet de supprimer les doublons.


-- Condition WHERE 
-- Affichage des employés du service informatique 
SELECT nom, prenom service FROM employes WHERE service = "informatique" ;
-- WHERE = à condition que 
-- WHERE colonne ... valeur

-- BETWEEN 
-- Affichage des employés ayant été recruté entre 2012 et aujourd'hui
SELECT nom, prenom, date_embauche FROM employes WHERE date_embauche BETWEEN "2012-01-01" AND "2022-04-29" ;

SELECT CURDATE(); -- Fonction Prédéfinies de SQL qui permet de récupérer la date du jour. 

SELECT nom, prenom, date_embauche FROM employes WHERE date_embauche BETWEEN "2012-01-01" AND CURDATE() ;

-- PAS DE DIFFÉRENCE entre les simples quotes et le double quotes
-- BETWEEN .. AND .. 

-- LIKE 
-- Affichage des employés qui ont un prénom commençant par la lettre "s"
SELECT prenom FROM employes WHERE prenom LIKE "s%" ; -- Je souhaite connaitre les prénoms commençant par la chaine de caratère "s"
SELECT prenom FROM employes WHERE prenom LIKE "%s" ; -- Je souhaite connaitre les prénoms terminant par la chaine de caratère "s"
SELECT prenom FROM employes WHERE prenom LIKE "%u%" ; -- Je souhaite connaitre les prénoms contenant par la chaine de caratère "u"


-- Affichage de tous les employes (sauf les informaticien) 
-- Je veux afficher le nom, le prenom, le service de tous les employes NE travaillant pas dans le service "informatique".
SELECT nom, prenom, service FROM employes WHERE service != "informatique" ;
-- != => différent de

-- Affichage de tous les employés gagnant un salaire supèrieur à 3000€ 
SELECT * FROM employes WHERE salaire > 3000 ;


-- ORDER BY
-- Affichage des employés dans l'ordre alphabétique
SELECT prenom FROM employes ORDER BY prenom ASC ; -- Du haut vers le bas
SELECT prenom FROM employes ORDER BY prenom DESC ; -- Du bas vers le haut

SELECT prenom, salaire FROM employes ORDER BY salaire DESC, prenom ASC; -- On classe d'abord les salaires puis si 2 employés on le même salaire on les classes par ordre Alphabétique. 

-- ORDER BY permet d'effectuer un classement
-- ASC : Ascendant / croissant
-- DESC : Descendant / décroissant


-- Affichage des employes 3 par 3 
SELECT prenom FROM employes ORDER BY prenom ASC LIMIT 3 ;
SELECT prenom FROM employes ORDER BY prenom ASC LIMIT 3,3 ;
SELECT prenom FROM employes ORDER BY prenom ASC LIMIT 6,3 ;
-- LIMIT est utilisé pour faire de la pagination. 
-- Si je n'ai qu'un seul chiffre après LIMIT cela correspond au nombre d'occurences souhaités.
-- Si j'ai 2 chiffres le premier correspond à l'index ou je souhaite commencer et le deuxième correspond toujours à la limite du nombre d'occurences.


-- Affichage des employés avec leur salaire annuel 
SELECT prenom, salaire*12 FROM employes ;
SELECT prenom, salaire*12 AS "salaire_annuel" FROM employes ;
-- AS -> permet de créer Alias. C'est plus simple d'utiliser "salaire_annuel" dans mon code que "salaire*12"


-- SUM 
-- Affichage de la masse salarial sur 12 mois
SELECT SUM(salaire*12) AS "masse_salarial_annuel" FROM employes ; 
-- SUM : permet de faire la somme de la propriété selectionnée. 

-- AVG
-- Affichage de la moyenne des salaire
SELECT AVG(salaire) FROM employes ; 
-- AVG -> permet de faire la moyenne
-- Arrondire le résultat obtenu
SELECT ROUND(AVG(salaire)) FROM employes ;
SELECT ROUND(AVG(salaire), 2) AS "salaire_moyen" FROM employes ;
-- ROUND -> permet d'arrondir le résulat. 
-- Si je n'ai qu'un paramètre j'arrondie à l'entier supèrieur. 
-- Si je souhaite garder des chiffres après la virgule, je passe une deuxième paramètre qui est le nombre de chiffre que je souhaite. (ici dans l'exemple "2")

-- COUNT
-- Affichage du nombre de femme ou d'homme dans l'entreprise
SELECT COUNT(*) FROM employes WHERE sexe = "f" ;
-- COUNT permet de compter le nombre d'occurences de ma requête. 

-- MIN / MAX
-- Affichage du salaire le plus haut / le plus bas. 
SELECT MIN(salaire) FROM employes ;
SELECT MAX(salaire) FROM employes ;


-- PETITE INTRO AUX requete IMBRIQUES
-- Je souhaite savoir le prenom et le salaire de la personne qui gagne le salaire le plus bas. 
SELECT prenom, salaire FROM employes WHERE salaire = 1390 ;
SELECT prenom, salaire FROM employes WHERE salaire = (
    SELECT MIN(salaire) FROM employes
) ;


-- IN 
-- Affichage des employes qui travaillent dans le service informatique et comptabilite
SELECT prenom, service FROM employes WHERE service = "informatique" OR service = "comptabilite" OR service = "assitant";
SELECT prenom, service FROM employes WHERE service IN ("informatique", "comptabilite");

-- NOT IN 
SELECT prenom, service FROM employes WHERE service NOT IN ("informatique", "comptabilite");

-- IN -> Permet de vérifier si la valeur est présente dans le tableau
-- NOT IN -> le contraire de IN. 
-- NOT IN permet d'exclure plusieurs valeurs // != permet d'exclure 1 seule valeur.

-- Exercice 
-- Affichage des commerciaux gagnant un salaire infèrieur ou égal à 2000€
SELECT prenom, nom, salaire, service FROM employes 
WHERE service = "commercial"
AND salaire <= 2000
;
-- Résultat attendu : 
-- +-----------+---------+---------+------------+
-- | prenom    | nom     | salaire | service    |
-- +-----------+---------+---------+------------+
-- | Guillaume | Miller  |    1900 | commercial |
-- | Emilie    | Sennard |    1800 | commercial |
-- +-----------+---------+---------+------------+


-- GROUP BY
-- Affichage du nombre d'employe par service
SELECT service , COUNT(*) as "nombre" FROM employes GROUP BY service ;

SELECT service FROM employes  ;
-- Cette requête permet d'afficher tous les services avec les doublons 

SELECT COUNT(*)  FROM employes  ;
-- Celle-ci permet d'afficher le nombre de résultat (occurences).  
-- Sans Group By le SGBD ne peut pas combiner les 2 requêtes. On a besoin de lui dire que le COUNT() veut compter les doublons de mes services. 

-- Resulat obtenu :
-- +---------------+--------+
-- | service       | nombre |
-- +---------------+--------+
-- | assistant     |      1 |
-- | commercial    |      6 |
-- | communication |      1 |
-- | comptabilite  |      1 |
-- | direction     |      2 |
-- | informatique  |      3 |
-- | juridique     |      1 |
-- | production    |      2 |
-- | secretariat   |      3 |
-- +---------------+--------+



-- ########## REQUETE D'INSERTION ##########
-- J'insère à l'intèrieur d'employes les valeurs suivante ...
-- L'ordre des valeurs que l'on indique EST TRES IMPORANT on doit respecter l'ordre donné dans la Table. 
-- id, prenom, nom ... 
-- l'ID doit être géré automatiquement. Pour que le système comprenne qu'il doit le gérer, on a indiquer Auto-Increment et dans les valeurs on lui indique la valeur 'NULL'
INSERT INTO employes VALUES (NULL, 'quentin', 'vilfeu', 'm', 'informatique', '2022-05-02', 4300);

INSERT INTO employes (prenom, nom, service, date_embauche, salaire, sexe) VALUES ('thomas', 'legendre', "informatique", '2022-02-02', 2333, 'm'); 

-- ########## REQUETE DE MODIFICATION ##########
-- UPDATE est toujours suivi du nom de la colonne PUIS des valeurs que l'on souhaite modifier. 
-- ATTENTION si on ne précise sur quel ID on souhaite faire la modif, TOUTES nos lignes seront affectées.
UPDATE employes SET salaire = 1391 WHERE id_employes = 699 ;

UPDATE employes SET salaire = 1392, service = "informatique" WHERE id_employes = 699 ;


-- REPLACE 
-- REPLACE va agir soit comme un INSERT soit comme un UPDATE en fonction de l'id passé dans les valeurs. 
-- SI l'id existe déjà il me fera un UPDATE et SI l'ID n'existe pas il fera un INSERT.
REPLACE INTO employes (id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES (NULL, "toto", "tata", "f", "comptabilite", "2022-01-01", 2000) ; 
REPLACE INTO employes (id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES (993, "Sacha", "Hutte", "f", "comptabilite", "2022-01-01", 2000) ; 


-- ########## REQUETE DE SUPPRESSION ##########

DELETE FROM employes ; -- ici je vais supprimer toutes les données de la table. 
TRUNCATE employes ; -- ON VIDE LA TABLE. Elle sera toujours présente mais sans données. 

-- Aucune différence entre "DELETE FROM employes ;" et "TRUNCATE employes ;"
DROP employes ; -- ON SUPPRIME LA TABLE 

DELETE FROM employes WHERE id_employes = 994;

DELETE FROM employes WHERE nom = "Hutte"; -- Cela fonctionne mais supprimera tous les employes avec ce nom

DELETE FROM employes WHERE service = "informatique" AND id_employes != 991 ;



-- ########## REGLES DE GESTION AU NIVEAU DES CLES ETRANGÈRES ##########

-- Exemple de liaison entre secteur et employes

-- RESTRICT => Nous empèche de modifier/supprimer une occurences si elle est liée à une autre occurence dans la table de liaison (Si je supprime un secteur et qu'un employé fais partie de ce secteur alors je ne pourrais supprimer ce secteur)
-- NO ACTION => idem que la partie RESTRICT 
-- SET NULL => On remplace l'id indiqué dans la table employé par une valeur 'NULL' (ex : Jean Pierre travaille dans le secteur 5. Si je supprime le secteur 5 alors Jean Pierre aura 'NULL' pour valeur au niveau du secteur )
-- CASCADE => L'action est répercuté sur les relations. (ex : Jean Pierre travaille dans le secteur 5. Si je supprime le secteur 5, Jean Pierre sera supprimé de ma BDD.)

-- ########## REQUETE DE JOINTURE ##########

-- JOINTURE INTERNE 
-- Afficher les employes et leur secteur
SELECT nom, prenom, ville
FROM employes e, secteur s
WHERE e.id_secteur = s.id_secteur ;

-- JOINTURE EXTERNE
-- LEFT JOIN
-- Afficher tous les employes liés à un secteur + les employes qui n'ont pas de secteur
SELECT nom, prenom, ville
FROM employes e LEFT JOIN secteur s 
ON e.id_secteur = s.id_secteur ;

-- RIGHT JOIN
-- Afficher tous les secteur lié à un employé + les secteur qui n'on pas d'employés
SELECT nom, prenom, ville
FROM employes e RIGHT JOIN secteur s 
ON e.id_secteur = s.id_secteur ;

-- INNER JOIN
-- Même fonctionnement qu'une jointure Interne. On récupperera uniquement les correspondances entre les 2 tables.
SELECT nom, prenom, ville
FROM employes e INNER JOIN secteur s 
ON e.id_secteur = s.id_secteur ;

-- NATURAL JOIN
-- Même chose q'un join interne. La différence est que le Natural Join trouvera lui même la colonne de relation.
-- Ici par exemple il trouvera automatiquement les colonnes 'e.id_secteur' et 's.id_secteur'
SELECT nom, prenom, ville
FROM employes e NATURAL JOIN secteur s ;
