# My wedding website

[![Build Status](https://travis-ci.com/ilcardella/wedding-site.svg?branch=master)](https://travis-ci.com/ilcardella/wedding-site)

This repo contains my wedding website generated with Hugo and deployed on a private
server with TravisCI.

The `docker-compose.yml` contains 3 services:
- hugo-builder: generate the website html file in the `public` folder
- hugo-server: serves the generated website using the hugo built-in server (for development purposes)
- nginx-server: serves the generated website in the deployment environment

Travis supports encryption of SSH keys and environment variables:
- `deploy_rsa.enc` contains the encrypted SSH keys to deploy on the server
- `.travis.yml` contains a section with encrypted environment variables
  - These variables are unencrypted during the CI build and echoed in the `.env` file.
  - The `.env` is deployed on the server
  - The file is sourced automatically by `docker` when running `docker-compose up ...`
