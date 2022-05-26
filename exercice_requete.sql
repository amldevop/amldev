-- 1 -- Afficher le service de l'employé 547.
SELECT service FROM employes WHERE id_employes = 547;
-- +------------+
-- | service    |
-- +------------+
-- | commercial |
-- +------------+

-- 2 -- Afficher la date d'embauche d'Amandine.
SELECT date_embauche FROM employes WHERE prenom = "Amandine" ;
-- +---------------+
-- | date_embauche |
-- +---------------+
-- | 2014-01-23    |
-- +---------------+

-- 3 -- Afficher le nom de famille de Guillaume
SELECT nom FROM employes WHERE prenom = "Guillaume" ;
-- +--------+
-- | nom    |
-- +--------+
-- | Miller |
-- +--------+

-- 4 -- Afficher le nombre de personne ayant un n° id_employes commençant par le chiffre 5.
SELECT COUNT(*) AS "nombre" FROM employes WHERE id_employes LIKE "5%" ;
-- +--------+
-- | nombre |
-- +--------+
-- |      3 |
-- +--------+

-- 5 -- Afficher le nombre de commerciaux avec l'alias 'nombre_commerciaux'.
SELECT COUNT(*) AS "nombre_commerciaux" FROM employes WHERE service = "commercial" ;
-- +--------------------+
-- | nombre_commerciaux |
-- +--------------------+
-- |                6 |
-- +--------------------+

-- 6 -- Afficher le salaire moyen des informaticiens (+arrondie) avec l'alias 'salaire_moyen'.
SELECT ROUND(AVG(salaire)) AS 'salaire_moyen' FROM employes WHERE service = "informatique" ;
-- +---------------+
-- | salaire_moyen |
-- +---------------+
-- |          2617 |
-- +---------------+

-- 7 -- Afficher les 5 premiers employés après avoir classer leur nom de famille par ordre alphabétique.
SELECT * FROM employes ORDER BY nom ASC LIMIT 5 ;
SELECT * FROM employes ORDER BY nom ASC LIMIT 0,5 ;
-- +-------------+---------+----------+------+--------------+---------------+---------+
-- | id_employes | prenom  | nom      | sexe | service      | date_embauche | salaire |
-- +-------------+---------+----------+------+--------------+---------------+---------+
-- |         592 | Laura   | Blanchet | f    | direction    | 2012-05-09    |    4500 |
-- |         854 | Daniel  | Chevel   | m    | informatique | 2015-09-28    |    3100 |
-- |         547 | Melanie | Collier  | f    | commercial   | 2012-01-08    |    3100 |
-- |         699 | Julien  | Cottet   | m    | secretariat  | 2013-01-05    |    1390 |
-- |         739 | Thierry | Desprez  | m    | secretariat  | 2013-07-17    |    1500 |
-- +-------------+---------+----------+------+--------------+---------------+---------+

-- 8 -- Afficher le coût des commerciaux sur 1 année.
SELECT SUM(salaire*12) AS "masse_commerciaux" FROM employes WHERE service = "commercial" ;
-- +--------------------------+
-- | cout_annuel_commerciaux  |
-- +--------------------------+
-- |                 184200 |
-- +--------------------------+

-- 9 -- Afficher le salaire moyen par service. (service + salaire moyen)
SELECT service, ROUND(AVG(salaire)) AS "salaire_moyen" FROM employes GROUP BY service ;

-- +---------------+---------------+
-- | service       | salaire moyen |
-- +---------------+---------------+
-- | assistant     |          1775 |
-- | commercial    |          2558 |
-- | communication |          2100 |
-- | comptabilite  |          2900 |
-- | direction     |          4750 |
-- | informatique  |          2617 |
-- | juridique     |          3550 |
-- | production    |          2225 |
-- | secretariat   |          1497 |
-- +---------------+---------------+

-- 10 -- Afficher le nombre de recrutement sur l'année 2010 (+alias).
SELECT COUNT(*) AS "nb_recrutement" FROM employes WHERE date_embauche LIKE "%2010%" ;
SELECT COUNT(*) AS "nb_recrutement" FROM employes WHERE date_embauche BETWEEN "2010-01-01" AND "2010-12-31" ;
SELECT COUNT(*) AS "nb_recrutement" FROM employes WHERE date_embauche >= "2010-01-01" AND date_embauche <= "2010-12-31" ;
-- +-------------------+
-- | nb de recrutement |
-- +-------------------+
-- |                 2 |
-- +-------------------+

-- 11 -- Afficher le salaire moyen appliqué lors des recrutements sur la pèriode allant de début 2012 a fin 2014
SELECT AVG(salaire) AS "salaire_moyen" FROM employes WHERE date_embauche BETWEEN "2012-01-01" AND "2014-12-31" ;
-- +---------------+
-- | salaire moyen |
-- +---------------+
-- |     2437.7778 |
-- +---------------+

-- 12 -- Afficher le nombre de service différent
SELECT COUNT( DISTINCT service) AS 'nombre de service' FROM employes ;
-- SELECT DISTINCT service AS 'nombre de service' FROM employes ;
-- +--------------------+
-- | nombre de services |
-- +--------------------+
-- |                  9 |
-- +--------------------+

-- 13 -- Afficher tous les employés (sauf ceux du service production et secrétariat)
SELECT nom, prenom FROM employes WHERE service NOT IN ('production', 'secretariat') ;
-- +----------+-------------+
-- | nom      | prenom      |
-- +----------+-------------+
-- | Laborde  | Jean-pierre |
-- | Gallet   | Clement     |
-- | Winter   | Thomas      |
-- | Grand    | Fabrice     |
-- | Collier  | Melanie     |
-- | Blanchet | Laura       |
-- | Miller   | Guillaume   |
-- | Perrin   | Celine      |
-- | Vignal   | Mathieu     |
-- | Thoyer   | Amandine    |
-- | Durand   | Damien      |
-- | Chevel   | Daniel      |
-- | Martin   | Nathalie    |
-- | Sennard  | Emilie      |
-- | Lafaye   | Stephanie   |
-- +----------+-------------+

-- 14 -- Afficher conjoitement le nombre d'homme et de femme dans l'entreprise
SELECT sexe, COUNT(*) AS 'nombre' FROM employes GROUP BY sexe ;
-- +------+--------+
-- | sexe | nombre |
-- +------+--------+
-- | m    |     11 |
-- | f    |      9 |
-- +------+--------+

-- 15 -- Afficher les commerciaux ayant été recrutés avant 2016 de sexe masculin et gagnant un salaire supèrieur a 2500€
SELECT nom, prenom FROM employes  
WHERE service = "commercial"  
AND sexe = "m" 
AND date_embauche < "2016"  
AND salaire > 2500 ;
-- +--------+--------+
-- | nom    | prenom |
-- +--------+--------+
-- | Winter | Thomas |
-- +--------+--------+


-- 16 -- Qui a été embauché en dernier
SELECT * FROM employes ORDER BY date_embauche DESC LIMIT 1; 
SELECT * FROM employes WHERE date_embauche = (
    SELECT MAX(date_embauche) FROM employes
);

-- +-------------+---------+--------+------+--------------+---------------+---------+
-- | id_employes | prenom  | nom    | sexe | service      | date_embauche | salaire |
-- +-------------+---------+--------+------+--------------+---------------+---------+
-- |         991 | quentin | vilfeu | m    | informatique | 2022-05-02    |    4300 |
-- +-------------+---------+--------+------+--------------+---------------+---------+

-- 17 -- Afficher les informations sur l'employé du service commercial gagnant le salaire le plus élevé
SELECT * FROM employes WHERE service = "commercial" ORDER BY salaire DESC LIMIT 1;
SELECT nom, prenom, MAX(salaire) FROM employes WHERE service = "commercial";
SELECT * FROM employes WHERE service = "commercial" AND salaire = (
    SELECT MAX(salaire) FROM employes WHERE service = "commercial"
);
-- +-------------+--------+--------+------+------------+---------------+---------+
-- | id_employes | prenom | nom    | sexe | service    | date_embauche | salaire |
-- +-------------+--------+--------+------+------------+---------------+---------+
-- |         415 | Thomas | Winter | m    | commercial | 2011-05-03    |    3550 |
-- +-------------+--------+--------+------+------------+---------------+---------+

-- 18 -- Afficher le prénom du comptable gagnant le meilleur salaire
SELECT prenom FROM employes WHERE service = "comptabilite" ORDER BY salaire DESC LIMIT 1;
SELECT prenom FROM employes WHERE service = "comptabilite" AND salaire = (
    SELECT MAX(salaire) FROM employe WHERE service = "comptabilite"
);
-- +---------+
-- | prenom  |
-- +---------+
-- | Fabrice |
-- +---------+

-- 19 -- Afficher le prénom de l'informaticien ayant été recruté en premier
SELECT * FROM employes WHERE service = "informatique" ORDER BY date_embauche ASC LIMIT 1; 

-- +-------------+---------+--------+------+--------------+---------------+---------+
-- | id_employes | prenom  | nom    | sexe | service      | date_embauche | salaire |
-- +-------------+---------+--------+------+--------------+---------------+---------+
-- |         701 | Mathieu | Vignal | m    | informatique | 2013-04-03    |    2500 |
-- +-------------+---------+--------+------+--------------+---------------+---------+

-- 20 -- Augmenter chaque employé de 100 €
UPDATE employes SET salaire = salaire + 100 ; 

-- 21 -- Supprimer les employés du service secrétariat
DELETE FROM employes WHERE service = "secretariat" ; 
