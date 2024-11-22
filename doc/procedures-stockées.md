 <a href="../README.md">
  <img src="../assets/button/home_page.png" alt="Home page" style="width: 150px; height: auto;">
</a>

![border](../assets/line/border_deco_rt.png)

# Les Procédures Stockées

![border](../assets/line/line-pink-point_l.png)

## Sommaire

- [Export](#export-des-tables)

![border](../assets/line/border_deco_rb.png)

# Export des Tables

Une fois que la place à été correctement créé ; nous allons l'exporter en utilisant la commande suivante

```
pg_dump -U meodel -d simpluedo -F p -f simpluedo_export.sql
```

# Mise en place des procédures stoquées

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

### **1. Voir la liste des fonctions dans votre base de données**

Vous pouvez utiliser la commande SQL suivante pour afficher toutes les fonctions définies dans votre base de données :

```sql
SELECT proname AS fonction, proargtypes AS arguments, prorettype AS retour
FROM pg_proc
WHERE pronamespace = (SELECT oid FROM pg_namespace WHERE nspname = 'public');
```

Cela retourne toutes les fonctions définies dans le schéma `public` (le schéma par défaut dans PostgreSQL).

---

### **2. Voir le code SQL de la fonction**

Pour récupérer le code source de votre fonction, utilisez cette commande SQL :

```sql
SELECT pg_get_functiondef(oid)
FROM pg_proc
WHERE proname = 'lister_objets_dans_piece';
```

Cela retourne le code SQL complet de votre fonction **`lister_objets_dans_piece`**.

---

### **3. Tester la fonction**

Une fois la fonction localisée, vous pouvez l'utiliser directement dans une requête SQL pour vérifier son fonctionnement.

#### Exemple d'utilisation :

Si vous voulez lister tous les objets de la salle avec `id_salles = 1`, utilisez :

```sql
SELECT * FROM lister_objets_dans_piece(1);
```

Cela exécutera votre fonction et retournera la liste des noms d'objets associés à la salle avec `id_salles = 1`.

---

### **4. Supprimer ou modifier la fonction**

Si vous voulez supprimer ou modifier la fonction, voici comment faire :

#### Supprimer la fonction :

```sql
DROP FUNCTION lister_objets_dans_piece(INTEGER);
```

- **Note** : Le type de paramètre `(INTEGER)` est requis pour identifier la fonction.

#### Modifier la fonction :

Pour modifier la fonction, recréez-la simplement avec **`CREATE OR REPLACE FUNCTION`**, comme vous l'avez déjà fait.

---

### **5. Vérifier la liste des objets dans `pgcli`**

Dans **pgcli**, vous pouvez voir toutes les fonctions définies en listant les objets du schéma avec la commande :

```sql
\df
```

Cela affichera une liste de toutes les fonctions, leurs arguments et leur type de retour.

---

### **Résumé**

1. Utilisez `\df` dans **pgcli** pour afficher les fonctions rapidement.
2. Pour voir le code source, utilisez :
   ```sql
   SELECT pg_get_functiondef(oid) FROM pg_proc WHERE proname = 'lister_objets_dans_piece';
   ```
3. Testez votre fonction avec une commande SQL comme :
   ```sql
   SELECT * FROM lister_objets_dans_piece(1);
   ```

![border](../assets/line/line-pink-point_r.png)

<a href="#sommaire">
  <img src="../assets/button/back_to_top.png" alt="Back to top" style="width: 150px; height: auto;">
</a>

![border](../assets/line/border_deco_l.png)
