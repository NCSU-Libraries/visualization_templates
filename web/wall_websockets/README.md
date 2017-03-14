# Interactive Hunt Wall Template

This template can be used to generate a new project that can be used to create applications where a user can remotely interact with and change the content on the Hunt video walls.

## Requirements

You'll need Ruby installed. We recommend using [RVM](http://rvm.io/) to install the latest version of Ruby.

## Usage

```shell
gem install padrino

padrino-gen project my_project_name --template https://raw.githubusercontent.com/NCSU-Libraries/visualization_templates/master/web/wall_websockets/wall_websockets_template.rb
```

A new project will get created for you. Along the way, you'll be asked some questions about optional components you can add to your project like a CSS framework and JavaScript library.

## Getting Started

First, you'll want to start your new project running:

```shell
cd my_project_name
padrino start
```

Open up two browser windows:

- http://localhost:3000/ For the remote control interface.
- http://localhost:3000/wall For what gets displayed on the Art Wall.

If you click the "Change" button on the control page you ought to see the message that was sent to the wall. It isn't much, but if this works, then things are wired up correctly for you to do something more interesting.

## Files to Edit

- JavaScript files are under public/javascripts/. The ones you'll want to open up are control.js and wall.js. You'll see some comments in these files to guide you.
- CSS (actually [SCSS](http://sass-lang.com/)) can be edited under app/stylesheets/. These files then get compiled into the public directory automatically.
- The remote control and wall views can be found under app/views/. You'll see that each interface also has its own layout where you can add other markup or links to other CSS or JavaScript.

## Diving Deeper

As you're developing your application, you will want to take a look at the [Chrome console](https://developer.chrome.com/devtools/docs/console).

The Web framework used is [Padrino](http://www.padrinorb.com/).

The communication between the remote control and the wall happens via [WebSockets](https://developer.mozilla.org/en-US/docs/WebSockets). The framework used on both the server and browser client sides is [Faye](http://faye.jcoglan.com/).
