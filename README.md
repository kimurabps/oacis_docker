# oacis_docker

[![release](https://img.shields.io/github/release/crest-cassia/oacis.svg)](https://github.com/crest-cassia/oacis/releases/latest)
[![docker image](http://img.shields.io/badge/docker_image-ready-brightgreen.svg)](https://registry.hub.docker.com/u/takeshiuchitane/oacis/)

You can run [OAICS](https://github.com/crest-cassia/oacis) anywhere.

## Quick Start

1. Setup docker environment

    - See [Docker home page](https://www.docker.com/).
    - If you are Mac or WIndows user, install [Docker Toolbox](https://www.docker.com/toolbox).

2. Start an oacis instance
    ```sh
    docker run --name oacis -d oacis/oacis
    ```

    - The default port is 3000.
    - (for Mac or Windows users) Run the above command in *Docker Quickstart Terminal*.

3. Access OACIS web interface

    - You can access OACIS web interface via a web browser.(`http://localhost:3000`)
    - (Mac or Windows) Access `192.168.99.100` instead of `localhost`.
        - ![docket_tool_ip](https://github.com/crest-cassia/oacis_docker/wiki/images/docker_tool_ip.png)


## Select Port

- The port 3001 is used instead of 3000
    ```sh
    docker run --name oacis -d -p 3001:3000 oacis/oacis
    ```

## Backup and Restore

To make a backup, run the following command to dump DB data.
Containers must be running when you make a backup.
Data will be exported to `/home/oacis/oacis/public/Result_development/db` directory in the container.

```sh
datetime=`date +%Y%m%d-%H%M` docker exec -it oacis bash -c "cd /home/oacis/oacis/public/Result_development; if [ ! -d db ]; then mkdir db; fi; cd db; mongodump --db oacis_development; mv dump dump-$datetime; chown -R oacis:oacis /home/oacis/oacis/public/Result_development/db"
```

Then, please make a backup of the directory *Result_development*.
```sh
docker cp oacis:/home/oacis/oacis/public/Result_development .
```


To restore data, run the following command to copy *Result_development* and restore db data from Result_development/db/dump.

```sh
docker run --name another_oacis oacis/oacis
sleep 20
docker cp Result_development another_oacis:/home/oacis/oaics/public/Result_development
docker exec -it another_oacis bash -c "cd /home/oacis/oacis/public/Result_development/db/\`cd /home/oacis/oacis/public/Result_development/db; ls | grep dump | sort | tail -n 1\`/oacis_development; mongorestore --db oacis_development ."
```

## Logging in the container

By logging in the container, you can update the configuration of the container.
For instance, you can install additional packages, set up ssh-agent, and see the logs.

To login the container as a normal user, run

```sh
docker exec -it oacis bash -c 'su - oacis; cd /home/oacis/oacis; exec "bash && exit"'
```

To login as the root user, run

```sh
docker exec -it oacis bash
```

## More infomation

See [wiki](https://github.com/crest-cassia/oacis_docker/wiki).

## License

  - [oacis_docker](https://github.com/crest-cassia/oacis_docker) is a part of [OACIS](https://github.com/crest-cassia/oacis).
  - OACIS and oacis_docker are published under the term of the MIT License (MIT).
  - Copyright (c) 2014,2015 RIKEN, AICS

