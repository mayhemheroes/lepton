# Build State
FROM ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang

## Add source code to the build stage.
ADD . /lepton
WORKDIR /lepton

## Build Instructions
RUN rm -rf build && mkdir build && cd build && cmake .. && make -j8

# Package Stage
FROM ubuntu:20.04
COPY --from=builder /lepton/build/ /
