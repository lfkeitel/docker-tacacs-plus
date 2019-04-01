# TACACS+ Docker Image

This image is a built version of
[tac_plus](http://www.pro-bono-publico.de/projects/), a TACACS+ implementation
written by Marc Huber.

## Tags

`latest`, `ubuntu`, `ubuntu-201903311519` - Latest version based on Ubuntu
18.04.

`alpine`, `alpine-201903311519` - Latest version based on Alpine 3.9.

## Building

Docker engine 17.06+ is required to build this image because it uses a
multi-stage build. To build run: `make`. Add the argument `alpine` or `ubuntu`
to build a specific image.

## Additions

The Docker images include the Perl LDAP packages for Mavis authentication.

## Using

To run with the default configuration:

```
docker run --name tac_plus -d -p 4949:49 lfkeitel/tacacs_plus:latest
```

The default configuration has a user with the username:password of admin:admin
and the enable password is set to enable. Obviously, don't use this
configuration in production.

The configuration is located at `/etc/tac_plus/tac_plus.cfg`. If you wish to use
a custom configuration, simply overwrite it in a derived image or use a volume
mount.

By default logs go to stdout.

Port 49 is exposed as the server port.

## Configuration

Configuration documentation can be found
[here](http://www.pro-bono-publico.de/projects/unpacked/doc/tac_plus.pdf).

## License

The LICENSE file in this repository is for the build scripts and built Docker
image.

This image includes software developed by Marc Huber (Marc.Huber@web.de).

The tac_plus and supporting software is under a different license which can be
found [here](http://www.pro-bono-publico.de/projects/unpacked/LICENSE).
