FROM mcr.microsoft.com/playwright:v1.46.1-jammy AS container

ARG GO_VERSION=1.23.0

ENV GOTOOLCHAIN local
RUN apt-get update && apt-get install -y build-essential && \
    wget -O /tmp/go.tar.gz https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    rm -rf /usr/local/go && \
    tar -C /usr/local -xzf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go

RUN go install github.com/playwright-community/playwright-go/cmd/playwright@latest

RUN /root/go/bin/playwright install --with-deps
