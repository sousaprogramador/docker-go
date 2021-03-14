FROM golang:1.14-alpine AS builder

WORKDIR /go/src/app
COPY ./go .

RUN go get -d -v ./ ... && \
  go install -v ./...

RUN go run fullcycle.go && \
  go build fullcycle.go && \
  ls

FROM alpine:3.7
COPY --from=builder /go/src/app  /go/src/app
WORKDIR /go/src/app
CMD ["./fullcycle"]