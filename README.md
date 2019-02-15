
[uri_license]: http://www.gnu.org/licenses/agpl.html
[uri_license_image]: https://img.shields.io/badge/License-AGPL%20v3-blue.svg

[![License: AGPL v3][uri_license_image]][uri_license]
[![Build Status](https://travis-ci.org/Monogramm/docker-uxbox-builder.svg)](https://travis-ci.org/Monogramm/docker-uxbox-builder)
[![Docker Automated buid](https://img.shields.io/docker/build/monogramm/docker-uxbox-builder.svg)](https://hub.docker.com/r/monogramm/docker-uxbox-builder/)
[![Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-uxbox-builder.svg)](https://hub.docker.com/r/monogramm/docker-uxbox-builder/)

# UXBOX docker builder

Docker image for building UXBOX frontend and backend.

## What is uxbox ?

The Open-Source prototyping tool

> [More informations](https://github.com/Monogramm/uxbox)

## Supported tags

https://hub.docker.com/r/monogramm/docker-uxbox-builder/

* `latest`

# Adding Features
If the image does not include the packages you need, you can easily build your own image on top of it.
Start your derived image with the `FROM` statement and add whatever you like.

```yaml
FROM monogramm/docker-uxbox-builder:latest

RUN ...

```

# Questions / Issues
If you got any questions or problems using the image, please visit our [Github Repository](https://github.com/Monogramm/docker-uxbox-builder) and write an issue.  
