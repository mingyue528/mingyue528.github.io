FROM ubuntu:18.04

COPY files/id_rsa /root/.ssh/id_rsa
COPY files/id_rsa.pub /root/.ssh/id_rsa.pub
COPY scripts/init.sh /root/init.sh

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
    apt-get install -y vim && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash && \
    apt-get install -y nodejs=12.18.3-1nodesource1 && \
    chmod +x /root/init.sh

ENTRYPOINT /root/init.sh
