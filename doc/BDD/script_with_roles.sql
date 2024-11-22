-- Script SQL pour la création de la base de données PostgreSQL
-- Auteur : Justin DIDELOT
-- Date : 21/11/2024

-- ==================================================================
-- 1. Vérification si la base de données existe ou non
-- ==================================================================
DROP DATABASE IF EXISTS simpluedo;

-- ==================================================================
-- 2. Création de la base de données
-- ==================================================================
CREATE DATABASE simpluedo;

-- ==================================================================
-- 3. Création de l'administrateur
-- ==================================================================
CREATE USER simpluedo_administrateur;
ALTER USER simpluedo_administrateur WITH PASSWORD 'admin';

-- ==================================================================
-- 4. Création de la table 'utilisateurs'
-- ==================================================================
CREATE TABLE utilisateurs (
    uuid_utilisateurs UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    pseudo_utilisateurs VARCHAR(50) NOT NULL,
    id_roles INTEGER NOT NULL,
    id_personnages INTEGER,
    FOREIGN KEY (id_roles) REFERENCES roles(id_roles),
    FOREIGN KEY (id_personnages) REFERENCES personnages(id_personnages)
);

-- ==================================================================
-- 5. Création de la table 'roles'
-- ==================================================================
CREATE TABLE roles (
    id_roles INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    nom_roles VARCHAR(50) NOT NULL UNIQUE
);

-- Peuplement des rôles
INSERT INTO roles (nom_roles) VALUES 
    ('Maître du jeu'),
    ('Utilisateur'),
    ('Observateur');

-- ==================================================================
-- 6. Création de la table 'salles'
-- ==================================================================
CREATE TABLE salles (
    id_salles INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    nom_salles VARCHAR(50) NOT NULL
);

-- ==================================================================
-- 7. Création de la table 'personnages'
-- ==================================================================
CREATE TABLE personnages (
    id_personnages INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    nom_personnages VARCHAR(50) NOT NULL
);

-- ==================================================================
-- 8. Création de la table 'objets'
-- ==================================================================
CREATE TABLE objets (
    id_objets INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    nom_objets VARCHAR(50) NOT NULL,
    id_salles INTEGER,
    FOREIGN KEY (id_salles) REFERENCES salles(id_salles)
);

-- ==================================================================
-- 9. Création de la table 'visiter'
-- ==================================================================
CREATE TABLE visiter (
    id_personnages INTEGER,
    id_salles INTEGER,
    heure_arrivee TIME,
    heure_sortie TIME,
    PRIMARY KEY (id_personnages, id_salles, heure_arrivee),
    FOREIGN KEY (id_personnages) REFERENCES personnages(id_personnages),
    FOREIGN KEY (id_salles) REFERENCES salles(id_salles)
);

-- ==================================================================
-- Contraintes spécifiques
-- ==================================================================

-- 1. Un seul maître du jeu par partie
ALTER TABLE utilisateurs
ADD CONSTRAINT unique_maitre_du_jeu 
CHECK (id_roles != 1 OR (SELECT COUNT(*) FROM utilisateurs WHERE id_roles = 1) <= 1);

-- 2. Un utilisateur doit avoir un personnage
ALTER TABLE utilisateurs
ADD CONSTRAINT utilisateur_a_personnage 
CHECK (id_roles != 3 OR id_personnages IS NULL);

-- ==================================================================
-- Permissions pour l'administrateur
-- ==================================================================
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO simpluedo_administrateur;
