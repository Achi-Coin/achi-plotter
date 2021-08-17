# Compiler image
# -------------------------------------------------------------------------------------------------
FROM alpine:3.13.5 AS compiler

WORKDIR /root

RUN apk --no-cache add \
    gcc \
    g++ \
    build-base \
    cmake \
    gmp-dev \
    libsodium-dev \
    libsodium-static \
    git

COPY . .

RUN git submodule update --init
RUN /bin/sh ./make_devel.sh

# Runtime image
# -------------------------------------------------------------------------------------------------
FROM alpine:3.13.5 AS runtime

WORKDIR /root

RUN apk --no-cache add \
    gmp-dev \
    libsodium-dev

COPY --from=compiler /root/build /usr/lib/achi-plotter
RUN ln -s /usr/lib/achi-plotter/achi_plot /usr/bin/achi_plot

ENTRYPOINT ["/usr/bin/achi_plot"]
