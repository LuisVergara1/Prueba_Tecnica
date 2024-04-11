FROM ruby:3.3.0

# Instalar dependencias del sistema
RUN apt-get update && \
    apt-get install -y nodejs npm && \
    rm -rf /var/lib/apt/lists/*

# Configurar directorio de trabajo
WORKDIR /myapp

# Copiar Gemfile y Gemfile.lock e instalar gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copiar el resto de la aplicación y preparar la base de datos
COPY . .
#RUN bundle exec rails assets:precompile && \
#   bundle exec rails db:migrate

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

