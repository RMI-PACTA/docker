FROM 2dii/system
MAINTAINER "Mauro Lepore" maurolepore@gmail.com

# This repository has binaries for Linux
RUN apt-get install -y wget \
  && echo 'options(repos = c(CRAN = "https://packagemanager.rstudio.com/all/__linux__/bionic/latest"))' >> ~/.Rprofile \
  && echo 'options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version$platform, R.version$arch, R.version$os)))' >> ~/.Rprofile \
    # update-dockerfile-packages-start
    && Rscript -e "install.packages( \
             c( \
               'assertthat', \
               'bookdown', \
               'config', \
               'conflicted', \
               'countrycode', \
               'crayon', \
               'data.table', \
               'devtools', \
               'dplyr', \
               'forcats', \
               'fs', \
               'fst', \
               'ggplot2', \
               'glue', \
               'highcharter', \
               'here', \
               'janitor', \
               'jsonlite', \
               'knitr', \
               'purrr', \
               'readr', \
               'readxl', \
               'renv', \
               'reshape2', \
               'rlang', \
               'rmarkdown', \
               'rstudioapi', \
               'scales', \
               'stringr', \
               'testthat', \
               'tibble', \
               'tidyr', \
               'tidyselect', \
               'usethis', \
               'withr', \
               'writexl', \
               'zoo' \
             ) \
           )" \
    # update-dockerfile-packages-end
    && Rscript -e "tinytex::install_tinytex()" \
    && Rscript -e 'tinytex::tlmgr_install(pkgs = c("caption", "mathspec", "sectsty", "sourcesanspro", "wrapfig", "fancyhdr", "xcolor", "blindtext", "titlesec", "lipsum"))' \
    && echo ""
