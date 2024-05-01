ARG IMAGE_ID

FROM ${IMAGE_ID}:latest

USER root

# Try to avoid UI
ARG DEBIAN_FRONTEND=noninteractive

# Setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# Install dotfiles
RUN apt-get update && apt-get -y -q install git
RUN git clone https://github.com/cjhelms/dotfiles.git ~/.dotfiles

# Do not care about externally managed
ENV PIP_BREAK_SYSTEM_PACKAGES 1

# Run bootstrap script
RUN bash ~/.dotfiles/bootstrap.sh

CMD ["/bin/bash"]
