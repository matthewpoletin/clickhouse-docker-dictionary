FROM yandex/clickhouse-server:18.14

RUN ["mkdir", "-p", "/etc/clickhouse-server"]
COPY ["config.xml", "/etc/clickhouse-server/"]