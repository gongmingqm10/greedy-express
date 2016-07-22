# Greedy Express
Express project build with yo

We use mongodb for the database. And less for css, coffee for js. Make sure you have already started the mongod server.

In my Mac, I start the mongodb server via `mongod`.

## Run the website

This project is a nodejs server and build with gulp. You can start it:

```
npm install
```

It'll install the necessary packages declared in `package.json`. After you installed all the packages.

```
gulp
```

Visit the `localhost:3000`, when the page loads `Generator-Express MVC`. You indeed succeed.

## Deploy

We'll use the [PM2](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-14-04)
to start the nodejs application, and will use Nginx proxy to forward it to port 80.

Given you have already logged in the AWS machine.

```
## 1. Update the repo
git pull

## 2. package the application
gulp package

## 3. Restart PM2
NODE_ENV=production pm2 restart appName,  cd dist && NODE_ENV=production pm2 start app.js (for the first time)
```

Congratulations!
