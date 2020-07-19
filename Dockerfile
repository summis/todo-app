FROM golang:1.14-alpine as build-stage

WORKDIR /app

COPY . .

RUN cd backend && go build server.go

# Directory where images are saved
RUN [ ! -d files ] && mkdir files || exit 0


FROM alpine

COPY --from=build-stage /app/ /app/

WORKDIR /app/backend

CMD ["./server"]
