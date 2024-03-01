FROM fedora AS BULID
ARG git_branch=main
ARG git_refspec=HEAD

LABEL org.snffio.wwiv.git_branch=${git_branch}
LABEL org.snffio.wwiv.git_refspec=${git_refspec}

 RUN dnf -y install dnf-plugins-core
 RUN dnf install -y git make ncurses-devel cmake gcc gcc-c++ vim unzip zip findutils iproute procps-ng hostname zlib-devel
#DEBIAN:
#RUN apt-get update && \
    # apt-get install -y sudo git make libncurses5-dev cmake gcc g++ vim unzip zip findutils iproute2 procps zlib1g-dev && \
    # apt-get upgrade && \
    # rm -rf /var/lib/apt/lists/*

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
RUN sh /docker/install-wwiv.sh /src/wwiv/build /opt/wwiv

LABEL SITUATION_LAYERIZATION="distro-switchstro"
FROM fedora  

COPY --from=BULID /opt/wwiv /opt/wwiv/
RUN find /opt/wwiv -type f -exec chmod +x {} \;

RUN dnf -y install dnf-plugins-core
RUN dnf install -y git make ncurses-devel cmake gcc gcc-c++ vim unzip zip findutils iproute procps-ng hostname zlib-devel
#ALPINE: 
#RUN apk add --no-cache git make ncurses-dev cmake gcc g++ vim unzip zip findutils iproute2 procps zlib-dev
#DEBIAN:
# RUN apt-get update && \
#     apt-get install -y sudo git make libncurses5-dev cmake gcc g++ vim unzip zip findutils iproute2 procps zlib1g-dev && \
#     apt-get upgrade && \
#     rm -rf /var/lib/apt/lists/*
#BUSYBOX
# RUN wget -O /bin/git https://busybox.net/downloads/binaries/1.33.0-defconfig-multiarch/busybox-x86_64 && chmod +x /bin/git && \
#     wget -O /bin/make https://busybox.net/downloads/binaries/1.33.0-defconfig-multiarch/busybox-x86_64 && chmod +x /bin/make && \
#     wget -O /bin/cmake https://busybox.net/downloads/binaries/1.33.0-defconfig-multiarch/busybox-x86_64 && chmod +x /bin/cmake && \
#     wget -O /bin/gcc https://busybox.net/downloads/binaries/1.33.0-defconfig-multiarch/busybox-x86_64 && chmod +x /bin/gcc && \
#     wget -O /bin/g++ https://busybox.net/downloads/binaries/1.33.0-defconfig-multiarch/busybox-x86_64 && chmod +x /bin/g++ && \
#     wget -O /bin/vim https://busybox.net/downloads/binaries/1.33.0-defconfig-multiarch/busybox-x86_64 && chmod +x /bin/vim && \
#     wget -O /bin/unzip https://busybox.net/downloads/binaries/1.33.0-defconfig-multiarch/busybox-x86_64 && chmod +x /bin/unzip && \
#     wget -O /bin/zip https://busybox.net/downloads/binaries/1.33.0-defconfig-multiarch/busybox-x86_64 && chmod +x /bin/zip && \
#     wget -O /bin/find https://busybox.net/downloads/binaries/1.33.0-defconfig-multiarch/busybox-x86_64 && chmod +x /bin/find && \
#     wget -O /bin/ip https://busybox.net/downloads/binaries/1.33.0-defconfig-multiarch/busybox-x86_64 && chmod +x /bin/ip && \
#     wget -O /bin/ps https://busybox.net/downloads/binaries/1.33.0-defconfig-multiarch/busybox-x86_64 && chmod +x /bin/ps && \
#     wget -O /bin/hostname https://busybox.net/downloads/binaries/1.33.0-defconfig-multiarch/busybox-x86_64 && chmod +x /bin/hostname && \
#     wget -O /bin/zlib https://busybox.net/downloads/binaries/1.33.0-defconfig-multiarch/busybox-x86_64 && chmod +x /bin/zlib

EXPOSE 2323

COPY entrypoint.sh /docker/entrypoint.sh
ENTRYPOINT ["sh", "/docker/entrypoint.sh"]
WORKDIR /srv/wwiv
VOLUME /srv/wwiv

#FEDORA:
RUN useradd -d /srv/wwiv wwiv
#ALPINE:
#RUN adduser -D -h /srv/wwiv wwiv
# #DEBIAN
# RUN adduser --disabled-password --home /srv/wwiv wwiv
CMD ["/opt/wwiv/wwivd", "--wwiv_user=wwiv"]
