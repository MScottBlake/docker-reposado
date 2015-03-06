#!/bin/bash

repo_sync="python ${DOCKER_REPOSADO_INSTALL_PATH}/code/repo_sync"
pref_file="${DOCKER_REPOSADO_INSTALL_PATH}/code/preferences.plist"
nginx_conf="/etc/nginx/sites-enabled/reposado.conf"

# Move into defined directory
mv reposado "${DOCKER_REPOSADO_INSTALL_PATH}"

# Perform dummy text replacements
sed -i s#DOCKER_REPOSADO_INSTALL_PATH#${DOCKER_REPOSADO_INSTALL_PATH}# "${pref_file}"
sed -i s#DOCKER_REPOSADO_INSTALL_PATH#${DOCKER_REPOSADO_INSTALL_PATH}# "${nginx_conf}"

# Only replace LocalCatalogUrlBase if the variable is not empty
if [ ! -z "${DOCKER_REPOSADO_LOCALCATALOGURLBASE}" ]; then
  sed -i "s#<string></string>#<string>${DOCKER_REPOSADO_LOCALCATALOGURLBASE}:8088</string>#" "${pref_file}"
fi

# Create crontab to sync every X hours
echo "0 */${DOCKER_REPOSADO_REPO_SYNC_INTERVAL} * * * ${repo_sync}" | crontab -

# Perform initial sync
${repo_sync} &
