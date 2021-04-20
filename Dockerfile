FROM haskell:8.0.2

MAINTAINER "vosdavid2@gmail.com"

# Install cabal packages
RUN cabal update && cabal install quickcheck twentefp-eventloop-trees

# Install Sprockell
RUN git clone https://github.com/leonschoorl/sprockell.git && cd sprockell && cabal install

# Expose the ports used by the trees graphics
EXPOSE 9161-9163

# Set the workdir
WORKDIR "/root/files"

# Set GHCI as the default command
ENTRYPOINT ["/opt/ghc/8.0.2/bin/ghci"]