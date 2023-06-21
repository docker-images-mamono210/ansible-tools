FROM python:3-slim
ARG USERNAME
ARG GIT_USER_NAME
ARG GIT_USER_EMAIL

# Install required packages
RUN apt-get update \
  && mkdir -p /usr/share/man/man1 \
  && apt-get install -y \
    apt apt-transport-https ca-certificates curl git gnupg locales openssh-client sudo unzip vim

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

# Install gcloud CLI
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
  && apt-get update && apt-get install google-cloud-cli

# Configure Git
RUN sudo -u ${USERNAME} git config --global user.name "${GIT_USER_NAME}" \
  && sudo -u ${USERNAME} git config --global user.email "${GIT_USER_EMAIL}" \
  && echo '\n# Unable git completion features.' >> /home/${USERNAME}/.bashrc \
  && echo 'source /usr/share/bash-completion/completions/git' >> /home/${USERNAME}/.bashrc

USER ${USERNAME}
ENV PATH /home/${USERNAME}/.local/bin:/home/${USERNAME}/bin:${PATH}

CMD ["/bin/sh"]
