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

| Attribut  | Description                         | Type | Contraintes                          |
| --------- | ----------------------------------- | ---- | ------------------------------------ |
| UUID_user | Identifiant unique de l'utilisateur | UUID | Clé primaire                         |
| Pseudo    | pseudo de l'utilisateur             | text | Obligatoire                          |
| Role      | role de l'utilisateur               | text | Valeurs : MJ, Détective, Observateur |

## Table : Objet

| Nom               | Description                                   | Type    | Contraintes             |
| ----------------- | --------------------------------------------- | ------- | ----------------------- |
| id_objet          | Identifiant unique de l'objet                 | numeric | Clé primaire            |
| nom_objet         | Nom de l'objet                                | text    | Obligatoire             |
| description_objet | description de l'objet                        | text    | Clé étrangère (SalleID) |
| image_objet       | Image de l'objet                              | INT     | Clé étrangère (SalleID) |
| heure_arrivé      | Date d'arrivée d'un personnage dans une salle | heure   | Clé étrangère (SalleID) |
| heure_sortie      | Date de sortie d'un personne d'une salle      | heure   | Clé étrangère (SalleID) |

## Table : Personnage

| Attribut          | Description                      | Type    | Contraintes                                  |
| ----------------- | -------------------------------- | ------- | -------------------------------------------- |
| id_perso          | Identifiant unique du personnage | numeric | Clé primaire                                 |
| nom_perso         | Nom du personnage                | text    | Obligatoire                                  |
| couleur_perso     |                                  | INT     | Clé étrangère, peut être NULL si non incarné |
| image_perso       | Identifiant de la partie         | INT     | Clé étrangère (PartieID)                     |
| description perso | Identifiant de la partie         | INT     | Clé étrangère (PartieID)                     |

## Table : Salle

| Attribut      | Description                            | Type        | Contraintes              |
| ------------- | -------------------------------------- | ----------- | ------------------------ |
| SalleID       | Identifiant unique de la salle         | INT         | Clé primaire             |
| Nom           | Nom de la salle                        | VARCHAR(50) | Obligatoire              |
| PartieID      | Identifiant de la partie associée      | INT         | Clé étrangère (PartieID) |
| EstModifiable | Indique si la salle peut être modifiée | BOOLEAN     | Valeur par défaut : TRUE |

![border](../assets/line/line-pink-point_r.png)

<a href="#sommaire">
  <img src="../assets/button/back_to_top.png" alt="Back to top" style="width: 150px; height: auto;">
</a>

![border](../assets/line/border_deco_l.png)
