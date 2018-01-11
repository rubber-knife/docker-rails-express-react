# Docker setup for Rails API-only, Express, and React

## Workflow goals
1. Push to github
2. Service hook fires; Travis CI is triggered
3. Travis runs tests, creates React build
4. This is where things get hazy... I think you need to create a new image on the spot, integrating the build files, using Travis
5. Push build using git to production server
6. Server triggers `post-receive` git hook
7. `post-receive` script handles spinning up Docker images, etc.


## Instructions
1. `git clone git@github.com:rubber-knife/docker-rails-express-react.git docker`
2. `cd docker`
3. `./scripts/start`
5. `docker-compose run ruby rails db:create db:migrate`

## Current workflow
1. After running `./scripts/start`, two separate docker_compose files will be executed
    1. `docker-gen` — detects any container changes by analyzing `docker.sock`
    2. `

## Notes
1. `./scripts/start` initializes the docker environment, eg. creates base network
