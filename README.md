# poetry-test

## Setup
1. On the root folder, build the docker image for both versions: 
  a. 1.2.1: `docker build --build-arg poetry_version=1.2.1 --tag "poetry/1.2.1" .`. During the build of this image, it will try to install the dependencies and fail.
  b: 1.1.15: `docker build --build-arg poetry_version=1.1.15 --tag "poetry/1.1.15" .`. During the build of this image, you can see that the installation is succesfull.
3. After finishing, the container bash can be accessed by to run any command inside with:
  1. 1.2.1: `docker run -ti poetry/1.2.1:latest bash` 
  b. 1.1.15: `docker run -ti poetry/1.1.15:latest bash` 

## Testing on containers
1. Generate poetry.lock: `poetry lock --no-update -vvv`
2. Try to install dependencies from poetry.lock: `poetry install --no-root -vvv`, that fails on version 1.2.1
3. Install dependencies with old installer: `poetry config experimental.new-installer false && poetry install --no-root -vvv` that should work on version 1.2.1
