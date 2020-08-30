
TODO-app for [DevOps with Kubernetes course](https://devopswithkubernetes.com/). Backend is written with Go. Frontend with elm.

## depends on
`Elm` and `Go`.

## backend
To start backend
```
cd backend
go run server.go
```
or make binary with
```
go build server.go
```


## frontend
To compile frontend
```
cd frontend
elm make src/Main.elm
```
After that you can serve `index.html` file with backend.
