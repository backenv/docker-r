FROM debian:testing

RUN apt-get update \
  && apt-get -yq --no-install-recommends install \
    jq \
    curl \
    gpg \
    dirmngr

RUN echo "deb https://cloud.r-project.org/bin/linux/debian testing" > /etc/apt/sources.list.d/r-cran.list \
  && apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'

RUN apt-get -t testing -yq install \
      r-base \
      libatlas3-base \
      libopenblas-base \
      libcurl4-openssl-dev \
      libcairo2-dev \
      libmariadb2 \
      libmariadb-dev \
      libnlopt-dev \
      libxml2-dev \
      xml2

# Install R packages
RUN install.r -r https://cloud.r-project.org/ \
      abind \
      ca \
      class \
      cluster \
      ggplot2 \
      graph \
      GPArotation \
      gridExtra \
      Hmisc \
      jsonlite \
      knitr \
      nloptr \
      psych \
      psych \
      RcmdrMisc \
      RMySQL \
      semPlot \
      svglite \
      vegan \
      yaml \

# Clean installation
 apt-get clean \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
  && rm -rf /var/lib/apt/lists/*

CMD R
