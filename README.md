# docker-reposado

A Docker container for running [Reposado](https://github.com/wdas/reposado).


# Creating a container

## Example #1 - Basic

```bash
docker run --name reposado -d -p 8088:8088 mscottblake/reposado
```

## Example #2 - Using port 80

```bash
docker run --name reposado -d -p 80:8088 mscottblake/reposado
```

## Example #3 - Custom preferences.plist

By default, `LocalCatalogURLBase` is empty, so the updates aren't really being downloaded, just their metadata. To host the updates on-site, you need to specify a value for this variable. Any optional keys (`AppleCatalogURLs`, `PreferredLocalizations`, etc.) need to be loaded in this manner as well.

```bash
docker run --name reposado -d -p 8088:8088 -v /path/to/host/preferences.plist:/reposado/code/preferences.plist mscottblake/reposado
```

## Example #4 - Using a second "data-only" container

A data-only container can be used to hold relevant persistent files.

```bash
docker run --name reposado-data -d --entrypoint /bin/echo mscottblake/reposado "Data-only container for Reposado."
```

Make sure to use the `--volumes-from` flag to use the `reposado-data` container you just created.

```bash
docker run --name reposado --volumes-from reposado-data -d -p 8088:8088 mscottblake/reposado
```


# Performing Reposado functionality

Refer to the Reposado [documentation](https://github.com/wdas/reposado/blob/master/docs/reference.txt) for more information on these utilities.

## `repo_sync`

```bash
docker exec reposado repo_sync
```

```bash
docker exec reposado repo_sync --help
```

## `repoutil`

```bash
docker exec reposado repoutil [options]
```

```bash
docker exec reposado repoutil --help
```
