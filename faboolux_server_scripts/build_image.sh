git_password=XXXXXXXXX
TAG=1.0.0

cd ../
yes|sudo docker builder prune --all

app1='{"url": "https://IdeenkreiseTech:'"$git_password"'@github.com/IdeenkreiseTech/faboolux_webapp.git","branch": "main"}'
export APPS_JSON='['"$app1"']'
export APPS_JSON_BASE64=$(echo ${APPS_JSON} | base64 -w 0)

sudo docker build \
  --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe \
  --build-arg=FRAPPE_BRANCH=v14.61.0 \
  --build-arg=PYTHON_VERSION=3.10.12 \
  --build-arg=NODE_VERSION=16.20.1 \
  --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
  --tag=ghcr.io/ideenkreisetech/faboolux_webapp/faboolux_webapp:$TAG \
  --file=images/custom/Containerfile .

sudo docker login ghcr.io -u IdeenkreiseTech -p $git_password

sudo docker push ghcr.io/ideenkreisetech/faboolux_webapp/faboolux_webapp:$TAG