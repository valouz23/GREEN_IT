# Utilisez une image Ruby existante comme base
FROM ruby:latest

# Définissez le répertoire de travail dans le conteneur
WORKDIR /

# Copiez le Gemfile et le Gemfile.lock dans le conteneur
COPY Gemfile ./

# Installez les gems nécessaires
RUN bundle install

# Copiez le reste des fichiers de votre application dans le conteneur
COPY . .

# Démarrez votre application Ruby (par exemple, avec Sinatra)
CMD ["ruby", "hello.rb"]
