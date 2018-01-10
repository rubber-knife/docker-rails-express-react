
# Docker setup for Rails API-only, Express, and React

## Instructions
1. `$ git clone git@github.com:rubber-knife/docker-rails-express-react.git docker`
2. `$ cd docker`
3. `$ docker-compose up` (the first time you run this it will take a _long time_; subsequent executions will be much, much faster)
4. `$ docker-compose run ruby rails db:create db:migrate`

## Notes
1. You can Use `CTRL+C` to wind down containers; this is more or less equivalent to running `docker_compose down` from a separate terminal
2. `$ docker container ls` will list active/running containers
2. `$ docker container ls --all` will list all containers, regardless of status
4. `$ docker container stop <CONTAINER ID/NAME>` will terminate the container process but not remove the build
5. `$ docker container start <CONTAINER ID/NAME>` resumes stopped containers
6. Other primary/useful docker commands:
    -  `$ docker images` — a list of all of the images you'vve built or else pulled to the machine
    - `$ docker rmi <IMAGE ID/REPOSITORY>` — remove an image
    - `$ docker network ls` — list networks
    - `$ docker network inspect <NETWORK ID/NAME` — mostly verbose but also very useful, eg. which containers are a part of the network
    - `$ docker volume ls` — list volumes
    - `$ docker container/volume/network prune` — removes unused docker resources
