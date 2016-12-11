# Ultimate-Guide-to-Cloud
![Solid](https://cdn-images-1.medium.com/max/800/0*GVMtCxq5Q6S62syt.png)

> This guide will show you how to create a virtual server and deploy an app to it.


## Why?

The goal of this guide is to introduce you to the concept of provisioning a virtual server. In the world of cloud computing, you'll likely deploy applications to various providers such as Heroku, Amazon Web Services, Google Cloud, Microsoft Azure, Rackspace, ... and more. Understanding how to do this on your own is incredibly important. This is meant to be an _introductory_ guide; it only notes where you should implement a more secure best practice - you'll see them next to a 🔑. After practicing your first deployment, you should create a test server and test out the recommended techniques that will be mentioned.

##### Outline

1. Registering for Digital Ocean
2. Identify what Droplets are and how to create one
3. Work with a remote server (droplet) via command line
4. Provisioning a your virtual server
5. Deploying an application
6. FAQ

## Introduction

*Digital Ocean* is a **Platform as a Service (PaaS)**. It is designed to do one thing and to do it well - create instances of web servers for you to use. Once you're out working on a job, you'll be exposed to a variety of PaaS providers - Amazon's EC2, Heroku, AppHarbor, and of course, Digital Ocean. Today you're going to sign up for Digital Ocean, create a droplet (their word for a server), and write an app and put it out for the world to see! Because as cool as it is to show your classmates what you've been working on, wouldn't it be cooler to show your friends and prospective employers? Plus, this will give you a leg up when looking for a job: being able to say **I can configure and setup a server** is kind of a big deal.

## 1. Registering for Digital Ocean
*Digital Ocean requires a credit card on file. Please be aware that if you run out of credits, your card will be billed. This cost is worth it to show your work off to employers.*

  1. Browse to https://www.digitalocean.com/
  2. Sign up for a new account on the main page by entering your email address and creating a password.
  3. You'll be sent a confirmation email (can take up to 5 minutes).
  4. Once you confirm your account, you'll need to enter in credit card information. Do so.
  5. Now, before doing anything else, select the *profile* icon and select *billing*.
  6. Enter in the unique code sent to you on email for your free credits!

## 2. Identify what Droplets are and how to create one

A **droplet** is a scalable server offered by Digital Ocean. Digital Ocean supports a variety of Linux platforms to develop on (amongst others). A droplet can serve a small website that you use for your own portfolio and it can scale up to host an enterprise application! One of the best things about a droplet is that it can scale - if your site blows up, you can expand the resources it has without needing to create a new server!

> Now, we need to locate something to make logging into our droplet easy and secure.

#### Locate an SSH Key

> 🔑 Keep your SSH key private. These are meant to be kept secret; kept safe. Don't share it with strangers.

We need to create a secure way for you to log into any Droplet that you create. We're going to use an private key that you already are using on your computer. You should only share private keys with entities you trust! I only share mine with my computers and the servers I run. I even have a copy of mine in my will! They're private!

Because we want to make sure that you and only you - not some hacker in Russia, not some script kiddie in China - has access to your droplet, we'll use a private key that we're already comfortable with to connect to the server.

Open up terminal and enter in the following commands:

  1. `ls -al ~/.ssh` - list all of the keys in the ./ssh directory. You should see an `id_rsa.pub`. This is your public key.
  3. `subl ~/.ssh/id_rsa.pub` - Open the key in Sublime Text so we can use it in just a moment.

> Now that we have our SSH key, it is time to create a droplet!


#### Create a Droplet

  1. Log in to Digital Ocean if you have not already done so.
  2. Select "Create Droplet" in the top-right corner.
  3. Give your droplet a name. It can be `my-site` or `myawesomesite.com`. The name is just used for reference.
  4. Select the $5/month size for your Droplet (hobby sites use less resources than large production sites)
  5. Select a region.
  6. Ignore the available settings.
  7. Select the **Ubuntu 16.x x64** operating system.
  8. Select **Add SSH Key**. You will copy/paste the SSH key that we retreived just moments ago into the text box.
  9. Select **Create Droplet**.
  10. Annnnndd we wait!

## 3. Work with a remote server (droplet) via command line

### Log in and setup a server in 10 steps!

  1. Log into the remote server (Droplet)
  2. `ssh root@0.0.0.0`
  3. I'm magically logged in because it used my private key from earlier to authenticate who I am!
  4. I need to update the system's repositores! `apt update`
  5. Now, explore your filesystem. `apt install tree` to use the `tree` command.
  6. `apt` is similar to `brew` for Mac OS X - it is a package manager for command line applications.
  7. `pwd` and `cd` around. Feel free to `mkdir` a few files. Things should look _very_ familiar.
  8. If you installed the default version of Ubuntu, you might notice you're in a `bash` shell.
  9. Consider looking for your `.bash_profile` on this system.
  10. Once you're done practicing your Unix/Linux skills, move on.
  11. Like any other computer, a user can `logout` of a system to exit.

> 🔑 Right now you're automatically logged in as the **root** user. This user has all of the power on your server. It is best practice create new users to handle specific tasks (such as one user named dba_admin for databases and one named webmaster for web servers).

## 4. Provisioning your virtual server

We're going to use the _apt_ package manager to install a few tools. You might remember using `brew` to do this in Mac OS X earlier during the cohort. Because each environment and application is different, we have provided a few scripts in this repository to help make life easier. This guide will contain a few familiar stacks. You should only install _what you need_ and nothing else. Unneccesary software installed on your software can expose security vulnerabilities that you don't need in the first place. 

### Everyone

> Install Git

`apt install git`
`apt install build-essential`

### Ruby

> Install Ruby on your linux box

```bash
apt install ruby        # installs ruby
apt install ruby-dev    # install build tools necessary for building some gems (bcrypt, json, ...)
```

Verify Ruby is installed by running `ruby -v`.

### MySQL

MySQL requires that you add a link to Oracle's repositories. It is not hosted publically on `apt`. First, we'll grab that repository, add it to `apt`, and update `apt` so we can find MySQL.

```bash
# get the MySQL repository information
wget http://dev.mysql.com/get/mysql-apt-config_0.8.0-1_all.deb
# install it
sudo dpkg -i mysql-apt-config_0.8.0-1_all.deb
# you'll be provided a GUI option; select the default options (5.7)
# and exit. this is ok! nothing flashy happens here.
# update apt so it can point to the MySQL repository
sudo apt update
```

Once that is installed, we'll install MySQL.

```bash
# install a C library that Ruby uses to build the mysql2 gem with
apt-get install libmysqlclient-dev
# install mysql
apt install mysql-server
```

Once installed, we can control MySQL with the following commands:

```bash
# start
sudo service mysql start
# stop
sudo service mysql stop
# info
sudo service mysql status
```

To login to MySQL, you may do so with `mysql -p`. `-p` specifies that the user is using a password (so it requests you enter one). 

### MongoDB

We recommend using the official installation guide for Ubuntu from Mongodb: https://docs.mongodb.com/v3.2/tutorial/install-mongodb-on-ubuntu/

### Node.js (LTS v4.0)

This version of node is the first LTS release post the io.js merger. Usage of many Javascript 2015 (ES6) features requires `'use strict'` or are not available at all. Node isn't included with the standard list of applications available in `apt`. We'll need to add it ourselves:

```bash
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
```

Once completed, we can then install Node by running:

```bash
apt install nodejs
```

You can verify that Node and _npm_ have been installed by running the following commands.

```bash
npm -v
node -v
```

### Node.js (LTS v6.0)

This version of node contains most Javasript 2015 (ES6) features availability directly in Node without the need of transpiling. Node isn't included with the standard list of applications available in `apt`. We'll need to add it ourselves:

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

Once completed, we can then install Node by running:

```bash
apt install nodejs
```

You can verify that Node and _npm_ have been installed by running the following commands.

```bash
npm -v
node -v
```

## 5. Deploying an application

Applications on a server are ran just like any other application on your laptop - through terminal commands. To make an application run on your virtual server, you must consider how it runs on your laptop. Does it need a database? Is that database running? Did you change your environment variables to reflect the different SQL users between your laptop and server? There are a lot of things to consider when deploying an application. Before diving into specific platforms, here are some questions to consider:

- Is Git installed? 
- Have you cloned your application to your server yet?
- Does my application require a database? Is it the same type on my computer and server?
- Have I created appropriate SQL users for my database?
- Have I updated my config files and environment variables to point to the proper server?
- Have I removed all breakpoints and set my app to run in production mode (vs development)?
- Have I ran all database related tasks (Rake, Gulp, ...)?

Now, we need to create a directory to store all of our web applications.

```bash
cd /        # root directory
cd /var     # var dir
mkdir www   # creates /var/www
pwd         # /var/www
```

Clone any applications you'd like to run using Git in the `/var/www` folder. This is the typical location for storing web applications on Debian (Ubuntu) linux servers. This location is one of the defaults that has been constant throughout decades of web development.

### Deploying Ruby Applications

> 🔑 Consider using Puma over Rack for hosting higher-traffic websites. 

To deploy a Ruby application, clone your Git project into your `/var/www/` folder and change into it. Install the required gems for your application:

```bash
bundle install
```

Now, you can deploy your application via:

```bash
nohup bundle exec rackup -p 80 --host 0.0.0.0
```

**What is nohup?**
- `nohup`: Do not listen to the `hup` signal when terminal is closed
- `bundle exec`: Use the gem versions in the Gemfile.lock to execute the command
- `rackup -p 80`: Run the application on port 80
- `&`: Run this command in the background
- `0.0.0.0` broadcasts to all addresses on this machine.

### Deploying Node Applications

To deploy a Node application, clone your Git project into your `/var/www/` folder and change into it. Install the required modules for your application:

```bash
npm install
```

Next, install **pm2**, a process monitor for Node applications.

```bash
npm install pm2 -g
```

Finally, you can start your application by running the script specified for `npm start` inside of your `package.json`.

```bash
pm2 start app.js -x -- --prod
```

You can stop your application, too (for maintenance and upgrading):

```bash
pm2 stop app.js -x -- --prod
```

## FAQ

**How do I use Nano?**
- Exit - ctrl-x
- Prompts you to save - select Y or N
- Prompts you to confirm where saving. Either edit or press return/enter.

**How do I exit vi?**
- `:` + `q!`
- Forces an exit without a save
**Digital ocean CLI**

**Digital Ocean CLI**
- Check here(https://github.com/digitalocean/doctl)
