# Avocado baseline

<img align="right" src="https://raw.github.com/cha0s/avocado/master/logo.png">

### Wanna start making games?

This is the easiest way to dive right into making games with
[avocado](https://github.com/cha0s/avocado)!

You're going to at least need [Node.js](http://nodejs.org/) and
[Grunt](http://gruntjs.com/).

If you want to support modern HTML5 capable browsers, that's all you need!
However, if you'd like to run your game application natively, you will need
[node-webkit](https://github.com/rogerwang/node-webkit).

#### Installing

First get the source either by cloning this repository or downloading the zip
file from the bar on the right --->

Then go into the directory and clone avocado's source code:

`git clone https://github.com/cha0s/avocado.git avocado`

then, install all the module dependencies:

`npm install`

##### HTML5 (browser)

To install for the browser, you only have to run grunt:

`grunt`

**NOTE** If you use Ubuntu and installed node from the package manager, the
binary is named `nodejs` and not `node`. See
https://github.com/joyent/node/issues/3911#issuecomment-8956154 for how to
fix this issue.

This will generate everything you need to host your application. Just open
index.html with your favorite HTML5-capable browser!

**NOTE** Some browsers will not let you run the HTML locally. If that's the
case (you just get a black screen), then you will have to serve the directory
using an HTTP server like apache. Sorry!

##### node-webkit (native)

First, download node-webkit from
https://github.com/rogerwang/node-webkit#downloads and extract everything in
the archive to the **distribution** directory.
Once you do this, all you need to do is run node-webkit:

`npm start`

or, if you're on windows, go into the folder and launch **run.bat**!

I'll write more documentation on how to distribute your apps once I figure out
a nice automatic way to do so.
