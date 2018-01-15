FROM golang:1.9

ENV package_name=github.com/elastic/beats

WORKDIR "/go/src/${package_name}"

RUN mkdir -p "/go/src/${package_name}"

#RUN go get -u github.com/kisielk/errcheck

# explicitly install dependencies to improve Docker re-build times
#RUN go get -v \
#  <package-name>

COPY ./vendor "/go/src/${package_name}/vendor"
COPY ./libbeat "/go/src/${package_name}/libbeat"
COPY ./filebeat "/go/src/${package_name}/filebeat"

#RUN gofmt -e -s -d /go/src/app 2>&1 | tee /gofmt.out && test ! -s /gofmt.out
#RUN go tool vet /go/src/app
#RUN errcheck ./...

RUN go install github.com/elastic/beats/filebeat

RUN gofmt -e -s -d libbeat/processors/add_kubernetes_metadata

RUN mkdir -p /usr/share/filebeat/ && cp /go/bin/filebeat /usr/share/filebeat/

ENTRYPOINT ["/usr/share/filebeat/filebeat"]
