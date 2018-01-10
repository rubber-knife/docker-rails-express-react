# Docker setup for Rails API-only, Express, and React

## Instructions
1. `$ git clone git@github.com:rubber-knife/docker-rails-express-react.git docker`
2. `$ cd docker`
3. `$ docker-compose up` (the first time you run this it will take a _long time_; subsequent executions will be much, much faster)
4. `$ docker-compose run ruby rails db:create db:migrate`
5. This is strictly a dev solution:
    - A testing/staging/production workflow still needs to be established (see: [!branch/prod]https://github.com/rubber-knife/docker-rails-express-react/tree/prod)
    - It's yet unclear to me how exactly data is persisted in development/production environments (todo: read more about volumes)

## Notes
1. You can Use `CTRL+C` to wind down containers; this is more or less equivalent to running `$ docker_compose down` from a separate terminal
2. `$ docker container ls` — lists all active/running containers
2. `$ docker container ls --all` — lists all containers, regardless of status
4. `$ docker container stop <CONTAINER ID || NAME>` — terminates the container process but doesn't remove the build
5. `$ docker container start <CONTAINER ID || NAME>` — resumes stopped containers
6. Other primary/useful docker commands:
    - `$ docker images` — lists all of the images you've built (or else pulled to the machine)
    - `$ docker rmi <IMAGE ID || REPOSITORY>` — removes an image
    - `$ docker (volume || network) ls` — as with a container, this lists volumes/networks
    - `$ docker (container || volume || network) inspect <ID/NAME>` — provides verbose info , eg. which containers are a part of a network
    - `$ docker (container || volume || network) prune` — removes unused docker resources
