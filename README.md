## Oxide

## Submodule init instructions
cd into both client/server repos and run
    
    git submodule init
    git submodule update
    
## Build Instructions
Generate proto files for client

    ./protogen.sh
Look for README.md files on the <this_repo>-client/server repositories.

## Setup server and database with docker
### (Docker setup would require modifications to envoy.yaml in client, and model.rs in server)

    docker build -t oxide-server .

Manually start container with port set to 3001

    docker cp ./oxide-server/ oxide-server:/root/
    docker cp ./proto/ oxide-server:/root/

Open cli for oxide-server

    cd root/oxide-server
    rustup component add rustfmt
    cargo run

Separate Terminal instance

    docker pull mongo
    docker run --name oxide-data -d mongo:latest

    docker network create oxide-net
    docker network connect oxide-net oxide-data
    docker network connect oxide-net oxide-server

    docker network inspect oxide-net
Verify all containers are added to the network

### TODOs
- [x] Send/receive messages (no web-sockets)
- [x] Fetch conversations for user
- [x] Auth - password hashing
- [x] Persistence/DB
