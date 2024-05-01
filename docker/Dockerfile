ARG IMAGE_ID

FROM ${IMAGE_ID}:latest

USER root

# Install dotfiles
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y -q install git
RUN git clone https://github.com/cjhelms/dotfiles.git ~/.dotfiles

# Do not care about externally managed
ENV PIP_BREAK_SYSTEM_PACKAGES 1

# Run bootstrap script
RUN bash ~/.dotfiles/bootstrap.sh

CMD ["/bin/bash"]
