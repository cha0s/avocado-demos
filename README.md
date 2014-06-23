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

This will generate everything you need to host your application. Just point
a server like Apache at the avocado-baseline directory!

##### node-webkit (native)

First, download node-webkit from
https://github.com/rogerwang/node-webkit#downloads and extract everything in
the archive to the distribution directory. The actual files required to be
placed in that directory are:

* libffmpeg.(so|dll)
* nw
* nw.pak
* nwsnapshot

Once you do this, all you need to do is run node-webkit:

`npm start`

I'll write more documentation on how to distribute your apps once I figure out
a nice automatic way to do so.
