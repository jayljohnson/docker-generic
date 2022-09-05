Generic docker containers to launch a minimal environment for new projects and experiments.

This is intended to be used as a template and uses makefiles to simplify interaction with the docker containers.

### Containers Included
* application: generic linux container with python3
* db: an empty postgres database

## Installation
The examples assume that your new project name is `my-project`.  You can use any name that makes sense for your project by replacing `my-project` in the commands that follow with the actual project name.

### Initialize a new project

Before starting:
1. Docker should be running
2. If any containers are running, shut them down.  To find running containers, run the command: `docker container ps`  (It may work without doing this, but network errors are possible because of port bindings in other containers)

Run the next scripts to create a new base directory for your new project.  Then clone the git project files into that directory, build the containers, and start them to make sure everything is working.
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

To test the postgres database connection, run the following:
```
make psql
create table test as (select 1);
\dt
select * from test;
drop table test;
exit
```

Shut down the containers
```
make down
```

### Setup a new github repo to track changes
If you wish to, rename the project to something different than `docker-generic` and save it in our own repo.  Replace `my-project` with the actual project name you used in the previous steps.
```
cd my-project
rm -rf .git
git init
```

Then, the first time you want to push a change to a new remote repo:
1. Create a new repo with your git hosting service, such as github, gitlab.  It's a good practice to keep your base directory name and repo name aligned.
2. Get the repo url
3. Run `git push` and follow the prompts to point your local branch to the new remote repo branch

## Using the makefile
The makefile assumes that the current working directory is the project base directory.  This allows for the docker commands to find the correct container names.  Usually you'll need to `cd` into the base directory before using the makefile commands.

Docker uses the base directory as a container name prefix.  For purposes of this example, a project installed at `~/workspace/docker-generic` has the base directory named `docker-generic`

The makefile includes commonly used commands including:
* start and stop the docker containers
* access the linux cli
* run a python shell
* connect to the postgres container's database via psql

