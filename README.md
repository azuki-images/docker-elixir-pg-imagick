[azukiapp/elixir-pg-imagick](http://images.azk.io/#/elixir-pg-imagick)
==================

Base docker image to run **Elixir** applications (with image magick, postgresql and git) in [azk.io][azk]

[![Circle CI][circleci-badge]][circleci]
[![][imagelayers-badge]][imagelayers]

Elixir Versions (tags)
---

<versions>
- [`latest`, `1`, `1.3`, `1.3.4`](https://github.com/azuki-images/docker-elixir-pg-imagick/blob/v1.3/1.3/Dockerfile)
</versions>

Image content use http://images.azk.io/#/elixir

### Usage with `azk`

Example of using this image with [azk][azk]:

```js
/**
 * Documentation: http://docs.azk.io/Azkfile.js
 */

// Adds the systems that shape your system
systems({
  "elixir-pg-imagick": {
    // Dependent systems
    depends: [], // postgres, mysql, mongodb ...
    // More info about elixir-pg-imagick image: http://images.azk.io/#/elixir-pg-imagick?from=images-azkfile-elixir-pg-imagick
    image: {"docker": "azukiapp/elixir-pg-imagick:1.3"},
    // or use Dockerfile to custimize your image
    //image: {"dockerfile": "./Dockerfile"},
    // Steps to execute before running instances
    provision: [
      "/azk/#{manifest.dir}"       : sync("."),
      "mix do deps.get, compile",
      // Phoenix provision steps
      // "mix ecto.create",
      // "mix ecto.migrate",
    ],
    workdir: "/azk/#{manifest.dir}",
    command: "mix run --no-halt",
    // command: "mix phoenix.server --no-deps-check",
    wait: {"retry": 20, "timeout": 1000},
    mounts: {
      "/azk/#{manifest.dir}"       : sync("."),
      // Elixir
      "/root/.hex"                 : persistent("#{system.name}/.hex"),
      "/azk/#{manifest.dir}/deps"  : persistent("#{system.name}/deps"),
      "/azk/#{manifest.dir}/_build": persistent("#{system.name}/_build"),
    },
    scalable: {"default": 1},
    http: {
      domains: [ "#{system.name}.#{azk.default_domain}" ]
    },
    ports: {
      http: "4000",
    },
    envs: {
      // set instances variables
      MIX_ENV: "dev"
    },
  },
});
```

## Extend image with `Dockerfile`

Install more packages:

```dockerfile
# Dockerfile
FROM azukiapp/elixir-pg-imagick:1.3

# install nodejs
RUN  apk add --update nodejs \
  && rm -rf /var/cache/apk/* /var/tmp/* \

CMD ["iex"]
```

To build the image:

```sh
$ docker build -t azukiapp/elixir-pg-imagick-node:1.3 .
```

To more packages, access [alpine packages][alpine-packages]

### Usage with `docker`

To run the image and bind to port 4000:

```sh
$ docker run -it --name my-app -p 4000:4000 -v "$PWD":/myapp -w /myapp azukiapp/elixir-pg-imagick:1.3 iex
```

Logs
---

```sh
# with azk
$ azk logs my-app

# with docker
$ docker logs <CONTAINER_ID>
```

## License

"Azuki", "azk" and the Azuki logo are Copyright 2013-2016 Azuki Serviços de Internet LTDA.

**azk** source code is released under [Apache 2 License][LICENSE].

Check LEGAL and LICENSE files for more information.

[azk]: http://azk.io
[alpine-packages]: http://pkgs.alpinelinux.org/

[circleci]: https://circleci.com/gh/azuki-images/docker-elixir-pg-imagick
[circleci-badge]: https://circleci.com/gh/azuki-images/docker-elixir-pg-imagick.svg?style=svg

[imagelayers]: https://imagelayers.io/?images=azukiapp/elixir-pg-imagick:latest,azukiapp/elixir-pg-imagick:1.3
[imagelayers-badge]: https://imagelayers.io/badge/azukiapp/elixir-pg-imagick:latest.svg

[issues]: https://github.com/azuki-images/docker-elixir-pg-imagick/issues
[license]: https://github.com/azuki-images/docker-elixir-pg-imagick/blob/master/LICENSE
