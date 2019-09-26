FROM debian:10

RUN apt update \
  && apt -yq install \
    jq \
    curl \
    gpg \
    dirmngr \
    aptitude

RUN echo "deb http://cloud.r-project.org/bin/linux/debian buster-cran35/" > /etc/apt/sources.list.d/r-cran.list \
  && apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' \
  && apt update

RUN aptitude -yq install \
    r-base
#    r-base-core

RUN aptitude -yq install \
      libnlopt-dev \
      libcairo2-dev \
      libxml2-dev \
      xml2

#      libmariadb2 \
#      libmariadb-dev \
#      libatlas3-base \
#      libopenblas-base \
#      libcurl4-openssl-dev \

# Install R packages
## Other options
#      GPArotation \

RUN R -e "cat('Starting package installation'); for (i in c( \
    'abind', \
    'ca', \
    'class', \
    'cluster', \
    'ggplot2', \
    'Hmisc', \
    'jsonlite', \
    'knitr', \
    'nloptr', \
    'psych', \
    'qgraph', \
    'RcmdrMisc', \
    'RMySQL', \
    'semPlot', \
    'svglite', \
    'vegan', \
    'yaml') \
    ) {if (length(grep(i,rownames(installed.packages()))) == 0L) install.packages(i)}"

# Clean installation
RUN apt clean && aptitude autoclean \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
  && rm -rf /var/lib/apt/lists/*

# Create User

# Set Workdir

# Start CMD
CMD R
