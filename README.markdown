# Deary

Dear my diary

## Dependencies

 * Ruby 1.9.3 or later than (__recommended later 2.0.0__)
 * PostgreSQL
 * Node.js

## Install dependencies

### Gems

```
gem install bundler
bundle install
```

### NPM modules

```
npm install
```

### Bower components

```
./node_modules/.bin/bower install
```

## Launch the application

```
bundle exec padrino start
```

## Compile JavaScript

```
./node_modules/.bin/grunt js
```

## Setup database

```
bundle exec rake db:create db:migrate
```
