# Awesome Docker Piwigo

[Piwigo](https://piwigo.org/) is open source photo gallery software for the web. Designed for organisations, teams and individuals.

**Awesome Docker Piwigo** uses `docker-compose`. You can use **one instruction** to deploy Piwigo from source to web service, connect to the database, and complete the installation.

## Usage

Piwigo service's username and password are stored in `piwigo.config`. You can change them to the values you want before starting the container.

The default value for the username is `admin`, and the default value for the password is also `admin`。

```bash
docker-compose up -d
```

Run the command and then Piwigo' welcome page should be available at http://localhost:8088.

## Features

1. **One service per container**. According to Docker best practices, each container should have only one aspect. Decoupling applications into multiple containers makes it easier to scale and reuse containers horizontally. So I put the **database service**, **web service**, and **configuration service** in three separate containers and use docker-compose to orchestrate them. To ensure that each service can run after its dependent service is started, I use `depends_on` and [`wait-for-it.sh`](https://github.com/vishnubob/wait-for-it) to guarantee it.
2. **Flexibility**. The configuration parameters in the process of installing piwigo can be configured in piwigo.config. After the modification in piwigo.config is completed, the container can be started, and the piwigo installation can be completed according to the modified content instead of being needed like other piwigo dockers. Manually open the browser and enter the page to complete the installation.
3. **Scalability**. Most other piwigo dockers simply run the piwigo web service and manually configure it. In addition to the flexible installation of Awesome Docker Piwigo, you can also edit `config.sh` file to your needs to add additional functions, such as adding initialization photos when creating piwigo, etc.
