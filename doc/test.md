 <a href="../README.md">
  <img src="../assets/button/home_page.png" alt="Home page" style="width: 150px; height: auto;">
</a>

![border](../assets/line/border_deco_rt.png)

# DICTIONNAIRE DE DONNÉES

![border](../assets/line/line-pink-point_l.png)

## Sommaire

- [Introduction](#introduction)

![border](../assets/line/border_deco_rb.png)

# Introduction

Voici les tableaux en Markdown pour les entités décrites dans le dictionnaire de données, tout en respectant les règles de gestion :

## Table : Utilisateur

| Attribut      | Description                                        | Type        | Contraintes                          |
| ------------- | -------------------------------------------------- | ----------- | ------------------------------------ |
| UtilisateurID | Identifiant unique de l'utilisateur                | INT         | Clé primaire                         |
| Nom           | Nom de l'utilisateur                               | VARCHAR(50) | Obligatoire                          |
| Role          | Rôle de l'utilisateur (MJ, Détective, Observateur) | ENUM        | Valeurs : MJ, Détective, Observateur |

## Table : Partie

| Attribut         | Description                     | Type        | Contraintes                   |
| ---------------- | ------------------------------- | ----------- | ----------------------------- |
| PartieID         | Identifiant unique de la partie | INT         | Clé primaire                  |
| Nom              | Nom de la partie                | VARCHAR(50) | Obligatoire                   |
| MJID             | Identifiant du maître du jeu    | INT         | Clé étrangère (UtilisateurID) |
| NombreDetectives | Nombre total de détectives      | INT         | Maximum 6                     |

## Table : Personnage

| Attribut      | Description                                          | Type        | Contraintes                                  |
| ------------- | ---------------------------------------------------- | ----------- | -------------------------------------------- |
| PersonnageID  | Identifiant unique du personnage                     | INT         | Clé primaire                                 |
| Nom           | Nom du personnage                                    | VARCHAR(50) | Obligatoire                                  |
| UtilisateurID | Identifiant de l'utilisateur incarnant ce personnage | INT         | Clé étrangère, peut être NULL si non incarné |
| PartieID      | Identifiant de la partie                             | INT         | Clé étrangère (PartieID)                     |

## Table : Salle

| Attribut      | Description                            | Type        | Contraintes              |
| ------------- | -------------------------------------- | ----------- | ------------------------ |
| SalleID       | Identifiant unique de la salle         | INT         | Clé primaire             |
| Nom           | Nom de la salle                        | VARCHAR(50) | Obligatoire              |
| PartieID      | Identifiant de la partie associée      | INT         | Clé étrangère (PartieID) |
| EstModifiable | Indique si la salle peut être modifiée | BOOLEAN     | Valeur par défaut : TRUE |

## Table : Objet

| Nom               | Description                   | Type        | Contraintes             |
| ----------------- | ----------------------------- | ----------- | ----------------------- |
| id_objet          | Identifiant unique de l'objet | INT         | Clé primaire            |
| nom_objet         | Nom de l'objet                | VARCHAR(50) | Obligatoire             |
| description_objet | Salle où se trouve l'objet    | INT         | Clé étrangère (SalleID) |

## Table : Déplacement

| Attribut      | Description                       | Type      | Contraintes                  |
| ------------- | --------------------------------- | --------- | ---------------------------- |
| DeplacementID | Identifiant unique du déplacement | INT       | Clé primaire                 |
| PersonnageID  | Identifiant du personnage         | INT       | Clé étrangère (PersonnageID) |
| SalleID       | Salle visitée                     | INT       | Clé étrangère (SalleID)      |
| HeureEntree   | Heure d’entrée dans la salle      | TIMESTAMP | Obligatoire                  |

## Table : Arme

| Attribut | Description                   | Type        | Contraintes              |
| -------- | ----------------------------- | ----------- | ------------------------ |
| ArmeID   | Identifiant unique de l'arme  | INT         | Clé primaire             |
| Nom      | Nom de l'arme                 | VARCHAR(50) | Obligatoire              |
| PartieID | Partie où l'arme est utilisée | INT         | Clé étrangère (PartieID) |

![border](../assets/line/line-pink-point_r.png)

<a href="#sommaire">
  <img src="../assets/button/back_to_top.png" alt="Back to top" style="width: 150px; height: auto;">
</a>

![border](../assets/line/border_deco_l.png)
