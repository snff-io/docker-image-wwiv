FROM fedora
RUN dnf install -y \
	git \
	make \
	ncurses-devel \
	cmake \
	gcc \
	gcc-c++ \
	vim \
	unzip \
	findutils \
	iproute \
	procps-ng \
	hostname

RUN mkdir /docker
COPY clone-wwiv.sh /docker/clone-wwiv.sh
RUN sh /docker/clone-wwiv.sh /src

COPY patch-wwiv.sh /docker/patch-wwiv.sh
COPY patches /docker/patches
RUN sh /docker/patch-wwiv.sh /src/wwiv /docker/patches

COPY build-wwiv.sh /docker/build-wwiv.sh
RUN sh /docker/build-wwiv.sh /src/wwiv

COPY install-wwiv.sh /docker/install-wwiv.sh
RUN sh /docker/install-wwiv.sh /src/wwiv /opt/wwiv

COPY entrypoint.sh /docker/entrypoint.sh
ENTRYPOINT ["sh", "/docker/entrypoint.sh"]
WORKDIR /srv/wwiv
VOLUME /srv/wwiv

RUN useradd -d /srv/wwiv wwiv
CMD ["/opt/wwiv/wwivd", "--wwiv_user=wwiv"]
