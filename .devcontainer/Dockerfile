FROM docker.io/library/python:3.12.10-bookworm

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      curl \
      gnupg \
      lsb-release \
      software-properties-common \
      unzip \
      less;

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

ENV POETRY_VERSION=2.1.2 \
    POETRY_HOME="/opt/poetry"

ENV PATH="$POETRY_HOME/bin:$PATH"

RUN set -eux; \
    pip install --no-cache-dir --upgrade pip; \
    curl -sSL https://install.python-poetry.org | python3 - --version "$POETRY_VERSION"; \
    poetry self add poetry-plugin-shell;

WORKDIR /app

CMD ["bash"]
