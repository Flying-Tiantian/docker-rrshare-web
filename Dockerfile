FROM alpine

LABEL MAINTAINER="flyingtiantian <tianxuejin2014@hotmail.com>"

ENV DOWNLOAD_PATH "/download"

RUN wget http://175.6.228.5:3054/rrshareweb_linux_2.20.tar.gz
RUN tar zxvf rrshareweb_linux_2.20.tar.gz
RUN rm rrshareweb_linux_2.20.tar.gz

RUN echo -e "{
    \"port\" : 3001,
    \"logpath\" : \"\",
    \"logqueit\" : false,
    \"loglevel\" : 1,
    \"logpersistday\" : 2,
    \"defaultsavepath\" : \"$DOWNLOAD_PATH\"
}" > /rrshareweb/conf/rrshare.json

WORKDIR /
VOLUME [$DOWNLOAD_PATH]
EXPOSE 3001

CMD ["sh", "-c", "/rrshareweb/rrshareweb"]
