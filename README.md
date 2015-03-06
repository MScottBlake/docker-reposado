# docker-reposado

A Docker container for running [Reposado](https://github.com/wdas/reposado).


# Environment Variables

* `DOCKER_REPOSADO_INSTALL_PATH`
  * Base directory to install reposado.
  * Default: `/home/app/reposado`
* `DOCKER_REPOSADO_REPO_SYNC_INTERVAL`
  * Run `repo_sync` every X hours.
  * Default: `3`
* `DOCKER_REPOSADO_LOCALCATALOGURLBASE`
  * Reposado's LocalCatalogUrlBase variable.
  * No Default. Expected format `http://su.example.com`


# Usage Examples

## Example #1 - Basic

```bash
docker run --name reposado -d -p 8088:8088 mscottblake/reposado
```

## Example #2 - Download and host the updates

By default, `DOCKER_REPOSADO_LOCALCATALOGURLBASE` is empty, so the updates aren't really being downloaded, just their metadata. To host the updates on-site, you need to specify a value for this variable.

```bash
docker run \
  --name reposado \
  -d \
  -p 8088:8088 \
  -e DOCKER_REPOSADO_LOCALCATALOGURLBASE=http://su.example.com \
  mscottblake/reposado
```

## Example #3 - Changing the Sync frequency

This example will cause `repo_sync` to run every 12 hours.

```bash
docker run \
  --name reposado \
  -d \
  -p 8088:8088 \
  -e DOCKER_REPOSADO_REPO_SYNC_INTERVAL=12 \
  mscottblake/reposado
```

## Example #4 - Share a volume from the host

```bash
docker run \
  --name reposado \
  -d \
  -p 8088:8088 \
  -v /path/to/reposado:/data/reposado \
  -e DOCKER_REPOSADO_INSTALL_PATH=/data/reposado \
  mscottblake/reposado
```

## Example #5 - All available options

```bash
docker run \
  --name reposado \
  -d \
  -p 8088:8088 \
  -e DOCKER_REPOSADO_INSTALL_PATH=/reposado \
  -e DOCKER_REPOSADO_REPO_SYNC_INTERVAL=2 \
  -e DOCKER_REPOSADO_LOCALCATALOGURLBASE=http://123.123.123.123 \
  mscottblake/reposado
```

## Example #6 - Using a second "data-only" container

Instead of sharing a volume with the `-v` flag, you can utilize a data-only container to hold relevant files.

```bash
docker run \
  --name reposadoData \
  --privileged \
  -d \
  -v /path/to/reposado/:/foo/reposado \
  busybox
```

Make sure to use the `--volumes-from` flag and make sure the `DOCKER_REPOSADO_INSTALL_PATH` environment variable is set to the same directory being used by `reposadoData`.

```bash
docker run \
  --name reposado \
  --volumes-from reposadoData \
  -d \
  -p 8088:8088 \
  -e DOCKER_REPOSADO_INSTALL_PATH=/foo/reposado \
  mscottblake/reposado
```
