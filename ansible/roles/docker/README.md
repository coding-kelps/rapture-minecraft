api
=========

Setup the expressJS backend server publicly accessible at a given domain name

Requirements
------------

The docker runtime is required on the remote host to run this role.
The api server expect a Postgres database to run in a "db_network" docker interface.
To be publicly accessible a traefik reverse proxy should be running (it can be
setup afterward), and the given domain name should be registered
to the IP address of the traefik reverse proxy.
Also, as there is a high probability that the web server docker image is stored on a private registry, the ssh user should already have logged in the potential private registry.

Role Variables
--------------

| Name  | Default | Description |
| :---: | :---: | :--- |
| api__dns | api.hivolunteer.dev | The domain name at which the api server should be publicly accessible |
| api__image | europe-west9-docker.pkg.dev/hivolunteer-392013/hivolunteer/back | The base image of the api server |
| api__image_tag | 0.2.0-alpha | The image tag (~ version) of the api server |
| api__port | 8000 | The port at which the api server is exposed |
| api__database_name | postgres | The name of the database to which the api server will try to connect |
| api__database_user | hivolunteer_magic | The name of the database user as which the api server will try to connect to the database |
| api__database_password | hivolunteer_magic | The password of the database user as which the api server will try to connect to the database |


Dependencies
------------

- community.docker
