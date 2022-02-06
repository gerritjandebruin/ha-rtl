docker run \
  --rm \
  --privileged \
  -v ~/.docker:/root/.docker \
  homeassistant/amd64-builder \
  --all \
  -t ha-rtl \
  -r https://github.com/gerritjandebruin/ha-rtl \
  -b master