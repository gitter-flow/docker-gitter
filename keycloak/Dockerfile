FROM quay.io/keycloak/keycloak:18.0.0

WORKDIR /opt/keycloak/bin
COPY realm.json /tmp/realm.json

RUN ./kc.sh import --file /tmp/realm.json


ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh, “-Dkeycloak.profile.feature.upload_scripts=enabled” ] 