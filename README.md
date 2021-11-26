[![CircleCI](https://circleci.com/gh/nejdetkadir/devise-jwt-starter/tree/master.svg?style=svg)](https://circleci.com/gh/nejdetkadir/devise-jwt-starter/tree/master)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Ruby Version](https://img.shields.io/badge/ruby%20v-3.0.0-blue.svg)
![Rails Version](https://img.shields.io/badge/rails%20v-6.1.4-blue.svg)
[![GPLv3 license](https://img.shields.io/badge/license-GPLv3-blue.svg)](LICENSE)

# Devise JWT Starter
It is a starter for Ruby on Rails API application with [devise gem](https://github.com/heartcombo/devise) with [devise-jwt](https://github.com/waiting-for-dev/devise-jwt) extension.

# Installation
## Prerequisites
- [Ruby](https://rvm.io/)
- [PostgreSQL](https://www.postgresql.org/download/)
## For Running
- Install GEM dependencies:
  ```bash
  bundle install
  ```

- Create database, migrate tables and run the seed data:
  ```bash
  rails db:create
  rails db:migrate
  rails db:seed
  ```

- If you are setting up again, when you already have previous databases:
  ```bash
  rails db:reset
  ```
- For dropping database
  ```bash
  rails db:drop
  ``` 

# LICENSE
```
GNU GENERAL PUBLIC LICENSE Version 3
```
