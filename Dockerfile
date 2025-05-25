FROM golang

WORKDIR /app

RUN apt-get update && \
    apt-get update -y

RUN echo 'module myapp' > go.mod && \
    echo 'go 1.24.3' >> go.mod

RUN echo 'package main' > main.go && \
    echo 'import "fmt"' >> main.go && \
    echo 'func main() {' >> main.go && \
    echo '    fmt.Println("Hello, Console App!")' >> main.go && \
    echo '}' >> main.go

RUN go get github.com/goccy/go-yaml && \
    tar -czf /app/pkg.tar.gz /go/pkg && \
    ls -la

RUN go build .

ENTRYPOINT ["/app/myapp"]
