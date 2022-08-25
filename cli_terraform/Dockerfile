FROM ubuntu:20.04
LABEL maintainer="eric.mugerwa@gigify.africa"
LABEL version="0.1"
LABEL description="This is custom Docker Image for GIG Tech Cli and Terraform plugin."
ARG DEBIAN_FRONTEND=noninteractive
ARG ARG_JWT
ARG ARG_VCO_API_URL
ENV JWT=$ARG_JWT
ENV VCO_API_URL=$ARG_VCO_API_URL
RUN apt update
RUN apt upgrade -y
COPY install-packages /root/home/install-packages
RUN apt install -y $(cat /root/home/install-packages)
RUN pip install requests jinja2
RUN curl -O https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip
RUN unzip terraform_0.14.7_linux_amd64.zip -d /usr/bin/
COPY tf_cli.sh /root/home/tf_cli.sh
RUN chmod +x /root/home/tf_cli.sh
RUN echo "source /etc/profile.d/bash_completion.sh" >> ~/.bashrc
RUN mkdir /etc/bash_completion.d/
RUN ["/bin/bash", "-c", "source /root/home/tf_cli.sh"]
RUN mkdir /root/.ssh/
RUN touch /root/.ssh/known_hosts