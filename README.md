# blog-docker


Backup this blog database to a SQL file:

```bash
pg_dump -U username -h hostname database_name >> /path/to/backup.sql
```

Example:

```bash
pg_dump -U root -h localhost blog >> /docker-entrypoint-initdb.d/cslant_blog.sql
```
