 <a href="../README.md">
  <img src="../assets/button/home_page.png" alt="Home page" style="width: 150px; height: auto;">
</a>

![border](../assets/line/border_deco_rt.png)

# MISE EN PLACE

![border](../assets/line/line-pink-point_l.png)

## Sommaire

- [Export](#export-des-tables)

![border](../assets/line/border_deco_rb.png)

# Export des Tables

Une fois que la place à été correctement créé ; nous allons l'exporter en utilisant la commande suivante

```
pg_dump -U meodel -d simpluedo -F p -f simpluedo_export.sql
```

# Mise en place des procédures stoquées et des triggers

-- Crée une nouvelle fonction ou remplace une fonction existante appelée `lister_objets_dans_piece`

```
CREATE OR REPLACE FUNCTION lister_objets_dans_piece(id_salle_param INTEGER)
```

-- Spécifie que la fonction retourne un tableau contenant une seule colonne `nom_objet` de type VARCHAR

```
RETURNS TABLE (nom_objet VARCHAR) AS $$


BEGIN
```

Démarre le corps de la fonction

Retourne les résultats d'une requête SQL qui liste les objets associés à une salle donnée

```
    RETURN QUERY
    SELECT nom_objet
    FROM objets
    WHERE id_salles = id_salle_param;
```

Filtre pour ne retourner que les objets de la salle spécifiée par `id_salle_param`

```
END;
```

Indique la fin de la fonction

```
$$
LANGUAGE plpgsql;
```

Spécifie que la fonction est écrite en PL/pgSQL, le langage procédural de PostgreSQL

#### Résumé simplifié :

- La fonction **lister_objets_dans_piece** accepte un identifiant de salle comme entrée.
- Elle exécute une requête SQL pour lister tous les objets de la table objets associés à cette salle.
- Elle retourne les noms des objets sous forme d'une table.

#### Explications :

- pg_dump : L'outil pour exporter une base de données PostgreSQL.
- -U meodel : Spécifie l'utilisateur PostgreSQL.
- -d simpluedo : Spécifie la base de données à exporter.
- -F p : Spécifie le format de sortie (p pour SQL classique).
- -f simpluedo_export.sql : Nom du fichier SQL qui contiendra l'export.

![border](../assets/line/line-pink-point_r.png)

<a href="#sommaire">
  <img src="../assets/button/back_to_top.png" alt="Back to top" style="width: 150px; height: auto;">
</a>

![border](../assets/line/border_deco_l.png)
