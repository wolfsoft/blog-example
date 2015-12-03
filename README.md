# Blog Application Example

This is a sample of blog application to run on the [dbPager Server]. The application shows how to:

  - Organize your source code
  - Use application components

dbPager Server is FastCGI application server written in C++. 

> The overriding design goal for dbPager Server is to provide
> so powerful templating engine that conventional programming
> languages would be no need to develop a web site.

We assume you are familiar with [Docker] and have it installed.

## Downloading

You can download current version of the application from our public git repository:

```sh
$ git clone https://github.com/wolfsoft/blog-example.git
$ cd blog-example/
```

## Compiling

The application contains resources which should be compiled before deploying. To compile application, [NPM], [Grunt] and [Bower] are required.

NPM can be installed with your system package manager (`sudo apt-get install npm`). To download other tools and dependencies, run:

```sh
$ npm install --save-dev
$ bower install
```

Two directories, `bower_components` and `node_modules` will be added after that. Now you are ready to compiling sources. Run:

```sh
$ grunt
```

After compiling, `public` directory will be populated with required static content. Next, build the self-hosted docker container:

```sh
$ grunt docker
```

## Running the app

TODO

## Development

Want to contribute? Great! Fork project on Github and send me pull requests.

## License

GPLv3

[//]: #
   [dbPager Server]: <https://dbpager.com/>
   [Docker]: <https://docker.io/>
   [Grunt]: <http://gruntjs.com/>
   [Bower]: <http://bower.io/>
   [NPM]: <https://www.npmjs.com/>
