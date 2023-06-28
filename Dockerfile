# FROM golang:1.15-buster AS build
# WORKDIR /go/src/github.com/mpolden/echoip
# COPY . .

# ENV GO111MODULE=on CGO_ENABLED=0
# RUN make

# FROM scratch
# EXPOSE 8080

# COPY --from=build /go/bin/echoip /opt/echoip/
# COPY html /opt/echoip/html

# WORKDIR /opt/echoip
# ENTRYPOINT ["/opt/echoip/echoip"]

FROM golang:1.15-buster AS build
WORKDIR /go/src/github.com/mpolden/echoip
COPY . .

ENV GO111MODULE=on CGO_ENABLED=0 GOOS=linux GOARCH=amd64
RUN make

FROM alpine:latest
EXPOSE 8080

COPY --from=build /go/bin/echoip /opt/echoip/
COPY html /opt/echoip/html

WORKDIR /opt/echoip
CMD ["/opt/echoip/echoip"]
