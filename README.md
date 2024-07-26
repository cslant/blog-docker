```text
      ____ ____  _        _    _   _ _____   ____  _     ___   ____
     / ___/ ___|| |      / \  | \ | |_   _| | __ )| |   / _ \ / ___|
    | |   \___ \| |     / _ \ |  \| | | |   |  _ \| |  | | | | |  _
    | |___ ___) | |___ / ___ \| |\  | | |   | |_) | |__| |_| | |_| |
     \____|____/|_____/_/   \_\_| \_| |_|   |____/|_____\___/ \____|
 ```

# CSlant blog docker installer

This repo is to set up the CSlant blog with Docker.

We can use this runner to update the blog for development and production.

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

### Update host file

Add the following lines to the `/etc/hosts` file:

```bash
127.0.0.1       blog.cslant.com.local admin.blog.cslant.com.local api.blog.cslant.com.local
```

If you're using another domain, please update the domain in the `.env` file and update the domain in the `/etc/hosts` file as well.

---

## Usage

The runner has the following commands:

| Command     | Description                        |
|-------------|------------------------------------|
| `help`      | Shows the help message             |
| `git_sync`  | Syncs blog repositories            |
| `build`     | Builds the blog with Docker        |
| `start`     | Starts the blog with Docker        |
| `start_all` | Starts all blog services in Docker |
| `install`   | Install all blog dependencies      |
| `resource`  | Download blog resources            |
| `all`       | Runs all the commands              |

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
