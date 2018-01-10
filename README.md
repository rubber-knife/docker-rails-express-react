
# Docker setup for Rails API-only, Express, and React

## Instructions
1. `$ git clone git@github.com:rubber-knife/docker-rails-express-react.git docker`
2. `$ cd docker`
3. `$ docker-compose up` (the first time you run this it will take a _long time_; subsequent executions will be much, much faster)
4. `$ docker-compose run ruby rails db:create db:migrate`

## Notes
1. You can Use `CTRL+C` to wind down containers; this is more or less equivalent to running `docker_compose down` from a separate terminal
2. `$ docker container ls` — lists all active/running containers
2. `$ docker container ls --all` — lists all containers, regardless of status
4. `$ docker container stop <CONTAINER ID/NAME>` — terminates the container process but doesn't remove the build
5. `$ docker container start <CONTAINER ID/NAME>` — resumes stopped containers
6. Other primary/useful docker commands:
    -  `$ docker images` — lists all of the images you've built (or else pulled to the machine)
    - `$ docker rmi <IMAGE ID/REPOSITORY>` — removes an image
    - `$ docker network ls` — lists networks
    - `$ docker network inspect <NETWORK ID/NAME` — oupts mostly verbose but also very useful info re: a single network, eg. which containers are a part of the network
    - `$ docker volume ls` — lists volumes
    - `$ docker container/volume/network prune` — removes unused docker resources
