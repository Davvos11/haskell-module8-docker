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