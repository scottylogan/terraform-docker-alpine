FROM alpine:latest
ARG TFVER=
MAINTAINER swl@stanford.edu

# Add a local user
RUN adduser -h /home/terraform -g 'Terraform User' -s /bin/bash -D terraform

# Update package lists and outdated packages
RUN apk update && apk upgrade

# Add tools needed for Terraform, and something other than /bin/sh
RUN apk add bash curl git git-bash-completion groff jq ncurses python3 openssh-client unzip

# Upgrade pip (if needed) and install the AWS CLI
RUN pip3 install --upgrade pip && \
    pip3 install awscli

# Install Terraform in /usr/local/bin
WORKDIR /usr/local/bin

# Download and install the latest version of terraform, or the version
# specified in TFVER
RUN if [ -z "${TFVER}" ]; then \
       export TFVER=`git ls-remote --tags git://github.com/hashicorp/terraform |\
       egrep '^.*/tags/v[0-9]+\.[0-9]+\.[0-9]+$$' |\
       sed 's,^.*/tags/v,,' |\
       sort -g -t. -k 1,1n -k 2,2n -k 3,3n |\
       tail -n 1`; \
    fi; \
    echo Build with Terraform ${TFVER} && \
    curl -so /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TFVER}/terraform_${TFVER}_linux_amd64.zip && \
    unzip /tmp/terraform.zip && \
    rm -f /tmp/terraform.zip

# Default to running as the terraform user, and start in their home directory
WORKDIR /home/terraform
USER terraform

# Mark the terraform home directory as a volume so external data can be mounted
VOLUME /home/terraform

# Default to running bash
CMD [ "/bin/bash", "-l" ]

