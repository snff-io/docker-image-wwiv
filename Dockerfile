FROM ubuntu
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y \
	git \
	libncurses5-dev \
	cmake \
	gcc \
	g++ \
	vim
RUN mkdir /docker
COPY clone-wwiv.sh /docker/clone-wwiv.sh
RUN sh /docker/clone-wwiv.sh /src

COPY build-wwiv.sh /docker/build-wwiv.sh
RUN sh /docker/build-wwiv.sh /src/wwiv

COPY install-wwiv.sh /docker/install-wwiv.sh
RUN sh /docker/install-wwiv.sh /src/wwiv /opt/wwiv

COPY entrypoint.sh /docker/entrypoint.sh
ENTRYPOINT ["sh", "/docker/entrypoint.sh"]
WORKDIR /srv/wwiv
VOLUME /srv/wwiv

RUN useradd -d /srv/wwiv wwiv
