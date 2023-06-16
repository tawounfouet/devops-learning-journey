## Dockerizer une  application python avec volume


1. First Create image name volumedemo
$ docker build -t volumedemo .
2. Next create a volume call volume-data
$ docker volume create volume-data

3. Next run the container (in detach mode) with volume
$ docker run -d --mount source=volume-data,target=/app volumedemo
$ docker run -d --mount source=volume-data,target=/app -p 5000:5000 volumedemo
docker run -d -p 5000:5000 -v volume-data:/app volumedemo


## Dockerizer une  application Flask avec volume
### 1. Créer un fichier Dockerfile
```dockerfile
FROM python:3.7-alpine
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]
```
### 2. Créer un fichier requirements.txt
```
Flask==1.1.1
```
### 3. Créer un fichier app.py
```python
from flask import Flask
app = Flask(__name__)
@app.route('/')
def hello_world():
    return 'Hello, World!'
if __name__ == '__main__':
    app.run(debug=True, host='localhost', port=5000)
```
### 4. Créer un fichier .dockerignore
```
__pycache__
*.pyc
```
### 5. Créer un fichier docker-compose.yml
```yml
version: '3'
services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - .:/app
```
### 6. Lancer l'application
```bash
docker-compose up
```
### 7. Tester l'application
```bash
curl http://localhost:5000
```
### 8. Modifier le code source
```python
from flask import Flask
app = Flask(__name__)
@app.route('/')
def hello_world():
    return 'Hello, World! I am in a container'
if __name__ == '__main__':
    app.run(debug=True, host='localhost', port=5000)
```
### 9. Tester l'application
```bash
curl http://localhost:5000
```
### 10. Arrêter l'application
```bash
docker-compose down
```
