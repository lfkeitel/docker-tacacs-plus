# TACACS+ Docker Image

This image is a built version of [tac_plus](http://www.pro-bono-publico.de/projects/), a TACACS+ implementation written by Marc Huber.

## Using the image

To run with the default configuration:

```
docker run --name tac_plus -d -p 4949:4949 lfkeitel/tac_plus:latest
```

The default configuration has a user with the username:password of admin:admin and the enable password is set to enable. Obviously, don't use the default configuration in production.

The configuration is located at `/etc/tac_plus/tac_plus.cfg`. If you wish to use a custom configuration, simply overwrite it in a derived image or use a volume mount.

By default logs will go to `/var/log/tac_plus` but this will be dependent on your configuration. The directory is there if you wish to use it.

Port 4949 is exposed as the server port.