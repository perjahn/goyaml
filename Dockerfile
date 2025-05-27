FROM golang

WORKDIR /app

RUN apt-get update && \
    apt-get update -y

RUN echo 'module myapp' > go.mod && \
    echo 'go 1.24.3' >> go.mod

RUN echo 'package main' > main.go && \
    echo 'import (' >> main.go && \
    echo '  "fmt"' >> main.go && \
    echo '  "github.com/goccy/go-yaml"' >> main.go && \
    echo '  "github.com/goccy/go-yaml/ast"' >> main.go && \
    echo ')' >> main.go && \
    echo 'func main() {' >> main.go && \
    echo '    fmt.Println("Hello, Console App!")' >> main.go && \
    echo '}' >> main.go

RUN go get github.com/goccy/go-yaml && \
    go mod vendor

RUN go build -mod=vendor || true

RUN tar -czf /app/vendor.tar.gz vendor && \
    cat vendor/modules.txt && \
    ls -laR vendor && \
    ls -la

ENTRYPOINT ["/app/myapp"]
