## Dockerizer une  application Django

1. Créer un fichier `Dockerfile` à la racine du projet
```bash
touch Dockerfile
```

2. Ajouter le contenu suivant dans le fichier `Dockerfile`
```dockerfile
FROM python:3.8.5-alpine

ENV PYTHONUNBUFFERED 1

RUN mkdir /app
WORKDIR /app

COPY requirements.txt /app/
COPY devops /app/


RUN pip install -r requirements.txt

COPY . /app/
```

3. Créer un fichier `requirements.txt` à la racine du projet
```bash
touch requirements.txt
```

4. Ajouter le contenu suivant dans le fichier `requirements.txt`
```txt
Django==3.1.2
```

5. Créer un fichier `.dockerignore` à la racine du projet
```bash
touch .dockerignore
```

6. Ajouter le contenu suivant dans le fichier `.dockerignore`
```txt
.git
__pycache__
*.pyc
```

7. Construire l'image Docker
```bash
docker build -t django-web-app .
```

8. Lancer le conteneur Docker
```bash
docker run -it --rm -p 8000:8000 django-web-app
```or
```bash
docker run -it _IMAGE_ID_ -p 8000:8000 
docker run -it 7f2f42a45c56 -p 8000:8000 
```

9. Ouvrir un navigateur et accéder à l'application
```bash
http://localhost:8000
```

