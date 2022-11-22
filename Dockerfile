# This dockerfile is specific to building Multus for OpenShift
# FROM registry.ci.openshift.org/ocp/builder:rhel-8-golang-1.19-openshift-4.12 AS rhel8
FROM golang:1.18 as build
ADD . /usr/src/plugins
WORKDIR /usr/src/plugins
ENV CGO_ENABLED=0
RUN ./build_linux.sh

FROM fedora:latest
RUN mkdir -p /usr/src/plugins/bin && \
    mkdir /usr/src/plugins/rhel7/ && \
    mkdir /usr/src/plugins/rhel8/ && \
    ln -s /usr/src/plugins/bin /usr/src/plugins/rhel7/bin && \
    ln -s /usr/src/plugins/bin /usr/src/plugins/rhel8/bin

COPY --from=build /usr/src/plugins/bin/* /usr/src/plugins/bin/


WORKDIR /

