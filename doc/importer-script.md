 <a href="../README.md">
  <img src="../assets/button/home_page.png" alt="Home page" style="width: 150px; height: auto;">
</a>

![border](../assets/line/border_deco_rt.png)

# Importer une BDD

```
pour garantir que la bdd ne se duplique pas on ajoute une commande pour supprimer la BDD précédente
DROP DATABASE IF EXISTS simpluedo;
```

![border](../assets/line/line-pink-point_l.png)

### Sommaire

![border](../assets/line/border_deco_rb.png)

## Importer un .sql

- Dans un premier temps nous allons lancer pgcli en tant qu'utilisateur postgres :

```
pgcli -U postgres
```

- Ensuite nous allons importer notre .sql

```
\i /home/meodel/Bureau/Cluedo_WS/script.sql
```

![border](../assets/line/line-pink-point_r.png)

<a href="#sommaire">
  <img src="../assets/button/back_to_top.png" alt="Back to top" style="width: 150px; height: auto;">
</a>

![border](../assets/line/border_deco_l.png)
