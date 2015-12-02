# Blog Example Application

This is a blog application to run on the [dbPager Server]. The application shows how to: 

  - Organize your source code
  - Use application components

dbPager Server is FastCGI application server written in C++. 

> The overriding design goal for dbPager Server is to provide
> so powerful templating engine that conventional programming
> languages would be no need to develop a web site.

## Compiling

The application contains resources which should be compiled before deploying. To compile application, [NPM], [Grunt] and [Bower] tools are required.

NPM can be installed with your system package manager. To download other tools and dependencies, run:

```sh
$ npm install --save-dev
$ bower install
```

Now you are ready to compiling sources. Run:

```sh
$ grunt
```

or build entire docker container:

```sh
$ grunt docker
```

## Running the app

To install the application, you can use [Docker] container:

```sh
$ docker pull wolfsoft/blog-example
```
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
