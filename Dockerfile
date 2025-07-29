# Use the Debian-based image for PostgreSQL 17
FROM postgres:17-bookworm

# The pg_partman version to use
ARG PG_PARTMAN_VERSION=v5.2.4

USER root

# Install dependencies, compile, and clean up.
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        ca-certificates \
        postgresql-server-dev-17 \
	postgresql-17-cron; \
    \
    # Now that ca-certificates is installed, git clone will work
    git clone --branch ${PG_PARTMAN_VERSION} --depth 1 https://github.com/pgpartman/pg_partman.git /tmp/pg_partman; \
    \
    cd /tmp/pg_partman; \
    make; \
    make install; \
    \
    # Clean up all the build dependencies, including ca-certificates
    apt-get purge -y --auto-remove \
        build-essential \
        git \
        ca-certificates \
        postgresql-server-dev-17; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/pg_partman;

USER postgres
