FROM statwonk/shiny

MAINTAINER Christopher Peters "cpeter9@gmail.com"

RUN apt-get update && apt-get install -y \
    libssl-dev \
    libxml2-dev

RUN echo 'install.packages(c("ggplot2", "scales"), \
          repos="http://cran.us.r-project.org", \
          dependencies=TRUE)' > /tmp/packages.R \
    && Rscript /tmp/packages.R

RUN rm -rf /srv/shiny-server/*

CMD ["/usr/bin/shiny-server.sh"]
