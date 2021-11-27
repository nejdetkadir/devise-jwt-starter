[![CircleCI](https://circleci.com/gh/nejdetkadir/devise-jwt-starter/tree/master.svg?style=svg)](https://circleci.com/gh/nejdetkadir/devise-jwt-starter/tree/master)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Ruby Version](https://img.shields.io/badge/ruby%20v-3.0.0-blue.svg)
![Rails Version](https://img.shields.io/badge/rails%20v-6.1.4-blue.svg)
[![GPLv3 license](https://img.shields.io/badge/license-GPLv3-blue.svg)](LICENSE)

# Devise JWT Starter
It is a starter for Ruby on Rails API application with [devise gem](https://github.com/heartcombo/devise) with [devise-jwt](https://github.com/waiting-for-dev/devise-jwt) extension.

# Features
- Sign in/up/out
- Send an email when user resetting password.
- Send an email when user confirming email.
- Send email when user changed password.
- Development environment supports [mailcatcher](https://github.com/sj26/mailcatcher) as default.
- Writed unit tests with [rspec](https://github.com/rspec/rspec-rails).
- Uses [rubocop](https://github.com/rspec/rspec-rails) with extensions for code analyzing and formatting based on the community Ruby style guide.

# API Endpoints
| Route | HTTP Verb | Request Body | Header Body | Description |
| --- | --- | --- | --- | --- |
| /users | `POST` | ```{user: {email: "foo@bar.com", password: "mypass", password_confirmation: "mypass"}}``` | Empty | Returns authentication bearer token on header |
| /users/sign_in | `POST` | ```{user: {email: "foo@bar.com", password: "mypass"}}``` | Empty | Returns authentication bearer token on header |
| /users/sign_out | `DELETE` | Empty  | Authentication: Bearer Token | Returns sign out message |
| /users/password | `POST` | ```{user: {email: "foo@bar.com"}}```  | Empty | Returns instructions about resetting password  |
| /users/password | `PATCH` | ```{user: {reset_password_token: "token", password: "securepass", password_confirmation: "securepass"}}```  | Empty | Returns status |
| /users/confirmation | `POST` | ```{user: {email: "foo@bar.com"}}```  | Empty | Returns instructions about confirming password |
| /users/confirmation/:confirmation_token | `GET` | Empty | Empty | Returns status |

# Installation
## Prerequisites
- [Ruby](https://rvm.io/)
- [PostgreSQL](https://www.postgresql.org/download/)
- [Mailcatcher](https://github.com/sj26/mailcatcher) (For development)

### Environment variables
Create a file named ".env" in the root directory and fill its contents as follows for production environment.
```ruby
DEVISE_JWT_SECRET_KEY=X
SMTP_MAIL_USERNAME=X
SMTP_MAIL_PASSWORD=X
SMTP_MAIL_ADDRESS=X
SMTP_MAIL_PORT=X
SMTP_MAIL_DOMAIN=X
RESET_PASSWORD_URL=X
CONFIRMATION_EMAIL_URL=X
```

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
