FROM ubuntu:jammy-20220428 AS builder
RUN apt update && \
    apt install libssl-dev git automake autoconf libtool make g++ -y
RUN git clone --branch SQUID_6_10 https://github.com/squid-cache/squid.git /root/squid
WORKDIR /root/squid
RUN autoreconf -i
RUN ./configure --with-openssl --enable-ssl-crtd --enable-icap-client --with-default-user=proxy
RUN make -j$(nproc)
RUN make install
FROM ubuntu:jammy-20220428 AS runtime
RUN apt update && apt install libtool -y
COPY --from=builder --chown=proxy /usr/local/squid /usr/local/squid
ENTRYPOINT ["/usr/local/squid/sbin/squid"]
ENV PATH=/usr/local/squid/bin:/usr/local/squid/sbin:$PATH
WORKDIR /usr/local/squid/etc
CMD ["-f", "/usr/local/squid/etc/squid.conf","-d","10","-N"]
EXPOSE 3128
LABEL org.opencontainers.image.source=https://github.com/ngodat0103/nt534.git
