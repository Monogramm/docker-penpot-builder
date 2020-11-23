[![License: AGPL v3][uri_license_image]][uri_license]
[![Build Status](https://travis-ci.org/Monogramm/docker-penpot-builder.svg)](https://travis-ci.org/Monogramm/docker-penpot-builder)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/monogramm/docker-penpot-builder.svg)](https://hub.docker.com/r/monogramm/docker-penpot-builder/)
[![Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-penpot-builder.svg)](https://hub.docker.com/r/monogramm/docker-penpot-builder/)
[![Docker layers](https://images.microbadger.com/badges/image/monogramm/docker-penpot-builder.svg)](https://microbadger.com/images/monogramm/docker-penpot-builder)

# PenPot docker builder

Docker image for building PenPot frontend and backend.

## What is PenPot

The Open-Source prototyping tool.

> [More informations](https://www.penpot.app/)

## Supported tags

<https://hub.docker.com/r/monogramm/docker-penpot-builder/>

-   `latest`

## Adding Features

If the image does not include the packages you need, you can easily build your own image on top of it.
Start your derived image with the `FROM` statement and add whatever you like.

```yaml
FROM monogramm/docker-penpot-builder:latest

RUN ...

```

## Questions / Issues

If you got any questions or problems using the image, please visit our [Github Repository](https://github.com/Monogramm/docker-penpot-builder) and write an issue.  

[uri_license]: http://www.gnu.org/licenses/agpl.html

[uri_license_image]: https://img.shields.io/badge/License-AGPL%20v3-blue.svg
