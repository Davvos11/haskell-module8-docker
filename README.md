First time setup:
```sh
docker build -t davvos11/haskell-module8 .
```

To access the system you can run:
```sh
docker run -it -v $(pwd)/haskell:/root davvos11/haskell-module8:latest
```
or, if you have `docker-compose` installed:
```sh
docker-compose run --service-ports haskell
```