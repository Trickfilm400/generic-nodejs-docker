# generic-nodejs-docker
A nodejs docker image to run a project without building a new docker everytime

You can use this docker to run every lightweight node.js program.

The docker will install the dependencies on startup and execute the  `npm start`  script of your package.json afterwards.

# Usage
Download the docker image from [Docker-Hub](https://hub.docker.com/r/n404/generic-nodejs): `docker pull n404/generic-nodejs`


## local folder

The most simple usage:  
`docker run --rm -v /root/project/:/app n404/generic-nodejs`

### Preparations
Put your NodeJS project on the machine your docker will run on.  
In this example, I will use the “/root/project” directory for our project.

Ensure the package.json file is correctly copied to “/root/project/package.json”.

This file needs a NPM run script:

```json
{
  "name": "your-project",
  "version": "0.0.1",
  "description": "your-project-description",
  "main": "./index.js",
  "scripts": {
    "start": "node index.js"
  }
}
```

To run the docker container use:  `docker run -v /root/project:/app n404/generic-nodejs`

You are mounting your NodeJS project folder inside the docker.  
If you want to, you can pass additional docker run parameters as you need to the run command, but ensure you pass the folder to the docker container.

## Zip URL from GitHub

There are some environment variables to configure the behavior of the container:

| ENV | default | description
---------|-------------|-------------------
| CACHE | `true` | If false, the ZIP-File will be downloaded at every container start
| URL | "" | The zip URL  _(see below for more information)_
| BUILD_TYPESCRIPT | `false` | if `npm run build` should be executed for compiling for example typescript

### Usage

`docker run -e URL=https://github.com/Trickfilm400/vantage-node/archive/refs/heads/master.zip -e BUILD_TYPESCRIPT=true -e CUSTOM_VARIABLE=false -e CACHE=true n404/generic-nodejs:test`

(replace the environment variables with your values or remove them from the command, only the  `URL`  value is required)

### **IMPORTANT NOTE: zip file**

the zip file must include a subfolder like a zip folder from GitHub  
(folder.zip → folder/subfolder/project [package.json etc.])

I was too lazy to make an autodetect thing for this.

© Trickfilm400 14.08.2021 - 27.08.2021 - 29.07.2022 - 30.10.2022