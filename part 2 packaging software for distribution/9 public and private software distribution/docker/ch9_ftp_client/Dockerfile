FROM gliderlabs/alpine:3.1
MAINTAINER Jeff Nickoloff "jeff@allingeek.com"
LABEL dia_excercise=ch9_ftp_client
RUN apk-install lftp
VOLUME ["/data"]
WORKDIR /data
# if there is ENTRYPOINT, CMD is not the exection of command, but pass the content to ENTRYPOINT as default parameter, e.g. <ENTRYPOINT> "<CMD>"
# below is: lftp ftp_server, which is connect to ftp_server
# ftp-server is the container name
ENTRYPOINT ["lftp"]
CMD ["ftp_server"]
