SImRuby: Jour 2-5 - Rails
=========================

Ce repository contient les specs de la majeure partie de la semaine
immersive Ruby on Rails.

Programme des 4 jours
---------------------

Durant cette 2e partie de la semaine, nous allons travailler sur
Rails. Le nombre de features (merveilleuse) et la puissance
(extraordinaire) de ce framework sont si grandes que nous n'aurons
pas, helas (hélas!), le temps d'en aborder toute la richesse, ni celui
d'explorer tous les facettes de sa communauté. Nous allons néanmoins
pouvoir aborder les fondements de rails et vous fournir les outils
continuer à investiguer par vous même.

Ordre des exercices
-------------------


Comment exécuter les specs ?
----------------------------

Depuis la vm vagrant fournie ici: http://github.com/elthariel/simruby

    host $ cd /vagrant
    host $ gem install rails -v '~4.0'
    host $ rails new gazooyr

Maintenant, il faut editer le Gemfile de votre application pour
ajouter toutes les dependances des tests unitaires :

```ruby
group :development, :test do
  # Testing framework for rails 3.x and 4.x
  gem 'rspec-rails'
  # Some old stuff borrowed from Perl.
  gem 'faker', git: 'git://github.com/stympy/faker.git'
  # Some tools to generate test data
  gem 'factory_girl_rails'
  # Use debugger
  gem 'debugger'
  # Use capybara (run acceptance test in a browser)
  gem 'capybara'
  # Deploy the right version of PhantomJS using rubygems
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
  # Use phantomjs (acceptance tests are truely headless)
  gem 'poltergeist'
  # Screenshots on failure
  gem 'capybara-screenshot'
  # Database cleaner for test suite
  gem 'database_cleaner'
  # Capybara test in a real browser for kikouloliness
  gem 'selenium-webdriver'
  # Code coverage tool
  gem 'simplecov', :require => false
end
```

Maintenant mettez à jour votre bundle

    host $ cd /vagrant/gazooyr
    host $ bundle install
    [...]

D'autre part, puisque les specs sont fournies, vous devez désactiver
la génération des specs par les générateurs de rails. Il faut donc
ajouter ces lignes dans le fichier config/application.rb, dans le bloc
principal de configuration:

```ruby
config.generators do |g|
  g.view_specs false
  g.helper_specs false
  g.routing_specs false
  g.controller_specs false
end
```

Vous devriez maintenant pouvoir executer les specs :

    host $ ln -s /vagrant/rails /vagrant/gazooyr/spec
    host $ cd /vagrant
    host $ rspec

Vous pouvez aussi executer seulement un seul fichier de spec

    host $ rspec spec/features/welcome_spec.rb

Ou encore seulement un seul example, en specifiant le fichier puis la
ligne de l'exemple

    host $ rspec spec/features/welcome_spec.rb:42





