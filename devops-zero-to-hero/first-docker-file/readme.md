## Création d'un dockerfile Hello World
1. Créer un fichier nommé Dockerfile
2. Ecrire les commandes suivantes dans le fichier:
```dockerfile
FROM alpine:3.14

CMD ["echo", "Hello World!"]
```
3. Créer/construire notre image à partir du dockerfile créé grace à la commande suivante:
```bash
docker build -t mon-image-hello-world .
```
4. Lancer un conteneur à partir de l'image créée
```bash
docker run mon-image-hello-world
```

5. arrêter le conteneur grace à son ID
```bash
docker ps -a
docker stop <ID>
```
ou
```bash
docker stop $(docker ps -a -q)
```

6. Supprimer l'image créée
```bash
docker rmi mon-image-hello-world
```


## Création d'un dockerfile nginx hello world
1. Créer un fichier nommé :
```bash
touch dockerfile-nginx
```
2. Créer un fichier nommé index.html
```bash
touch index.html
```

3. Ecrire les commandes suivantes dans le fichier:
```dockerfile
FROM nginx:1.21.1-alpine
COPY index.html /usr/share/nginx/html

```


4. Ecrire les commandes suivantes dans le fichier index.html:
```html
<!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
</head>
<body>
<h1>Hello World</h1>
<p>I'm hosted with GitHub Pages.</p>
</body>
</html>
```
5. Créer/construire notre image à partir du dockerfile créé grace à la commande suivante:
```bash
docker build -t mon-image-nginx-hello-world .
```
6. Lancer un conteneur à partir de l'image créée
```bash
docker run -d -p 8080:80 mon-image-nginx-hello-world
```
7. arrêter le conteneur grace à son ID
```bash
docker ps -a
docker stop <ID>
```
ou
```bash
docker stop $(docker ps -a -q)
```



## Création d'un dockerfile PremierDockerfile cours OpenClassrooms
1. Créer un fichier nommé ocr-dockerfile
```bash
touch ocr-docker-build
```
2. Ecrire les commandes suivantes dans le fichier:
```dockerfile
FROM debian:9

RUN apt-get update -yq \
&& apt-get install curl gnupg -yq \
&& curl -sL https://deb.nodesource.com/setup_10.x | bash \
&& apt-get install nodejs -yq \
&& apt-get clean -y

ADD . /app/
WORKDIR /app
RUN npm install

EXPOSE 2368
VOLUME /app/logs

CMD npm run start
```
3. Créer un fichier nommé index.html
```bash
touch index.html
```
4. Ecrire les commandes suivantes dans le fichier index.html:
```html
<!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
</head>
<body>
<h1>Hello World</h1>
<p>I'm hosted with GitHub Pages.</p>
</body>
</html>
```
5. Créer/construire notre image à partir du dockerfile créé grace à la commande suivante:
```bash
docker build -t mon-image-ocr-dockerfile .
```
6. Lancer un conteneur à partir de l'image créée
```bash
docker run -d -p 8080:2368 mon-image-ocr-dockerfile
```
7. arrêter le conteneur grace à son ID
```bash
docker ps -a
docker stop <ID>
```
8. Supprimer l'image créée
```bash
docker rmi mon-image-ocr-dockerfile
```







## Créer mon premier dockerfile
### Créer un fichier nommé Dockerfile
### Ecrire les commandes suivantes dans le fichier:
```dockerfile
FROM node:12.18.1
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD [ "node", "server.js" ]
```

### Créer un fichier nommé server.js
### Ecrire les commandes suivantes dans le fichier:
```dockerfile
const express = require('express');
const app = express();
app.get('/', (req, res) => {
res.send('Hello World');
});
app.listen(3000, () => {
console.log('Server is up on 3000');
});
```
### Créer un fichier nommé package.json
### Ecrire les commandes suivantes dans le fichier:
```dockerfile
{
"name": "docker_web_app",
"version": "1.0.0",
"description": "Node.js on Docker",
"author": "First Last <Thomas AWOUNFOUET>",
"main": "server.js",
"scripts": {
"start": "node server.js"
},
"dependencies": {
"express": "^4.17.1"
}
}
```
### Créer un fichier nommé .dockerignore
### Ecrire les commandes suivantes dans le fichier:
```dockerfile
node_modules
npm-debug.log
```



### Arreter tous les coneneurs

```bash
docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker rmi $(docker images -q)
```