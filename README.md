# Docker container for Programming Paradigms at UTwente
This container contains GHC version 8.0.2 with the following libraries:
- quickcheck
- twentefp-eventloop-trees
- parsec
- zip-1.2.0
- regex-tdfa
- bytestring
- sprockell

This means that it can be used throughout the entirety of the module (as of 2021) and is able to plot graphs (in a browser outside the container), use quickcheck and parsec, and use the provided MakeZip and CheckZip for the project. [Sprockell](https://github.com/leonschoorl/sprockell) is also included for the final project.

## Setup
First time setup (run in the current directory):
```sh
docker build -t davvos11/haskell-module8 .
```

To access the system you can run (in the current directory):
```sh
docker run -it -v $(pwd)/haskell:/root/files -p 9161-9163:9161-9163 davvos11/haskell-module8:latest
```
or, if you have `docker-compose` installed:
```sh
docker-compose run --service-ports haskell
```

If you want to do something inside the container before running *ghci* (like changing to another directory), you can add `bash` add the end of the command and you will get a normal shell, or you can add any command add the end (instead of `bash`).

Files created inside the docker container do have *root* as their owner, to access them from the outside you can use for example `sudo chown $USER:$USER ./filename`
