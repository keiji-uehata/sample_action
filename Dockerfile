FROM ghcr.io/qmk/qmk_cli:latest

WORKDIR /usr/src

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
