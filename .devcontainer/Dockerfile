FROM docker.io/library/python:3.14.5-trixie

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      curl \
      gnupg \
      lsb-release \
      unzip \
      less \
      direnv \
      ca-certificates;

# Direnv hook
RUN echo 'eval "$(direnv hook bash)"' >> /root/.bashrc

ENV TERRAFORM_VERSION=1.15.5-1

RUN set -eux; \
    curl -fsSL https://apt.releases.hashicorp.com/gpg \
      | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg; \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
      https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
      > /etc/apt/sources.list.d/hashicorp.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends terraform=${TERRAFORM_VERSION};

ENV AWSCLI_V2_VERSION=2.34.58

RUN set -eux; \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m)-${AWSCLI_V2_VERSION}.zip" -o "awscliv2.zip"; \
    unzip awscliv2.zip; \
    ./aws/install; \
    rm -rf aws awscliv2.zip;

ADD https://astral.sh/uv/0.11.18/install.sh /uv-installer.sh

RUN sh /uv-installer.sh && rm /uv-installer.sh

ENV PATH="/root/.local/bin/:$PATH"

WORKDIR /app

CMD ["bash"]
