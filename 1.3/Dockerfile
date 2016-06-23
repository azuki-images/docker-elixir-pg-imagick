FROM azukiapp/elixir:1.3

# install postgresql client and build-base
RUN  apk add --update \
    git  \
    postgresql-client \
    build-base \
    imagemagick \
  && mix local.hex --force \
  && rm -rf /var/cache/apk/* /var/tmp/*

CMD ["iex"]
