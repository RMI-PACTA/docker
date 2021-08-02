FROM 2dii/system
MAINTAINER "Mauro Lepore" maurolepore@gmail.com

RUN apt-get install -y wget \
  && echo 'options(repos = c(CRAN = "https://packagemanager.rstudio.com/all/__linux__/bionic/latest"))' >> ~/.Rprofile \
  && echo 'options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version$platform, R.version$arch, R.version$os)))' >> ~/.Rprofile \
  && Rscript -e "source('https://raw.githubusercontent.com/2DegreesInvesting/docker/master/r-packages/install.R')" \
  && Rscript -e "tinytex::install_tinytex()" \
  && Rscript -e 'tinytex::tlmgr_install(pkgs = c("caption", "mathspec", "sectsty", "sourcesanspro", "wrapfig", "fancyhdr", "xcolor", "blindtext", "titlesec", "lipsum"))' \
  && echo ""
