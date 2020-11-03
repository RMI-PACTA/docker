FROM ubuntu:18.04

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -y install gpg ca-certificates && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    echo 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y install tzdata && \
    ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get -y install \
       git \
       build-essential \
       r-base \
       texlive-luatex \
       libcurl4-openssl-dev \
       libxml2-dev \
       zlib1g-dev \
       libssl-dev \
       libpng-dev \
       libjpeg-dev \
       libssh2-1-dev \
       pandoc \
       texlive \
       texlive-latex-extra && \
    apt-get clean

#
