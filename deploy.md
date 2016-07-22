# Deploy your Nodejs App

As we have build our nodejs application, we need to deploy it to AWS, so that we can visit it in the world.

## Prerequisite of the AWS machine

* Mongodb
* Nodejs
* Git
* Nginx

Assuming you're gonna provision a ubuntu machine. Before you start, run:

```
sudo apt-get update
```

### Install Mongodb

You can find details [here](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/).

```
sudo apt-get install -y mongodb
```

After it, please specify the path that mongodb need to put the data in,

```
mkdir -p /data/db
```
or

```
mongod --dbpath /some/existing/path
```

### Install nodejs

```
sudo apt-get install -y nodejs
```

### Install Git

```
sudo apt-get install -y git
```

### Install Nginx

```
sudo apt-get install -y nginx
```

Note: The default Nginx directory in Ubuntu is `/usr/share/nginx/html`

