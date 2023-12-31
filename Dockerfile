FROM --platform=$BUILDPLATFORM golang:1.21.5-alpine3.17 as build

RUN apk --no-cache add ca-certificates

WORKDIR /src
COPY . .

ARG TARGETOS
ARG TARGETARCH
RUN --mount=target=. \
	--mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/go/pkg \
    GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /out/dummy .

FROM scratch

COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /out/dummy /out/dummy

EXPOSE 8080

WORKDIR /home

ENTRYPOINT ["/out/dummy"]