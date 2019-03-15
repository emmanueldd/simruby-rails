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

    host $ rails new gazooyr
    host $ cd gazooyr
    host $ git clone https://github.com/emmanueldd/simruby-rails.git spec

Maintenant, il faut editer le Gemfile de votre application pour
ajouter toutes les dependances des tests unitaires :

```ruby

# il faut supprimer l'occurence précédente de sqlite3 du gemfile, et la modifier comme suit :
gem 'sqlite3', '~> 1.3.6'

group :development, :test do
  # Testing framework for rails 3.x and 4.x
  gem 'rspec-rails'
  # Some old stuff borrowed from Perl.
  gem 'faker', git: 'git://github.com/stympy/faker.git'
  # Some tools to generate test data
  gem 'factory_girl_rails'
  # Use debugger
  gem 'debugger2'
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

    host $ bundle install

Et créez votre base de données

    host $ rails db:create


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

    host $ rspec

Vous pouvez aussi executer seulement un seul fichier de spec

    host $ rspec spec/features/welcome_spec.rb

Ou encore seulement un seul example, en specifiant le fichier puis la
ligne de l'exemple

    host $ rspec spec/features/welcome_spec.rb:42


Petits indices pour les intellects qui lisent la consigne jusqu'au bout 😏
----------------------------
Les specs précédés d'un point (.follow_spec.rb, et .hash_tags_spec.rb) sont en option. Si vous souhaitez les faire, supprimez le point qui précède le nom du fichier.
Les features à développer sont dans le dossier "features", les specs de routes "routing" sont là pour vous aiguiller.

Vous remarquerez aussi, que j'ai retiré l'authentification par username.

Pour "Page", on vous demande de retrouver une page à partir de son "slug".
Un slug est un nom au format url, les espaces sont donc remplacés par des "-" .
Exemple : "psg éliminé" devient "psg-elimine".
Nous avons vu que nous pouvions retrouver une entrée en base de données, depuis son id avec NomDuModel.find(objet_id) qui est l'équivalent de NomDuModel.find_by(id: objet_id) . Je vous laisse transposer tout ça avec le slug..

N'oubliez pas que la console est votre amie, à la racine de votre projet, vous pouvez taper la commande suivante :

    host $ rails c

Et tester  :

Page.find(...)
Page.find_by(...)
Page.where(...)

Pour ce qui est des gazooy ou plutôt des gazooies, je vous laisse faire vos recherches sur Ruby On Rails, le pluriel d'une Class, et le fichier "inflections.rb". "Ruby On Rails plural class inflections.rb" sur google devrait faire l'affaire.

Si vous rencontrez des problèmes, vous pouvez me contacter sur Linkedin. Pensez-y, vraiment !
