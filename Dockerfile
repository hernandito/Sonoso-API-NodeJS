FROM lsiobase/alpine:3.5

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install build packages

RUN apk update

RUN apk add --no-cache --virtual=build-dependencies \
	curl \
	wget \
	mc \	
	tar \	
	screen \		
	zip \	
	python-dev \	
	tar

# install runtime packages
RUN apk add --no-cache \
	nodejs \
	openssl \
	python

# install kodi kontrol
RUN mkdir -p \
	/app



RUN npm install && \
 
 npm install \
	async \
	jsonrpc && \
	
	cd / && \
	npm install https://github.com/jishi/node-sonos-http-api && \


# cleanup
 apk del --purge \
	build-dependencies && \
 npm cache clean && \
 rm -rf \
	/tmp

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 5005
VOLUME /app




