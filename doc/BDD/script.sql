-- ==================================================================
-- =============== SIMPLUENO LE PLUS CHEAP DES CLUEDO ===============
-- ********************* Script d'initialisation ********************
-- ==================================================================


-- ==================================================================
--                       Mise en place 
-- ==================================================================


-- Connexion a la BDD postgres
\c postgres
-- Remplace en supprimant la BDD simplueno si elle existe 
DROP DATABASE IF EXISTS simpluedo;
-- Remplace en supprimant la BDD simplueno si elle existe 
CREATE DATABASE simpluedo;
-- Creation de l'administrateur 
CREATE USER simpluedo_admin;
-- Ajout d'un mot de passe à l'administrateur 
ALTER USER simpluedo_admin WITH PASSWORD 'admin';

-- ==================================================================
--        Switch sur la BDD simpluedo avec le simpluedo_admin
-- ==================================================================

\c simpluedo
-- Creation de la table utilisateurs
CREATE TABLE utilisateurs(
uuid_utilisateurs UUID PRIMARY KEY DEFAULT gen_random_uuid(),
pseudo_utilisateurs VARCHAR(50) NOT NULL);
-- Creation de la table rôles

CREATE TABLE roles(
id_roles INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
nom_roles VARCHAR(50) NOT NULL);
-- Creation de la table salles

CREATE TABLE salles(
id_salles INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
nom_salles VARCHAR(50) NOT NULL);
-- Creation de la table salles

CREATE TABLE salles(
id_salles INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
nom_salles VARCHAR(50) NOT NULL);
-- Creation de la table personnages

CREATE TABLE personnages(
id_personnages INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
nom_personnages VARCHAR(50) NOT NULL);

-- Creation de la table objets
CREATE TABLE objets(
id_objets INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
nom_objets VARCHAR(50) NOT NULL);

-- Creation de la table visiter

CREATE TABLE visiter(
id_personnages INTEGER,
id_salles INTEGER,
heure_arrivee TIME,
heure_sortie TIME,
PRIMARY KEY(id_personnages, id_salles, heure_arrivee),
FOREIGN KEY(id_personnages) REFERENCES personnages(id_personnages),
FOREIGN KEY(id_salles) REFERENCES salles(id_salles));

-- Creation de la table visiter

CREATE TABLE position(
id_personnages INTEGER NOT NULL,
id_salles INTEGER NOT NULL,
heure_arrivee TIME NOT NULL,
PRIMARY KEY(id_personnages),
FOREIGN KEY(id_personnages) REFERENCES personnages(id_personnages),
FOREIGN KEY(id_salles) REFERENCES salles(id_salles));

-- ==================================================================
--        Utilisation d'alters pour modifier les tables existantes 
-- ==================================================================
--      Afin de : 
--        Faciliter la gestion des relations complexes.
--        Éviter les dépendances circulaires.
--        Réduire les erreurs liées à l'ordre de création des tables.
--        Améliorer la lisibilité et la modularité des scripts SQL.
-- ==================================================================

-- Ajout de la clé étrangère id_roles dans la table utilisateurs

ALTER TABLE utilisateurs
ADD COLUMN id_roles INTEGER,
ADD CONSTRAINT fk_utilisateurs_id_roles
FOREIGN KEY (id_roles) REFERENCES roles(id_roles);

-- Ajout de la clé étrangère 'id_personnage' dans la table 'utilisateur'
ALTER TABLE utilisateurs
ADD COLUMN id_personnages INTEGER,
ADD CONSTRAINT fk_utilisateur_id_personnages
FOREIGN KEY (id_personnages) REFERENCES personnages(id_personnages);

-- Ajout de la clé étrangère 'id_salle' dans la table 'objet'
ALTER TABLE objets
ADD COLUMN id_salles INTEGER,
ADD CONSTRAINT fk_objets_id_salles
FOREIGN KEY (id_salles) REFERENCES salles(id_salles);*

-- ==================================================================
-- Ajout des permissions pour l'administrateur simpluedo_admin
-- ==================================================================
-- simpluedo_admin est limité à ces actions uniquement sur les données. Il ne peut pas :

-- Modifier la structure des tables (ajouter/supprimer des colonnes, contraintes, etc.).
-- Créer de nouvelles tables ou d'autres objets comme des vues ou des séquences.
-- Modifier les schémas ou leurs propriétés.
-- Accéder automatiquement à de nouveaux objets (tables) créés après le GRANT.
-- ==================================================================

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO simpluedo_admin;

-- ==================================================================
-- 19. Procédure pour ajouter un objet dans la table 'objets'
-- CALL ajout_objet('Clé dorée', 'Salle 1');
-- ==================================================================
CREATE OR REPLACE PROCEDURE ajout_objet(var_nom_objets VARCHAR, var_nom_salles VARCHAR)
 LANGUAGE plpgsql
 AS $$
 BEGIN
     -- Insérer directement l'objet en liant la salle par son nom
     INSERT INTO objets (nom_objets, id_salles)
     SELECT var_nom_objets, salles.id_salles
     FROM salles
     WHERE salles.nom_salles = var_nom_salles;
 
     -- Vérification si aucune salle ne correspond
     IF NOT FOUND THEN
         RAISE EXCEPTION 'La salle "%" n''existe pas.', var_nom_salles;
     END IF;
 END;
 $$;
-- ==================================================================
-- Procédure pour lister tous les objets situés dans une salle

-- CALL afficher_objets_dans_salle('Salle 1');
-- ==================================================================

CREATE OR REPLACE PROCEDURE afficher_objets_dans_salle(nom_salle VARCHAR)
LANGUAGE plpgsql
AS $$
DECLARE
    obj RECORD; -- Variable pour stocker chaque ligne
BEGIN
    RAISE NOTICE 'Objets dans la salle "%":', nom_salle;

    -- Boucle sur chaque ligne retournée par la fonction
    FOR obj IN SELECT * FROM lister_objet(nom_salle)
    LOOP
        RAISE NOTICE '  - %', obj.nom_objets;
    END LOOP;
END;
$$;





















-- ==================================================================
-- Trigger pour gérer les déplacements des personnages
-- ==================================================================

-- Fonction de trigger
-- ==================================================================
CREATE OR REPLACE FUNCTION trigger_update_position()
RETURNS TRIGGER AS $$
BEGIN
    -- Complète l'heure de sortie dans visiter
    UPDATE visiter
    SET heure_sortie = NEW.heure_arrivee
    WHERE id_personnages = NEW.id_personnages
      AND heure_sortie IS NULL;

    -- Mets à jour ou insère dans position
    INSERT INTO position (id_personnages, id_salles, heure_arrivee)
    VALUES (NEW.id_personnages, NEW.id_salles, NEW.heure_arrivee)
    ON CONFLICT (id_personnages)
    DO UPDATE SET id_salles = EXCLUDED.id_salles, heure_arrivee = EXCLUDED.heure_arrivee;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Création du trigger
-- ==================================================================
CREATE TRIGGER trigger_update_position
AFTER INSERT ON visiter
FOR EACH ROW
EXECUTE FUNCTION trigger_update_position();

-- ==================================================================
-- Tests 
-- ==================================================================

But : Vérifiez que l'insertion dans visiter déclenche bien le trigger et que :

L'heure de sortie est mise à jour pour la visite précédente.
La position actuelle est mise à jour dans la table position.




