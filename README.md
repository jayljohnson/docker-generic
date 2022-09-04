Generic docker project to launch a minimal environment for projects and experiments

## Installation
The examples assume that your new project name is `my-project`.  You can use any name that makes sense for your project by replacing `my-project` with the actual name.

### Initialize a new project by cloning the main repo

Before starting:
1. Docker should be running
2. If any containers are running, shut them down.  To find running containers, run the command: `docker container ps`

Create a new base directory for your new project.  Then clone the git project files into that directory, build the containers, and start them:
```
mkdir my-project
cd my-project
git clone https://github.com/jayljohnson/docker-generic.git .
make build
make up
make version
```
After running `make version`, you should see: `Python Version:
Python 3.10.6`

If permissions errors happen during `make build`, run this to add the current user to the docker group and retry:
```
make permissions -i
```

### Setup a new github repo to track changes
To track changes in your own repo, it's a good practice to name your local project and github repo the same.  To do this, break the references to the cloned github repo and initialize a new repo:
```
cd my-project
rm -rf .git
git init
```

The first time you want to push a change to a new remote repo:
1. Create a new repo with your git hosting service, such as github, gitlab
2. Get the repo url
3. Run `git push` and follow the prompts to point your local branch to the new remote repo branch

## Containers included:
* application: generic linux image with python3
* db: an empty postgres database

## Using the makefile
The makefile includes commonly used commands including:
* start and stop the docker containers
* access the linux cli
* run a python shell
* connect to the postgres container's database via psql

