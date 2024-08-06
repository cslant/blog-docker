FROM postgres:16.0
LABEL maintainer="Tan Nguyen <tannp27@gmail.com>"
LABEL authors="cslant"
LABEL description="Postgres image for CSlant development - Using for Blog"

#####################################
# Set Timezone
#####################################
ARG TZ=Asia\Ho_Chi_Minh
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && chown -R postgres:root /var/lib/postgresql/data

COPY pg.cnf /etc/postgresql/conf.d/pg.cnf

RUN chmod 0444 /etc/postgresql/conf.d/pg.cnf

CMD ["postgres"]

EXPOSE 5432
