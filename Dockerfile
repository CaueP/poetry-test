FROM python:3.7-slim

# Argument to build a docker image with a defined poetry version, use the following command to build it
# docker build --build-arg poetry_version=1.2.1 --tag "poetry/1.2.1" .
ARG poetry_version

# Prepare environment
RUN apt-get update  &&\
    apt-get install -y -qq \
        build-essential python-dev curl git-core libgdal-dev \
        libgeos-c1v5 libffi-dev libpq-dev libproj-dev libreadline-dev \
        libxml2-dev libxml2 libxmlsec1 libxmlsec1-dev libxmlsec1-openssl \
        libxslt1-dev libxslt1.1 locales \
        python3-dev python3-setuptools software-properties-common \
        wget automake autoconf unzip tzdata swig \
        libgtest-dev libgflags-dev libgoogle-glog-dev libssl-dev cmake gettext && \
    add-apt-repository 'deb http://ftp.de.debian.org/debian sid main' && \
    apt-get update && \
    apt-get install -y -qq \
        watchman

# Print pip and setuptools versions
RUN pip --version; pip show setuptools

# Install dependencies
COPY . /opt/app
WORKDIR /opt/app

# Install and config poetry
COPY pyproject.toml ./
ENV POETRY_HOME="/opt/poetry"
ENV POETRY_VERSION=$poetry_version
ENV PATH="$POETRY_HOME/bin:$PATH"

RUN echo "Installing poetry version ${POETRY_VERSION}...";\
    curl -sSL https://install.python-poetry.org | python3 - ;\
    poetry config virtualenvs.create false 

# Tries to generate lock file and install it for a quick test
# Ignores any errors by using `exit 0` command at the end to still create the image
RUN poetry lock --no-update -vvv; poetry install --no-root -vvv; pip --version && pip show setuptools; exit 0