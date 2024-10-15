```text
 ██████╗███████╗██╗      █████╗ ███╗   ██╗████████╗    ██████╗ ██╗      ██████╗  ██████╗ 
██╔════╝██╔════╝██║     ██╔══██╗████╗  ██║╚══██╔══╝    ██╔══██╗██║     ██╔═══██╗██╔════╝ 
██║     ███████╗██║     ███████║██╔██╗ ██║   ██║       ██████╔╝██║     ██║   ██║██║  ███╗
██║     ╚════██║██║     ██╔══██║██║╚██╗██║   ██║       ██╔══██╗██║     ██║   ██║██║   ██║
╚██████╗███████║███████╗██║  ██║██║ ╚████║   ██║       ██████╔╝███████╗╚██████╔╝╚██████╔╝
 ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝       ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝ 
```

# CSlant blog docker installer

This repo is to set up the CSlant blog with Docker.

We can use this runner to update the blog for development and production.

## Docker Hub

[CSlant Docker Hub](https://hub.docker.com/r/cslant)

In this docker repository, we have built the following images:

- [cslant/blog-php](https://hub.docker.com/r/cslant/blog-php)
- [cslant/blog-worker](https://hub.docker.com/r/cslant/blog-worker)
- [cslant/blog-node](https://hub.docker.com/r/cslant/blog-node)
- [cslant/blog-nginx](https://hub.docker.com/r/cslant/blog-nginx)
- [cslant/blog-postgres](https://hub.docker.com/r/cslant/blog-postgres)

---

## Prerequisites

First, copy the `.env.example` file to `.env` and update the values.

```bash
envsubst < .env.example > .env
```

If you don't have `envsubst` command, you can use the following command:

```bash
cp .env.example .env
```

## Installation

In the `.env` file, update the values to match your environment.

```dotenv
# .env file
# ...

# Path to your code folder
SOURCE_CODE_PATH=/Users/tanhongit/CSlant/blog/source

GIT_SSH_URL="git@github.com:cslant"
GIT_TOKEN="ghp_1234567890"

## DOMAIN SETTING
CSLANT_DOMAIN=cslant.com.local
BLOG_DOMAIN=blog.cslant.com.local
BLOG_API_DOMAIN=api.blog.cslant.com.local
BLOG_ADMIN_DOMAIN=admin.blog.cslant.com.local

BLOG_ADMIN_DIR=hello

FE_COMMAND=dev
```

> [!IMPORTANT]
> ### Command can't be used if wrong values are set in the `.env` file.
> 
> 1. If the `SOURCE_CODE_PATH` is wrong, the runner will not be able to find the source code. So, please make sure the `SOURCE_CODE_PATH` is correct.
>
>       - So please get the full path of the `SOURCE_CODE_PATH` with the following command:
> 
>       ```bash
>       pwd
>       ```
> 
> 2. Ensure the `GIT_SSH_URL` and `GIT_TOKEN` are correct. If the values are wrong, the runner will not be able to sync the repositories.
> 
>       - Please get `GIT_TOKEN` from [here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic).

Then, you can just run the following command to start the runner.

```bash
bash runner.sh all
```

The above command will run all the commands in the runner and start `nginx`, `php`, `node`, `fe` , `postgres` and `elasticsearch` services.

---

If you want to start all the services, you can use the following command:

```bash
bash runner.sh all
bash runner.sh start_all
```

### Update host file

Add the following lines to the `/etc/hosts` file:

```bash
127.0.0.1       blog.cslant.com.local admin.blog.cslant.com.local api.blog.cslant.com.local
```

If you're using another domain, please update the domain in the `.env` file and update the domain in the `/etc/hosts` file as well.

---

## Usage

The runner has the following commands:

| Command           | Description                          |
|-------------------|--------------------------------------|
| `help`, `h`       | Shows the help message               |
| `git_sync`, `gs`  | Syncs the blog repositories          |
| `network`, `n`    | Creates the Docker network           |
| `build`, `b`      | Builds the blog with Docker          |
| `build_all`, `ba` | Builds all blog services with Docker |
| `start`, `s`      | Starts the blog services in Docker   |
| `start_all`, `sa` | Starts all blog services in Docker   |
| `install`, `i`    | Install all blog dependencies        |
| `update`, `u`     | Update all blog dependencies         |
| `resource`, `r`   | Download blog resources              |
| `es_import`, `ei` | Import data to Elasticsearch         |
| `all`, `a`        | Runs all the commands                |

To run a specific command, use the following command:

```bash
bash runner.sh <command>
```

For example, to run the `help` command to show the help message, use the following command:

```bash
bash runner.sh help
```

---

## Backup database in Docker

Backup this blog database to a SQL file:

```bash
pg_dump -U username -h hostname database_name >> /path/to/backup.sql
```

Example in this Docker:

```bash
pg_dump -U root -h localhost cslant_blog >> /docker-entrypoint-initdb.d/cslant_blog.sql
```

## Restore database in Docker

```bash
psql -U root -h localhost cslant_blog < /docker-entrypoint-initdb.d/cslant_blog.sql
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
