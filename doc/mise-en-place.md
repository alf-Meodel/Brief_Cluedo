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
