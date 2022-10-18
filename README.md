# poetry-test

## Setup
1. On the root folder, build the docker image: `docker build --build-arg poetry_version=1.2.1 --tag "poetry/1.2.1" .`. During the build of this image it will try to generate the lock file and the error can be seen on the output.
2. After finishing, the container bash can be accessed by to run any command inside with `docker run -ti poetry/1.2.1:latest bash` 

## Testing
1. Generate poetry.lock: `poetry lock --no-update -vvv`
2. Try to install dependencies from poetry.lock: `poetry install --no-root -vvv`, that will fail
3. Install dependencies with old installer: `poetry config experimental.new-installer false && poetry install --no-root -vvv` that should work
