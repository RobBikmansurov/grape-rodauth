# Grape + rodauth = <3
This repository is example how you can integrate [rodauth](http://rodauth.jeremyevans.net) to [grape](https://github.com/ruby-grape/grape) app

## How to use it

1. Starts the server ```rackup```

2. Send this requests for create user

```
curl -v -H "Content-Type: application/json" -d '{"login":"test@site.com", "login-confirm":"test@site.com","password":"password", "password-confirm":"password" }' -X POST http://localhost:9292/create-account
```
Send request for login
```
curl -v -H "Content-Type: application/json" -d '{"login":"test@site.com","password":"password" }' -X POST http://localhost:9292/login
```

After that you need to get `Authorization` header value and send next request with this value:
```
curl -v -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50X2lkIjoxfQ.AhfkU3lMujse6BAT_Kugk6LXnNgF0A3_YejLWcBnikY" -X GET http://localhost:9292/api/private/hello
```
it return ```{"hello":"world for test@site.com"}```


```
curl -v -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50X2lkIjoxfQ.AhfkU3lMujse6BAT_Kugk6LXnNgF0A3_YejLWcBnikY" -X GET http://localhost:9292/api/hello

or

curl -v -H "Content-Type: application/json" -X GET http://localhost:9292/api/hello

```
will return ```{"hello":"world for all!"}```


```
curl -H "Content-Type: application/json"  -X GET http://localhost:9292/api/hello.json
```
returned ```{"hello":"world for all!"}```