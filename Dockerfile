FROM haskell:8.0.2

LABEL maintainer="vosdavid2@gmail.com"

RUN apt-get update -y && apt-get install -y libbz2-dev

# Install cabal packages
RUN cabal update && cabal install quickcheck twentefp-eventloop-trees parsec zip-1.2.0 regex-tdfa bytestring

# Install Sprockell
RUN git clone https://github.com/leonschoorl/sprockell.git && cd sprockell && cabal install

# Expose the ports used by the trees graphics
EXPOSE 9161-9163

# Set the workdir
WORKDIR "/root/files"

# Set GHCI as the default command
CMD ["/opt/ghc/8.0.2/bin/ghci"]