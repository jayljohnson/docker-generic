Generic docker containers to launch a minimal environment for new python projects.  This project is intended to be used as a template from which to start other projects or for one-off python analysis or testing work.

Makefile commands simplify many common interactions with the docker containers.

### Containers Included
* application: generic linux container with python3, pytest, and code coverage
* db: an empty postgres database

## Tutorial
Use any name that makes sense for your project by replacing `my-project` in the commands below with the actual project name.  Or, start with the default name and change it later.

For users experienced with git and cli basics, it should take less than 10 minutes to have a fully functioning environment up and running.

### Initialize a new project
> **_Prerequisites:_**
1. Docker should be installed and running
2. If other containers are running, it's a good idea to shut them down.  To find running containers, run the command: `docker container ps`.  To bring them down, run `docker-compose down`          
    1. Note: The tutorial may work without doing this, but network errors are possible because of port binding conflicts with other running containers)

> **_Local installation:_**
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

> **_Test the postgres database connection:_**  Run these commands one by one to interact with the database using the psql client: 
```
make psql
create table test as (select 1);
\dt
select * from test;
drop table test;
exit
```
Wnen you are done with psql, you can play around some more with the make commands, or shut down the containers by running:
```
make down
```

### Setup a new github repo to track changes
If you wish to, rename the project and save it to your own git repo.  Replace `my-project` with the actual project name you used in the previous steps. 

This breaks the link between `docker-generic` project and github, and allows you to re-point it to a new repo.
```
cd my-project
rm -rf .git
git init
```

Next, the first time you want to push a change to a new remote repo:
1. Create a new repo with your git hosting service, such as github, gitlab.  It's a good practice to keep your base directory name and repo name aligned.
2. Get the repo url
3. Run `git push` and follow the prompts to point your local branch to the new remote repo branch

## Using the makefile
Makefiles are like aliases to run one or more scripts.  In this project they simplify the commonly used commands for development and testing.

The makefile assumes that the current working directory is the project base directory.  This lets the docker commands find the correct container names.  You'll need to `cd` into the base directory before using many of the makefile commands.

The makefile includes commonly used commands including:
* start and stop the docker containers
* access the linux cli
* run a python shell
* connect to the postgres database via psql
* run tests with pytest, and code coverage reports

### Makefile details
In most cases, the makefile commands must run from the base directory.

The makefiles are aware of the project name automatically as long as the base directory is your current working directory. For purposes of this example, a project at `~/workspace/my-project` has the base directory named `my-project`.

## Troubleshooting

### Makefill errors with 'No such container'
Problem:
```
Error: No such container: docker-generic_application_1
makefile:8: recipe for target 'version' failed
make: *** [version] Error 1
```

Solution:

Make sure the containers are 'up' and running.  To fix the error, run: `make up`

To show running containers, run `docker container ps`

### Makefile returns 'No rule to make target'
Problem:
```
make: *** No rule to make target 'down'.  Stop.
```

Solution:

Make sure the current working directory is the project base directory.  For example, `~/workspace/docker-generic` has the base directory named `docker-generic`.  `cd` into the base directory and try again.

To see the current working directory, run: `pwd`

### About

This project was started because it takes a lot of work to setup a new project environment from scratch, and I wanted to avoid reinventing the wheel for each new project.

Containerized environments with makefiles can greatly simplify and automate most of the boilerplate environment setup work.

This was born out of frustration with random environment errors while working with python across different computers with different OS's.  This project enables a quick start from which to launch any type of project without having to worry about local computer setups and software dependencies.

The primary tools I like to use are python and a database.  The project includes only the essentials needed to get a new python project up and running, and the database is postgres because it is reliable for small projects and at scale.
