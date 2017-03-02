FROM lsiobase/alpine:3.5

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install build packages



# copy local files
COPY root/ /

# ports and volumes
EXPOSE 5005
VOLUME /app

