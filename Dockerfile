FROM node:6-alpine

WORKDIR /app

RUN apk update && \
  apk --no-cache add tar curl mc git nano screen && \
  curl -L https://github.com/jishi/node-sonos-http-api/archive/master.tar.gz | tar xz --strip-components=1 -C /app && \
  mkdir cache && \
#  ln -s settings/settings.json && \
#  chown -R node:node static cache && \
  npm install --production && \
  rm -rf /tmp/* /root/.npm

RUN mkdir -p /app/cache && \
mkdir -p /app/static && \
mkdir -p /app/static/clips && \
mkdir -p /app/presets && \
mkdir -p /app/settings

ADD settings.json /app/settings/settings.json
ADD presets.json /app/presets/presets.json
ADD start.sh /app/start.sh 

RUN chmod -v +x /app/start.sh
 
EXPOSE 5005
VOLUME /app 

#USER node

HEALTHCHECK --interval=3m --timeout=2s \
  CMD curl -LSs http://localhost:5005 || exit 1

#CMD npm start
screen -dm -S mySonosAPI /app/start.sh


