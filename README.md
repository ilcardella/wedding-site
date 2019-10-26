# My wedding website

[![Build Status](https://travis-ci.com/ilcardella/wedding-site.svg?branch=master)](https://travis-ci.com/ilcardella/wedding-site)

This repo contains my wedding website generated with Hugo and deployed on a private
server with TravisCI.

The `docker-compose.yml` contains 3 services:
- hugo-builder: generate the website html file in the `public` folder
- hugo-server: serves the generated website using the hugo built-in server (for development purposes)
- nginx-server: serves the generated website in the deployment environment

## Encrypted variables

I used this [article](https://blog.martignoni.net/2019/03/deploy-your-hugo-site/#fnref:2) as a reference.

Travis supports encryption of SSH keys and environment variables:
- `deploy_rsa.enc` contains the encrypted SSH keys to deploy on the server
- `.travis.yml` contains a section with encrypted environment variables
  - These variables are unencrypted during the CI build and echoed in the `.env` file.
  - The `.env` is deployed on the server
  - The file is sourced automatically by `docker` when running `docker-compose up ...`

### Add environment variables

It is possible to add new encrypted environment variables in the `.travis.yml` with simple steps. To do that you need the Travis-CI Ruby client. I used a `ruby` Docker container to install the client and encrypt the variables:
- Pull the latest [Ruby Docker image](https://hub.docker.com/_/ruby/)
```
docker pull ruby:latest
```
- Run a Docker container from the `ruby` image, mounting the workspace folder
```
cd /path/to/repository
docker run --rm -it -v $PWD:/build ruby:latest bash
```
- Install the Travis-CI gem:
```
gem install travis
```
- Login with your Travis-CI credentials. If your account is linked to Github, use your Github credentials instead
```
travis login --pro
```
- Encrypt and add a new environment variable
```
travis encrypt VARIABLE_NAME=value --add --pro
```
