FROM alpine

LABEL MAINTAINER="flyingtiantian <tianxuejin2014@hotmail.com>"

ENV TIMEZONE Asia/Shanghai
ENV DOWNLOAD_PATH "/download"

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk
RUN apk add glibc-2.32-r0.apk
RUN rm glibc-2.32-r0.apk

RUN wget http://175.6.228.5:3054/rrshareweb_linux_2.20.tar.gz
RUN tar zxvf rrshareweb_linux_2.20.tar.gz
RUN rm rrshareweb_linux_2.20.tar.gz

RUN echo -e "{\n    \"port\" : 3001,\n    \"logpath\" : \"\",\n    \"logqueit\" : false,\n    \"loglevel\" : 1,\n    \"logpersistday\" : 2,\n    \"defaultsavepath\" : \"$DOWNLOAD_PATH\"\n}" > /rrshareweb/conf/rrshare.json

WORKDIR /
VOLUME $DOWNLOAD_PATH
EXPOSE 3001

ENTRYPOINT ["/bin/sh"]
CMD ["-c", "/rrshareweb/rrshareweb"]
