FROM golang:1.17-buster as builder

WORKDIR /app

ADD . .

RUN git config --global url.ssh://git@github.com/.insteadOf https://github.com/

RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan github.com > /root/.ssh/known_hosts


RUN go env -w GOPRIVATE=github.com/mnevadom/go-private

RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=secret,id=ssh,dst=/root/.ssh/id_rsa \
    go mod download && go mod verify

RUN go build -o /usr/local/bin/hello-world

FROM golang:1.17-buster

COPY --from=builder /usr/local/bin/hello-world /usr/local/bin/hello-world

EXPOSE 8080
CMD ["/usr/local/bin/hello-world"]