[![Build Status](https://semaphoreapp.com/api/v1/projects/7d2ec8a3-e7da-48b6-953d-97e415fead5e/230305/badge.png)](https://semaphoreapp.com/danielwanja/angular-seed)

# angular-seed — the seed for AngularJS apps, now with CoffeeScript

This project is an application skeleton for a typical [AngularJS](http://angularjs.org/) web app.
You can use it to quickly bootstrap your angular webapp projects and dev environment for these
projects.

The seed contains a sample AngularJS application and is preconfigured to install the Angular
framework and a bunch of development and testing tools for instant web development gratification.

The seed app doesn't do much, just shows how to wire two controllers and views together.


## Getting Started

To get you started you can simply clone the angular-seed repository and install the dependencies:

### Prerequisites

You need git to clone the angular-seed repository. You can get it from
[http://git-scm.com/](http://git-scm.com/).

We also use a number of node.js tools to initialize and test angular-seed. You must have node.js and
its package manager (npm) installed.  You can get them from [http://nodejs.org/](http://nodejs.org/).

### Clone angular-seed

Clone the angular-seed repository using [git][git]:

```
git clone https://github.com/danielwanja/angular-seed.git
cd angular-seed
```

### Install Dependencies

We have two kinds of dependencies in this project: tools and angular framework code.  The tools help
us manage and test the application.

* We get the tools we depend upon via `npm`, the [node package manager][npm].
* We get the angular code via `bower`, a [client-side code package manager][bower].

We have preconfigured `npm` to automatically run `bower` so we can simply do:

```
npm install
```

Behind the scenes this will also call `bower install`.  You should find that you have two new
folders in your project.

* `node_modules`     - contains the npm packages for the tools we need
* `bower_components` - contains the angular framework files

### Run the Application

We have preconfigured the project with a simple development web server.  The simplest way to start
this server is:

```
gulp dev
```

Now browse to the app at `http://localhost:8000`.

## Directory Layout

      ├── app                          --> the application source code
      │   ├── css                      --> css files
      │   │   └── app.css              --> default stylesheet
      │   ├── img                      --> image files
      │   ├── index.html               --> app layout file (the main html template file of the app)
      │   ├── js                       --> javascript files
      │   │   ├── app.coffee           --> application
      │   │   ├── controllers.coffee   --> application controllers
      │   │   ├── directives.coffee    --> application directives
      │   │   ├── filters.coffee       --> custom angular filters
      │   │   ├── services.coffee      --> custom angular services
      │   │   └── views.coffee         --> defines module for the view templates
      │   └── views                    --> angular view partials (partial html templates)
      │       ├── partial1.hamlc
      │       └── partial2.hamlc
      ├── bower.json                   --> define external dependencies like AngularJA.
      ├── dist                         --> all of the files to be used in production (CoffeeScript and HAMLC compiled to javascript)
      ├── gulpfile.coffee              --> the build system
      ├── package.json                 --> node external dependencies for the build system
      └── test                         --> test config and source files
          ├── e2e                      --> end-to-end specs
          │   └── scenarios.coffee
          ├── karma.conf.coffee        --> config file for running unit tests with Karma
          ├── protractor.conf.js       --> config file for running e2e tests with Protractor
          └── unit                     --> unit level specs/tests
              ├── controllersSpec.coffee  --> specs for controllers
              ├── directivesSpec.coffee   --> specs for directives
              ├── filtersSpec.coffee      --> specs for filters
              └── servicesSpec.coffee     --> specs for services

## Testing

There are two kinds of tests in the angular-seed application: Unit tests and End to End tests.

### Running Unit Tests

The angular-seed app comes preconfigured with unit tests. These are written in
[Jasmine][jasmine], which we run with the [Karma Test Runner][karma]. We provide a Karma
configuration file to run them.

* the configuration is found at `test/karma.conf.js`
* the unit tests are found in `test/unit/`.

The easiest way to run the unit tests is to use the supplied npm script:

```
gulp test
```

### End to end testing

The angular-seed app comes with end-to-end tests, again written in [Jasmine][jasmine]. These tests
are run with the [Protractor][protractor] End-to-End test runner.  It uses native events and has
special features for Angular applications.

* the configuration is found at `test/protractor.conf.js`
* the end-to-end tests are found in `test/e2e/`

Protractor simulates interaction with our web app and verifies that the application responds
correctly. Therefore, our web server needs to be serving up the application, so that Protractor
can interact with it.

```
gulp dev
```

In addition, since Protractor is built upon WebDriver we need to install this.  The angular-seed
project comes with a predefined script to do this:

```
npm run update-webdriver
```

This will download and install the latest version of the stand-alone WebDriver tool.

Once you have ensured that the development web server hosting our application is up and running
and WebDriver is updated, you can run the end-to-end tests using the supplied gulp script:

```
gulp protractor
```

This script will execute the end-to-end tests against the application being hosted on the
development server.


## Updating Angular

Previously we recommended that you merge in changes to angular-seed into your own fork of the project.
Now that the angular framework library code and tools are acquired through package managers (npm and
bower) you can use these tools instead to update the dependencies.

You can update the tool dependencies by running:

```
npm update
```

This will find the latest versions that match the version ranges specified in the `package.json` file.

You can update the Angular dependencies by running:

```
bower update
```

This will find the latest versions that match the version ranges specified in the `bower.json` file.


## Serving the Application Files

While angular is client-side-only technology and it's possible to create angular webapps that
don't require a backend server at all, we recommend serving the project files using a local
webserver during development to avoid issues with security restrictions (sandbox) in browsers. The
sandbox implementation varies between browsers, but quite often prevents things like cookies, xhr,
etc to function properly when an html page is opened via `file://` scheme instead of `http://`.


### Running the App during Development

The angular-seed project comes preconfigured with a local development webserver.  
Then you can start your own development web server to serve static files from a folder by
running:

```
gulp dev
```

Moreover, Gulp will sit and
watch the source files for changes and the application is live reloaded in the browser.

TODO: show enabling proxy

### Running the App in Production

This really depends on how complex is your app and the overall infrastructure of your system, but
the general rule is that all you need in production are all the files under the `dist/` and `bower_components/` directory.
Everything else should be omitted.

TODO: dist+bower_components. Show S3 deploy

Angular apps are really just a bunch of static html, css and js files that just need to be hosted
somewhere they can be accessed by browsers.

If your Angular app is talking to the backend server via xhr or other means, you need to figure
out what is the best way to host the static files to comply with the same origin policy if
applicable. Usually this is done by hosting the files by the backend server or through
reverse-proxying the backend server(s) and webserver(s).


## Continuous Integration

### Travis CI

[Travis CI][travis] is a continuous integration service, which can monitor GitHub for new commits
to your repository and execute scripts such as building the app or running tests. The angular-seed
project contains a Travis configuration file, `.travis.yml`, which will cause Travis to run your
tests when you push to GitHub.

You will need to enable the integration between Travis and GitHub. See the Travis website for more
instruction on how to do this.


## Contact

For more information on AngularJS please check out http://angularjs.org/

[git]: http://git-scm.com/
[bower]: http://bower.io
[npm]: https://www.npmjs.org/
[node]: http://nodejs.org
[protractor]: https://github.com/angular/protractor
[jasmine]: http://pivotal.github.com/jasmine/
[karma]: http://karma-runner.github.io
[travis]: https://travis-ci.org/
[http-server]: https://github.com/nodeapps/http-server
[gulp]: http://gulpjs.com/
