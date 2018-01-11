# Docker setup for Rails API-only, Express, and React

## Workflow goals
1. Push to github
2. Service hook fires; Travis CI is triggered
3. Travis runs tests, creates React build (if branch === master?)
4. This is where things get hazy...
    - Because this deployment solution relies on dynamically creating/updating nginx configurations from a template, it makes sense to serve the React build via (the automatically proxied) Express so that we don't have to modify nginx conf manually
    - To this end, I think one option is to create a new docker image on the spot, integrating the build files into the Express container (by creating a volume?), during the `after_success` stage
    - Alternatively, integrating the build into the Express container could be done on the production server
5. Push build using git to production server
6. Server triggers `post-receive` git hook
7. `post-receive` script handles spinning up Docker images, etc.


## Instructions
1. `$ git clone git@github.com:rubber-knife/docker-rails-express-react.git docker`
2. `$ cd docker`
3. `$ cp .env.example .env` — adjust variables as necessary
3. `$ ./scripts/start`
5. `$ docker-compose run ruby rails db:create db:migrate`

## Current workflow
1. After running `./scripts/start`, two separate docker_compose files will be executed
    1. `nginx-proxy.yml`
        - `nginx` — self-explanatory
        - `jwilder/docker-gen` — detects any container changes by analyzing `docker.sock`; notifies `nginx` and `letsencrypt-nginx-proxy-companion` when necessary
        - `jrcs/letsencrypt-nginx-proxy-companion` — automatically create/maintain lets-encrypt config on notifications from `jwilder/docker-gen`
    2. `docker-compose.yml`
        - `postgres` — self-explanatory
        - `ruby` — serves Rails 5.1.4 API-only
        - `express` — serves Express w/ `nodemon` (need to 86 `nodemon` in production and ensure logs are written to file)
        - `react` — serves React w/ webpack-dev-server (this has to be changed for staging/production)

## Notes
1. `$ ./scripts/start` — initializes docker environment, eg. creates base network; runs `docker-compose` files
