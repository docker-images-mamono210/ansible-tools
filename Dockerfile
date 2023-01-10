FROM python:3.9-slim
ARG USERNAME

# Install required packages
RUN apt-get update \
  && mkdir -p /usr/share/man/man1 \
  && apt-get install -y \
    apt ca-certificates curl git locales openssh-client sudo unzip

# Add User
RUN groupadd --gid 1002 ${USERNAME} \
  && useradd --uid 1001 --gid ${USERNAME} --shell /bin/bash --create-home ${USERNAME} \
  && echo "%${USERNAME}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${USERNAME}

# Install Docker
RUN sudo -u ${USERNAME} pip3 install --user docker

# Install Molecule
RUN sudo -u ${USERNAME} pip3 install --user ansible \
                                         boto \
                                         boto3 \
                                         molecule \
                                         molecule-ec2 \
                                         molecule-docker \
                                         ansible-lint

USER ${USERNAME}
ENV PATH /home/${USERNAME}/.local/bin:/home/${USERNAME}/bin:${PATH}

CMD ["/bin/sh"]
