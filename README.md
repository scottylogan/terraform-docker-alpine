# Alpine Terraform Docker Image

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/scottylogan/terraform)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/scottylogan/terraform)
![Docker Pulls](https://img.shields.io/docker/pulls/scottylogan/terraform)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/scottylogan/terraform/latest)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/scottylogan/terraform/latest)

`Dockerfile` to build a Docker image for running Terraform

## Building the Image

To build the image with the latest version of Terraform:

```bash
% docker build -t terraform .
```

To build with a specific version of Terraform, use the TFVER build arg:

```bash
% docker build -t terraform --build-arg TFVER=0.12.24 .
```

## Pre-Built Image

You can also download the latest image from DockerHub

```bash
% docker pull scottylogan/terraform
```

## Running the Image

To run the image "standalone":

```bash
% docker run -h terraform -it terraform
terraform:~$ terraform version
Terraform v0.12.26
terraform:~$ logout
%
```

The `terraform` user's home directory is a volume, so you can mount a local path onto it:

```bash
% ls
Dockerfile   README.md
% docker run -h terraform -v $PWD:/home/terraform -it terraform
terraform:~$ ls
Dockerfile   README.md
...
```

You can mount your own home directory, and the image will use your `bash` configuration, and have access to your `~/.ssh/` directory (which allows git in the container to use your SSH keys when needed). For example, on my Mac:

```bash
scotty[~]% docker run -h terraform -v $HOME:/home/terraform -it terraform
terraform[~]% ls
Applications/ Documents/    Library/      Music/        Public/       share/
Desktop/      Dropbox/      Movies/       Pictures/     bin/          src/
```

(Your `bash` configuration might need some updates to work on Alpine)

