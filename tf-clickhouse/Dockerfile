FROM ubuntu:24.04

RUN apt -y update \
    && apt -y upgrade \
    && apt -y install curl wget gpg unzip

RUN curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | \
    bash -s -- -a

ARG TERRAFORM_VERSION=1.4.6
RUN curl -sL https://hashicorp-releases.yandexcloud.net/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && install -o root -g root -m 0755 terraform /usr/local/bin/terraform \
    && rm -rf terraform terraform.zip

COPY terraformrc root/.terraformrc