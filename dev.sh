#!/bin/bash

usage() {
	cat <<EOF
Usage: $(basename $0) <command>

Wrappers around core binaries:
    build                   Builds the 1337 app.
    docker                  Builds docker image and pushes it to DockerHub.
    docker-run              Runs docker image. Notice: It uses sudo to run service on port 80 and 443
EOF
	exit 1
}

CMD="$1"
GIT_VERSION=$(git describe --always)

shift
case "$CMD" in
	build)
		CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o landing -a -tags netgo .
	;;
	docker)
		docker build -t "mateuszdyminski/1337:$GIT_VERSION" .
        docker build -t "mateuszdyminski/1337:latest" .
        docker push "mateuszdyminski/1337:$GIT_VERSION"
        docker push "mateuszdyminski/1337:latest"
	;;
    docker-run)
        docker run -it -d --rm -v $(pwd)/certs:/certs --restart unless-stopped -p 80:8080 -p 443:8090 mateuszdyminski/1337:latest 
    ;;
	*)
		usage
	;;
esac