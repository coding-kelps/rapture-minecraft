FROM docker.io/library/python:3.12.10-bookworm

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      curl \
      gnupg \
      lsb-release \
      software-properties-common \
      unzip \
      less \
      ca-certificates;

ENV TERRAFORM_VERSION=1.11.4-1

RUN set -eux; \
    curl -fsSL https://apt.releases.hashicorp.com/gpg \
      | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg; \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
      https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
      > /etc/apt/sources.list.d/hashicorp.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends terraform=${TERRAFORM_VERSION};

ENV AWSCLI_V2_VERSION=2.18.11

RUN set -eux; \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_V2_VERSION}.zip" -o "awscliv2.zip"; \
    unzip awscliv2.zip; \
    ./aws/install; \
    rm -rf aws awscliv2.zip;

ADD https://astral.sh/uv/0.8.2/install.sh /uv-installer.sh

RUN sh /uv-installer.sh && rm /uv-installer.sh

ENV PATH="/root/.local/bin/:$PATH"

WORKDIR /app

CMD ["bash"]
