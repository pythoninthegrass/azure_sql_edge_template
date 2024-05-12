# syntax=docker/dockerfile:1.6

FROM ubuntu:18.04 as builder

RUN apt-get update \
    && apt-get install -y -qq --no-install-recommends \
        ca-certificates \
        curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# TODO: golf run statements w/heredoc; use gh api to find latest release
RUN curl -LJO https://github.com/microsoft/go-sqlcmd/releases/download/v1.6.0/sqlcmd_1.6.0-1_all.deb

RUN dpkg -i sqlcmd_1.6.0-1_all.deb

FROM mcr.microsoft.com/azure-sql-edge:latest as runner

COPY --from=builder /usr/bin/sqlcmd /usr/bin/sqlcmd
