#Utiliser l'image officielle Ruby
FROM ruby:3.4

#Installer des dépendances du système
RUN apt-get update -qq && apt-get install -y build-essential nodejs npm

#Definir le répertoire de travail
WORKDIR /app

#Copier les fichiers Gemfile et Gemfile.lock
COPY app/Gemfile  app/Gemfile.lock  ./

#copier les fichiers 
RUN bundle install

#copier tout le code Rails
COPY app ./

#Ajouter les droits d'exécutions pour le pour script entrypoint 
RUN chmod +x /app/entrypoint.sh

#Ajouter yarn system
RUN npm install --global yarn

#Exposer le port du serveur Rails
EXPOSE 3000

#Entrée par défaut
ENTRYPOINT ["/app/entrypoint.sh"]

#Commande par défaut
CMD ["rails", "server", "-b", "0.0.0.0"]
