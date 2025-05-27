DOCKER_BUILDKIT=0 docker build -t goyaml .
docker run -v `pwd`:/out --entrypoint cp goyaml /app/vendor.tar.gz /out
