 <a href="../README.md">
  <img src="../assets/button/home_page.png" alt="Home page" style="width: 150px; height: auto;">
</a>

![border](../assets/line/border_deco_rt.png)

# Les Triggers

![border](../assets/line/line-pink-point_l.png)

## Sommaire

- [Tables des triggers possibles](#tables-des-triggers-possibles)
- [Trigger pour détecter des incohérences](#trigger-pour-détecter-des-incohérences)
- [Trigger pour enregistrer l’heure de sortie
  ](#trigger-pour-enregistrer-lheure-de-sortie)
- [Trigger pour détecter des incohérences](#trigger-pour-mettre-à-jour-la-position-en-temps-réel)

![border](../assets/line/border_deco_rb.png)

# Tables des triggers possibles

### Ojectif

- nous allons créer des triggers qui permettent de suivre la position d'un personnage dans les pièces et de déterminer quand il entre dans une pièce. Cela peut se baser sur la table visiter, en supposant que nous capturons des événements liés à l'entrée dans une pièce.

### Créer un mécanisme basé sur des triggers pour :

- Suivre les positions des personnages en temps réel.
- Enregistrer l’heure exacte de l’entrée dans une pièce.
- Empêcher ou signaler des incohérences, comme un personnage qui entrerait dans plusieurs pièces simultanément.

### Proposition de Triggers

- Dans un premier temps nous allons créer une table position pour suivre la dernière position d'un personnage

```
CREATE TABLE positions (
    id_personnages INTEGER PRIMARY KEY,
    id_salles INTEGER,
    heure_entree TIME
);
```

- id_personnages : Identifiant du personnage.
- id_salles : Salle actuelle du personnage.
- heure_entree : Heure d’entrée dans la salle.

### Trigger pour mettre à jour la position en temps réel

Ce trigger met à jour la table positions lorsqu’un personnage entre dans une nouvelle pièce.

```
CREATE OR REPLACE FUNCTION update_position_on_entry()
RETURNS TRIGGER AS $$
BEGIN
    -- Supprimer l'ancienne position si elle existe
    DELETE FROM positions WHERE id_personnages = NEW.id_personnages;

    -- Insérer la nouvelle position
    INSERT INTO positions (id_personnages, id_salles, heure_entree)
    VALUES (NEW.id_personnages, NEW.id_salles, NEW.heure_arrivee);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_position_on_entry
AFTER INSERT ON visiter
FOR EACH ROW
EXECUTE FUNCTION update_position_on_entry();
```

### Trigger pour détecter des incohérences

Empêcher qu’un personnage entre dans une salle alors qu’il est déjà dans une autre pièce.

```
CREATE OR REPLACE FUNCTION prevent_multiple_entries()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier si le personnage est déjà dans une pièce
    IF (SELECT COUNT(*) FROM positions WHERE id_personnages = NEW.id_personnages) > 0 THEN
        RAISE EXCEPTION 'Le personnage % est déjà dans une autre pièce.', NEW.id_personnages;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_multiple_entries
BEFORE INSERT ON visiter
FOR EACH ROW
EXECUTE FUNCTION prevent_multiple_entries();

```

### Trigger pour enregistrer l’heure de sortie

Quand un personnage sort d’une pièce (via heure_sortie), mettez à jour la table positions pour supprimer sa position.

```
CREATE OR REPLACE FUNCTION record_exit_time()
RETURNS TRIGGER AS $$
BEGIN
    -- Supprimer l'entrée dans la table positions lorsque le personnage sort
    DELETE FROM positions WHERE id_personnages = OLD.id_personnages;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_record_exit_time
AFTER UPDATE OF heure_sortie ON visiter
FOR EACH ROW
EXECUTE FUNCTION record_exit_time();
```

# Résumé des Triggers

| **Trigger**                    | **Table concernée** | **Description**                                                                      |
| ------------------------------ | ------------------- | ------------------------------------------------------------------------------------ |
| `trg_update_position_on_entry` | `visiter`           | Met à jour la position actuelle d’un personnage lorsqu’il entre dans une pièce.      |
| `trg_prevent_multiple_entries` | `visiter`           | Empêche un personnage d’entrer dans une nouvelle pièce s’il est déjà dans une autre. |
| `trg_record_exit_time`         | `visiter`           | Supprime la position actuelle d’un personnage lorsqu’il sort d’une pièce.            |

## Exemple de Fonctionnement

#### Insertion d’une visite :

```
INSERT INTO visiter (id_personnages, id_salles, heure_arrivee)
VALUES (1, 2, '10:00');
```

La table positions est mise à jour pour indiquer que le personnage 1 est dans la salle 2 depuis 10:00.

#### Insertion dans une autre salle (invalide) :

```
INSERT INTO visiter (id_personnages, id_salles, heure_arrivee)
VALUES (1, 3, '10:05');
```

Cela lève une exception car le personnage 1 est déjà enregistré dans une autre pièce.

#### Mise à jour avec une heure de sortie :

```
UPDATE visiter
SET heure_sortie = '10:30'
WHERE id_personnages = 1 AND id_salles = 2;
```

Le personnage 1 est retiré de la table positions.

![border](../assets/line/line-pink-point_r.png)

<a href="#sommaire">
  <img src="../assets/button/back_to_top.png" alt="Back to top" style="width: 150px; height: auto;">
</a>

![border](../assets/line/border_deco_l.png)
