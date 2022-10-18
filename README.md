# poetry-test

## Setup
1. On the root folder, build the docker image: `docker build --build-arg poetry_version=1.2.1 --tag "poetry/1.2.1" .`. During the build of this image it will try to generate the lock file and the error can be seen on the output.
2. After finishing, the container bash can be accessed by `docker run -ti poetry/1.2.1:latest bash` to run any command inside, such as:
  a. Generate poetry.lock `poetry lock --no-update -vvv`
  b. Try to install dependencies from poetry.lock: `poetry install --no-root -vvv`
