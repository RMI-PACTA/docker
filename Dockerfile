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
       build-essential \
       r-base \
       texlive-luatex \
       libcurl4-openssl-dev \
       libxml2-dev \
       zlib1g-dev \
       libssl-dev \
       libpng-dev \
       libjpeg-dev \
       texlive \
       texlive-latex-extra && \
    apt-get clean

RUN echo "install.packages(c('countrycode', 'data.table', 'dplyr', 'devtools', 'extrafont', 'fst', 'ggmap', 'ggplot2', 'ggthemes', 'gridExtra', 'here', 'knitr', 'mapproj', 'matrixStats', 'lme4', 'RColorBrewer', 'readxl', 'renv', 'reshape2', 'rworldmap', 'scales', 'stringr', 'tibble', 'tidyr', 'tidyverse', 'writexl', 'zoo'), repos='https://cloud.r-project.org')" > /tmp/tmp_install.R && \
    Rscript --vanilla /tmp/tmp_install.R && \
    rm /tmp/tmp_install.R

# NOTE:
# Unclear on licensing problems when including this font in a repo.
# Since this should only be needed for the older tool.transitionmonitor.com
# PDF generator, remove it for now.
#
# ADD ClearSans.tar.gz /usr/share/texlive/texmf-dist
# RUN texhash

