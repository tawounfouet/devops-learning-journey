## Gestion du stockage

- Ecrivez un fichier de déploiement pour un pod qui utilise un volume persistant pour stocker des données.
Ecrivez un manifest mysql-volume.yml qui déploie un pod mysql(nommé mysql-volume), avec les paramètres d'environnment suivants :
    - nom de la base de données : eazytraining
    - login : eazy
    - mdp: eazy
    - mdp compte root : password

- Le pod doit utiliser un volume persistant pour stocker les données de la base de données.
Faites en sorte que le dossier contenant la base de données soit peristant en le montant sur votre noeud dans /data-volume en utilisant le principe de volumes hostPath.

- Créez un pod mysql-volume à partir de ce fichier de déploiement.
Lancez la création de votre pod, vérifiez que votre pod a bien démarré et que ce dernier consomme effectivement de l'espace disque sur votre noeud (le dossier local /data-volume ).


- Ecrivez 
  - **pv.yml** : volume persistant de taille 1 Go utilisant le dossier local/data-pv pour stocker les données et 
  - **pvc.yml**: volume persistant claim de taille 100Mo utilisant le PV crée précédement pour stocker les données 

- Lancez la création de vos PV et PVC, vérifiez qu'ils sont bien créees et pret à etre consommés.


- Ecrivez un manifest mysql-pvc.yml qui déploie un pod mysql(nommé mysql-pvc) comme précédement à la seule différene qu'il utilisera comme volume de stockage le PVC crée précédement pour stocker les données de la base de données.

- Vérifiez que votre pod a bien démarré et que ce dernier consomme effectivement de l'espace disque sur votre noeud (le dossier local /data-pv ).

- Créez un repertoire tp4 dans votre répertoire de travail et déposez y les fichiers de déploiement de vos pods mysql-volume.yml et mysql-pvc.yml ainsi que les fichiers de déploiement de vos PV et PVC pv.yml et pvc.yml.

- Enfin, poussez votre répertoire de travail sur votre repository github.
