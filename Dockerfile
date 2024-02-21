FROM fedora AS BULID
ARG git_branch=main
ARG git_refspec=HEAD

LABEL org.snffio.wwiv.git_branch=${git_branch}
LABEL org.snffio.wwiv.git_refspec=${git_refspec}

# RUN apt update
# RUN apt install -y \
# 	git \
# 	make \
# 	libncurses5-dev \
# 	cmake \
# 	gcc \
# 	g++ \
# 	vim \
# 	unzip \
# 	zip \
# 	findutils \
# 	iproute2 \
# 	procps \
# 	hostname \
# 	zlib1g-dev \
# 	build-essential

RUN dnf -y install dnf-plugins-core
RUN dnf install -y \
	git \
	make \
	ncurses-devel \
	cmake \
	gcc \
	gcc-c++ \
	vim \
	unzip \
	zip \
	findutils \
	iproute \
	procps-ng \
	hostname \
	zlib-devel 

RUN mkdir /opt/wwiv

RUN mkdir /docker
COPY clone-wwiv.sh /docker/clone-wwiv.sh
RUN sh /docker/clone-wwiv.sh /src ${git_branch} ${git_refspec}

COPY patch-wwiv.sh /docker/patch-wwiv.sh
COPY patches /docker/patches
# RUN sh /docker/patch-wwiv.sh /src/wwiv /docker/patches

COPY build-wwiv.sh /docker/build-wwiv.sh
RUN sh /docker/build-wwiv.sh /src/wwiv

WORKDIR /opt/wwiv
COPY install-wwiv.sh /docker/install-wwiv.sh
RUN sh /docker/install-wwiv.sh /src/wwiv/_build /opt/wwiv
RUN [ "/opt/wwiv/wwivconfig", "--initialize" ]

LABEL SITUATION_LAYERIZATION="distro-switchstro"
FROM fedora  

COPY --from=BULID /opt/wwiv /opt/wwiv/

EXPOSE 2323
EXPOSE 22

#RUN dnf -y install dnf-plugins-core
RUN dnf install -y \
	zip \
	unzip \
	zlib-devel \ 
	ncurses-devel 

	# findutils \
	# iproute \
	# procps-ng \
	# hostname \
	# gcc \
	# gcc-c++ \


WORKDIR /opt/wwiv
RUN adduser -D -h /opt/wwiv wwiv
CMD [ "/opt/wwiv/wwivd" ]