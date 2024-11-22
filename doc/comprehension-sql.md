 <a href="../README.md">
  <img src="../assets/button/home_page.png" alt="Home page" style="width: 150px; height: auto;">
</a>

![border](../assets/line/border_deco_rt.png)

# BDD subtilités

```
pour garantir que la bdd ne se duplique pas on ajoute une commande pour supprimer la BDD précédente
DROP DATABASE IF EXISTS simpluedo;
```

![border](../assets/line/line-pink-point_l.png)

### Sommaire

- [Association multi PRIMARY KEY](#association-multi-primary-key)
- [Chaque combinaison ](#chaque-combinaison-de-ces-trois-colonnes-doit-être-unique)
- [Droits du Simpluedo_admin](#droits-du-simpluedo_admin)
- [Benchmark des droits de simpluedo_admin](#benchmark-des-droits-de-simpluedo_admin)

![border](../assets/line/border_deco_rb.png)

## Importer un .sql

- Dans un premier temps nous allons lancer pgcli en tant qu'utilisateur postgres :

```
pgcli -U postgres
```

- Ensuite nous allons importer notre .sql ( présent dans BDD_exemple)

```
\i /home/meodel/Bureau/Cluedo_WS/script_with_roles.sql
```

## ASSOCIATION MULTI PRIMARY KEY

### Introduction

Dans ce contexte, la clé primaire composée est utilisée pour garantir qu'un même personnage
ne puisse pas avoir deux enregistrements identiques pour une salle à la même heure.
Cela correspond à la réalité métier du jeu Cluedo, où un personnage peut visiter une pièce plusieurs fois,
mais chaque visite doit être différenciée par l'heure.

![alt](/assets/img/visiter.png)

```
CREATE TABLE visiter(
id_personnages INTEGER,
id_salles INTEGER,
heure_arrivee TIME,
heure_sortie TIME,
PRIMARY KEY(id_personnages, id_salles, heure_arrivee),
FOREIGN KEY(id_personnages) REFERENCES personnages(id_personnages),
FOREIGN KEY(id_salles) REFERENCES salles(id_salles));
```

### Rappel sur les clés primaires

Une clé primaire **(Primary Key)** garantit l'unicité de chaque enregistrement dans une table.
Dans la table visiter, la clé primaire est composée de **id_personnages, id_salles, et heure_arrivee,**
ce qui signifie que

## Chaque combinaison de ces trois colonnes doit être unique.

---

### Pourquoi inclure plusieurs colonnes dans la clé primaire ?

Dans votre cas, la table visiter enregistre les visites d'un personnage dans une salle à des moments spécifiques.
Voici ce que chaque colonne signifie dans ce contexte :

- **id_personnages** : Identifie quel personnage visite.
- **id_salles** : Indique quelle salle est visitée.
- **heure_arrivee** : Représente l'heure précise à laquelle le personnage entre dans la salle.

---

### Raison d'une clé primaire composée

##### Un personnage peut visiter plusieurs salles :

- Si la clé primaire ne contenait que id_personnages,
- il ne pourrait y avoir qu'une seule entrée par personnage, ce qui est incorrect dans le contexte du jeu.
- Un personnage peut revisiter la même salle à différents moments :

- Si la clé primaire était composée de id_personnages et `id_salles seulement, le système empêcherait un personnage de visiter plusieurs fois la même salle,
- car cela violerait la contrainte d'unicité.

#### Différencier les visites basées sur l'heure d'arrivée :

- En incluant heure_arrivee dans la clé primaire, vous permettez d'enregistrer plusieurs passages d'un même personnage dans une même salle à des moments différents.

| id_personnages | id_salles | heure_arrivee | heure_sortie |
| -------------- | --------- | ------------- | ------------ |
| 1              | 2         | 08:00         | 08:15        |
| 1              | 2         | 10:00         | 10:30        |
| 2              | 3         | 09:00         | 09:45        |

#### ici :

- Le personnage 1 est entré dans **la salle 2 à 08:00** et y est **revenu à 10:00**.
- Ces deux enregistrements sont différenciés par heure_arrivee.

# Droits du Simpluedo_admin

Elle donne à l'utilisateur simpluedo_admin le droit d'accès complet sur toutes les tables du schéma public.

```
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO simpluedo_admin;
```

## Benchmark des droits de simpluedo_admin

```

| **Action**                                   | **Autorisé ?** | **Description**                                                                 |
|---------------------------------------------|----------------|---------------------------------------------------------------------------------|
| Lire les données dans les tables            | ✅ Oui         | Peut exécuter des requêtes `SELECT` pour récupérer les données des tables.     |
| Ajouter des données dans les tables         | ✅ Oui         | Peut insérer de nouvelles données avec `INSERT`.                               |
| Modifier des données dans les tables        | ✅ Oui         | Peut mettre à jour des données existantes avec `UPDATE`.                       |
| Supprimer des données dans les tables       | ✅ Oui         | Peut supprimer des enregistrements avec `DELETE`.                              |
| Créer une nouvelle table                    | ❌ Non         | Ne peut pas utiliser `CREATE TABLE`.                                           |
| Supprimer une table                         | ❌ Non         | Ne peut pas utiliser `DROP TABLE`.                                             |
| Modifier la structure d'une table           | ❌ Non         | Ne peut pas ajouter ou supprimer des colonnes avec `ALTER TABLE`.              |
| Gérer les utilisateurs ou leurs permissions | ❌ Non         | Ne peut pas créer, supprimer ou modifier les utilisateurs et leurs permissions.|
| Gérer la base de données (`CREATE`/`DROP`)  | ❌ Non         | Ne peut pas créer ou supprimer une base de données.                            |
| Accéder à d'autres schémas                  | ❌ Non         | Les droits sont limités au schéma `public`.                                    |
| Gérer les séquences (modification)          | ❌ Non         | Ne peut pas réinitialiser ou manipuler les séquences (`ALTER SEQUENCE`).       |
| Exécuter des fonctions/procédures           | ❌ Non         | Ne peut pas exécuter de fonctions ou procédures stockées.                      |
| Créer des objets (index, vues, etc.)        | ❌ Non         | Ne peut pas créer des index, des vues ou d'autres objets.                      |
```

![border](../assets/line/line-pink-point_r.png)

<a href="#sommaire">
  <img src="../assets/button/back_to_top.png" alt="Back to top" style="width: 150px; height: auto;">
</a>

![border](../assets/line/border_deco_l.png)
