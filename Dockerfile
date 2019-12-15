FROM golang:1.13.5 AS builder

RUN mkdir -p /build

RUN mkdir -p $GOPATH/src/k8s.io/cloud-provider-aws \
	&& cd $GOPATH/src/k8s.io/cloud-provider-aws \
	&& curl -L https://github.com/kubernetes/cloud-provider-aws/tarball/master | tar xz --strip-components=1 \
	&& make \
	&& cp aws-cloud-controller-manager /build \
	&& strip /build/aws-cloud-controller-manager

FROM alpine:3.10.3

COPY --from=builder /build/aws-cloud-controller-manager /
