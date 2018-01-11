# Docker setup for Rails API-only, Express, and React

## Instructions
1. `$ git clone git@github.com:rubber-knife/docker-rails-express-react.git docker`
2. `$ cd docker`
3. `$ cp .env.example .env` — adjust variables as necessary
4. `$ ./scripts/start`
5. Verify things are working — eg. check out `https://rails.your-domain.tld`

#### Notes:
- DNS must be set up to forward `your-domain.tld` to your current working host for this to work
- Only one instance of nginx can be bound to port 80; avoid potentionally conflicting instances by running something equivalent to `sudo service nginx stop` before beginning

## Workflow goals
1. Push to github
2. Service hook fires; Travis CI is triggered
3. Travis runs tests
    - branch === master && build React and deploy to production
4. This is where things get hazy...
    - In the past I've found it handy to manually include a basic nginx config to serve static assets (from, say, `/var/www/project/client/build`) for React builds, but because this deployment solution relies on dynamically populating nginx configurations from a template, it makes sense to serve the React build via (an automatically reverse-proxied) Express instead of adding nginx configuration manually (or copying additional config files, keeping them in version control, etc.) to serve the build
    - To this end, one option might? be to configure the Express Dockerfile to map a volume (`./react/build:/express/public`) with the host which contains the React assets — then with Express it's just plain-old: `.use(express.static(__dirname + '/public'))`
5. Still from Travis, push using git to production server
6. Production server triggers `post-receive` git hook
7. `post-receive` script handles any final loose ends before spinning up Docker images

## Current (in progress) workflow
Note: what's below includes nothing of the workflow other than what would be run on the production server
1. After running `./scripts/start`, two separate docker-compose files will be executed
    1. `nginx-proxy.yml` creates the following containers:
        - `nginx` — self-explanatory
        - `jwilder/docker-gen` — detects any container changes by analyzing `docker.sock`; copies over new nginx config and notifies `nginx` and `letsencrypt-nginx-proxy-companion` when necessary
        - `jrcs/letsencrypt-nginx-proxy-companion` — automatically creates/maintains lets-encrypt config on notifications from `jwilder/docker-gen`
    2. `docker-compose.yml` creates the following containers:
        - `postgres` — self-explanatory (note: still need to research user/password envrionment variables)
        - `ruby` — serves Rails
        - `express` — serves Express w/ `nodemon` (need to 86 `nodemon` in production and ensure logs are written to file)
        - `react` — serves React w/ webpack-dev-server (this has to be changed for staging/production)
2. New nginx blocks for Rails and Express can now be found in `/etc/nginx/conf.d/default.conf`

## Miscellaneous
1. `$ ./scripts/start` — initializes docker environment, eg. creates base network; runs `docker-compose` files
