# Usage

The following steps will get you a running container according to your base image with Neovim fully
configured on top of it.

- Build your docker image as usual (e.g. 'docker build /path/to/Dockerfile -t my-build')
- Run: '/path/to/.dotfiles/docker_build.sh my-build'
- Run: '/path/to/.dotfiles/docker_run.sh my-build latest-dev'*

* Be sure to run this command from within the directory you want as your working directory

The last step will launch you into a running container with Neovim. You can attach additionally
consoles easily by running: 'docker exec -it my-build bash'

Note the 'my-build' tag is used just as an example. You may use whatever tag you like as set when
making the initial base build in the first step.
