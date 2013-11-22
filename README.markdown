# Deary

Dear my diary

 * Development build: [![Build Status (develop)](https://travis-ci.org/aereal/deary.png?branch=develop)](https://travis-ci.org/aereal/deary)
 * Latest build: [![Build Status (latest build)](https://travis-ci.org/aereal/deary.png)](https://travis-ci.org/aereal/deary)

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

## Compile SCSS

```
./node_modules/.bin/grunt css
```

## Continuous build

```
./node_modules/.bin/grunt watch
```

## Setup database

```
bundle exec rake db:create db:migrate
```
