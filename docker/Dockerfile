ARG IMAGE_ID

FROM ${IMAGE_ID}:latest

USER root

# Install dotfiles
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -yqq install git
RUN git clone https://github.com/cjhelms/dotfiles.git ~/.dotfiles

# Run bootstrap script
RUN bash ~/.dotfiles/bootstrap.sh

CMD ["/bin/bash"]
