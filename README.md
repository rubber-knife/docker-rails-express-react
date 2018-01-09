# Docker setup for Rails API-only, Express, and React

## Setup
1. `git clone git@github.com:rubber-knife/docker-rails-express-react.git docker`
2. `cd docker`
3. `docker-compose build`
4. `docker-compose run ruby rails db:create`
5. `docker-compose run ruby rails db:migrate`
4. `docker-compose up`
