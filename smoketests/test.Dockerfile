FROM postgis/postgis:11-2.5

RUN apt-get update \
 # install newer packages from backports
 && apt-get install -y --no-install-recommends \
    g++ \
    gcc \
    libc6-dev \
    make \
    pkg-config \
    libgeos-dev \
    libleveldb-dev \
    libprotobuf-dev \
    osmctools \
    postgis \
    osmosis \
    git \
    ssh \
    tar \
    gzip \
    ca-certificates \
    curl \
    wget \
    perl \
    postgresql-11-pgtap \
 && ln -s /usr/lib/libgeos_c.so /usr/lib/libgeos.so \
 && rm -rf /var/lib/apt/lists/*

RUN curl -LO http://xrl.us/cpanm && chmod +x cpanm \
    && ./cpanm TAP::Parser::SourceHandler::pgTAP

ENV PERL5LIB /usr/local/lib/perl5

RUN wget https://golang.org/dl/go1.14.15.linux-amd64.tar.gz \
    && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.14.15.linux-amd64.tar.gz

ENV GOPATH /usr/local/go
ENV PATH $PATH:/usr/local/go/bin

ARG IMPOSM_REPO="https://github.com/omniscale/imposm3.git"
ARG IMPOSM_VERSION="v0.11.1"

# add  github.com/omniscale/imposm3
RUN mkdir -p $GOPATH/src/github.com/omniscale/imposm3 \
 && cd  $GOPATH/src/github.com/omniscale/imposm3 \
 && go get github.com/tools/godep \
 && git clone --quiet --depth 1 $IMPOSM_REPO -b $IMPOSM_VERSION \
        $GOPATH/src/github.com/omniscale/imposm3 \
 && make build \
 && ( [ -f imposm ] && mv imposm /usr/bin/imposm || mv imposm3 /usr/bin/imposm ) \
 # clean
 && rm -rf $GOPATH/bin/godep \
 && rm -rf $GOPATH/src/ \
 && rm -rf $GOPATH/pkg/

COPY ./scripts/initdb-pgtap.sh /docker-entrypoint-initdb.d/20_pgtap.sh
COPY ./scripts/seeddb.sh /docker-entrypoint-initdb.d/30_seed.sh
COPY ./tests /etc/tests
