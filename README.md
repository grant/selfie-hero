# Snappo
Selfies with people around you.

### How to start server

```sh
$ foreman start -e .env-dev
```

### How to deploy

- Update heroku env variables (`heroku config`)
- Change Facebook App callback URL settings

### How to develop

```sh
$ gulp
```

### Gulp tasks

- `gulp`: Builds and watches for changed files
- `gulp build`: Compiles and builds the generated files
- `gulp watch`: Watches files
- `gulp coffee`: Lints coffeescript and browserifies client coffeescript
- `gulp stylus`: Compiles stylus

### Built with

- :coffee: Coffeescript
- :cloud: Express
- :lipstick: Stylus
- :gem: Jade
- :tropical_fish: Gulp
