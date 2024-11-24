-- ==================================================================
-- =============== SIMPLUENO LE PLUS CHEAP DES CLUEDO ===============
-- ********************* Script d'initialisation ********************
-- ==================================================================


-- ==================================================================
--                       Mise en place 
-- ==================================================================


-- Connexion a la BDD 'simpluedo' avec postgres
\c simpluedo
-- Remplace en supprimant la BDD simplueno si elle existe 
DROP DATABASE IF EXISTS simpluedo;
-- Remplace en supprimant la BDD simplueno si elle existe 
CREATE DATABASE simpluedo;
-- Creation de l'administrateur 
CREATE USER simpluedo_admin;
-- Ajout d'un mot de passe à l'administrateur 
ALTER USER simpluedo_admin WITH PASSWORD 'admin';

-- ==================================================================
--     Passer de la session postgres à celle du simpluedo_admin 
-- ==================================================================
\c simpluedo
