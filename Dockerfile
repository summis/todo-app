FROM golang:1.14-alpine as build-stage

WORKDIR /app

COPY . .

# TODO install elm and compile frontend here just for the case
RUN go build backend/server.go


FROM alpine

WORKDIR /app

COPY --from=build-stage /app/server /app/server

CMD ["./server"]

