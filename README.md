# Blog docker runner

This repo is to set up the runner for updating the blog.

We can use this runner to update the blog for development and production.

## Prerequisites

First, copy the `.env.example` file to `.env` and update the values.

```bash
envsubst < .env.example > .env
```

if you don't have `envsubst` command, you can use the following command:

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

## DOMAIN SETTING
CSLANT_DOMAIN=cslant.com.local
BLOG_DOMAIN=blog.cslant.com.local
BLOG_API_DOMAIN=api.blog.cslant.com.local
BLOG_ADMIN_DOMAIN=admin.blog.cslant.com.local

BLOG_ADMIN_DIR=hello
```

> [!IMPORTANT]
> ## Command can't be used if wrong values are set in the `.env` file.
> 
> * If the `SOURCE_CODE_PATH` is wrong, the runner will not be able to find the source code. So, please make sure the `SOURCE_CODE_PATH` is correct.
>
> So please get full path of the `SOURCE_CODE_PATH` with the following command:
> ```bash
> pwd
> ```

Then, run the following command to start the runner.

```bash
bash runner.sh all
```

## Usage

The runner has the following commands:

| Command     | Description                 |
|-------------|-----------------------------|
| `help`      | Shows the help message      |
| `git_sync`  | Syncs blog repositories     |
| `build`     | Builds the blog with Docker |
| `start`     | Starts the blog with Docker |
| `all`       | Runs all the commands       |

To run a specific command, use the following command:

```bash
bash runner.sh <command>
```

For example, to run the `help` command to show the help message, use the following command:

```bash
bash runner.sh help
```

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
