# Docker setup for Rails API-only, Express, and React

## Workflow goals
1. Push to github
2. Service hook fires; Travis CI is triggered
3. Travis runs tests — (if branch === master?) creates React build and deploys
4. This is where things get hazy...
    - Because this deployment solution relies on dynamically creating/updating nginx configurations from a template, it makes sense to serve the React build via (an automatically proxied) Express instead of adding nginx configuration manually (or copying additional config files, keeping them in version control, etc.) to serve the build
    - To this end, I think one option is to create a new Docker image on the spot, giving the Express container access to the React build (by creating a volume?), which would run as a script during the `after_success` stage in the `travis.yml`
    - Alternatively, integrating the build into the Express container could be done on the production server
5. Push using git to production server
6. Production server triggers `post-receive` git hook
7. `post-receive` script handles any final loose ends before spinning up Docker images


## Instructions
1. `$ git clone git@github.com:rubber-knife/docker-rails-express-react.git docker`
2. `$ cd docker`
3. `$ cp .env.example .env` — adjust variables as necessary
3. `$ ./scripts/start`
5. `$ docker-compose run ruby rails db:create db:migrate`
6. Verify things are working — eg. check out `https://rails.your-domain.tld`
Notes:
    - DNS must be set up to forward `your-domain.tld` to your current working host for this to work
    - Only one instance of nginx can be bound to port 80; avoid potentionally conflicting instances by running something akin to `sudo service nginx stop`

## Current (in progress) workflow
1. After running `./scripts/start`, two separate docker_compose files will be executed
    1. `nginx-proxy.yml` creates the following containers:
        - `nginx` — self-explanatory
        - `jwilder/docker-gen` — detects any container changes by analyzing `docker.sock`; notifies `nginx` and `letsencrypt-nginx-proxy-companion` when necessary
        - `jrcs/letsencrypt-nginx-proxy-companion` — automatically creates/maintains lets-encrypt config on notifications from `jwilder/docker-gen`
    2. `docker-compose.yml` creates the following containers:
        - `postgres` — self-explanatory (note: still need to research user/password envrionment variables)
        - `ruby` — serves Rails
        - `express` — serves Express w/ `nodemon` (need to 86 `nodemon` in production and ensure logs are written to file)
        - `react` — serves React w/ webpack-dev-server (this has to be changed for staging/production)
2. New nginx blocks for Rails and Express can now be found in `/etc/nginx/conf.d/default.conf`

## Miscellaneous
1. `$ ./scripts/start` — initializes docker environment, eg. creates base network; runs `docker-compose` files
