# wall_websockets_template.rb

project gem: true, bundle: true, script: 'jquery', renderer: :erb, stylesheet: :scss

generate :controller, "wall get:index"
generate :controller, "control get:index"

CONTROL = <<-CONTROL
<h1>Control</h1>
<p>
  <button id="change" type="button" >Change</button>
</p>
CONTROL
create_file  destination_root("app/views/control/index.html.erb"), CONTROL

CONTROL_LAYOUT = <<-CONTROL_LAYOUT
<!DOCTYPE html>
<html>
<head>
  <title>Control</title>
  <%= stylesheet_link_tag 'control' %>

  <meta name="viewport" content="initial-scale=1; maximum-scale=1.0; user-scalable=0;">

</head>
<body>
  <div class="container-fluid">
    <div class="row">
      <div class="col-xs-12">
        <%= yield %>
      </div>
    </div>
  </div>

  <script type="text/javascript" src="/faye/client.js"></script>
  <%= javascript_include_tag 'jquery', 'control' %>
</body>
</html>
CONTROL_LAYOUT
create_file destination_root("app/views/layouts/control.html.erb"), CONTROL_LAYOUT

WALL = <<-WALL
<%# Insert HTML for the Wall here. %>
<div id="sign">Add text here!</div>
<div id="updates"></div>
WALL
create_file destination_root("app/views/wall/index.html.erb"), WALL

WALL_LAYOUT = <<-WALL_LAYOUT
<!DOCTYPE html>
<html>
<head>
  <title>Wall</title>
  <%= stylesheet_link_tag 'wall' %>
</head>
<body>
  <%= yield %>

  <script type="text/javascript" src="/faye/client.js"></script>
  <%= javascript_include_tag 'jquery', 'wall', 'transform_scale' %>
</body>
</html>
WALL_LAYOUT
create_file destination_root("app/views/layouts/wall.html.erb"), WALL_LAYOUT

create_file destination_root("app/stylesheets/control.scss"), "// Put SCSS for the control page(s) here."

WALL_CSS = <<-WALL_CSS
// Put your SCSS for the wall page(s) here.
html, body {
  padding: 0;
  margin: 0;
}
html {
  background-color: gray;
}
body {
  width: 5760px;
  height: 2304px;
  background-color: black;
  color: white;
  overflow: hidden;
  display:block;
  position: absolute;
  top: 50%;
  left: 50%;
  margin-left: -2880px;
  margin-top: -1152px;
}
#sign {
  position: absolute;
  bottom: 0;
  left: 0;
  color: black;
  background-color: #666;
  z-index: 99999;
  padding: 30px;
  font-size: 150px;
  font-family: sans-serif;
}

#updates {
  font-size: 100px;
  max-height: 90%;
  max-width: 90%;
  overflow: hidden;
}
WALL_CSS
create_file destination_root("app/stylesheets/wall.scss"), WALL_CSS

inject_into_file destination_root('app/controllers/control.rb'), "\n  layout :control", after: ":control do\n"
inject_into_file destination_root('app/controllers/control.rb'), "    render 'index'", after: "get :index do\n"
inject_into_file destination_root('app/controllers/wall.rb'), "\n  layout :wall", after: ":wall do\n"
inject_into_file destination_root('app/controllers/wall.rb'), "    render 'index'", after: "get :index do\n"


CONTROL_JS = <<-CONTROL_JS
// Create a Faye client
var client = new Faye.Client('/faye');
// function for publishing changes to the wall
function publishChange(data){
  client.publish('/wall', data)
}

// When the document is ready, bind a click event to publish an object to the wall.
// You can add as many other events as you want to listen for and publish whatever
// data you want to the wall with each action.
$(document).ready(function() {
  $('#change').on('click', function(){
    publishChange({text: 'change'});
  });
});
CONTROL_JS
create_file destination_root("public/javascripts/control.js"), CONTROL_JS

WALL_JS = <<-WALL_JS
// create a Faye client
var client = new Faye.Client('/faye');

// subscribe to the wall channel
var subscription = client.subscribe('/wall', function(message) {
  console.log(message);
  var datetime = new Date();
  $("#updates").prepend("<div>" + datetime.toString() + ': ' + JSON.stringify(message) + "</div>");
});
WALL_JS
create_file destination_root("public/javascripts/wall.js"), WALL_JS

TRANSFORM_SCALE_JS = <<-TRANSFORM_SCALE_JS
// In development resize the scale
jQuery(document).ready(function($) {
  function transform_scale(){
    var db = document.body;
    var sx = db.clientWidth / window.innerWidth;
    var sy = db.clientHeight / window.innerHeight;
    console.log([db.clientWidth, window.innerWidth, db.clientHeight, window.innerHeight])
    var transform = "scale(" + (1/Math.max(sx, sy)) + ")";
    console.log([sx, sy, transform]);
    db.style.transform = transform;
  }
  $(window).on('resize', function(){
    transform_scale();
  });
  transform_scale();
});
TRANSFORM_SCALE_JS
create_file destination_root("public/javascripts/transform_scale.js"), TRANSFORM_SCALE_JS

ROOT_PATH = <<-ROOT_PATH
    layout :control
    get '/' do
      render 'control/index'
    end
ROOT_PATH
inject_into_file destination_root('app/app.rb'), ROOT_PATH, after: "enable :sessions\n"

FAYE_CONFIG = <<-FAYE_CONFIG
require 'faye'
Faye::WebSocket.load_adapter('thin')
use Faye::RackAdapter, mount: '/faye'

FAYE_CONFIG
inject_into_file destination_root('config.ru'), FAYE_CONFIG, before: "run Padrino"

require_dependencies "faye"
require_dependencies "thin"
require_dependencies "oj"

run_bundler

say "\n\n\nNow I'm going to ask you some questions. All the following is optional or you can choose to do it yourself.\n\n", :green
if yes?("Do you want to use Bootstrap for the remote control interface? [y/n]", :green)
  generate :plugin, "bootstrap"
  inject_into_file destination_root('app/views/layouts/control.html.erb'), " 'bootstrap',", after: "stylesheet_link_tag"
end

puts
if yes?("Do you want to use D3.js on the wall? [y/n]", :green)
  get "http://d3js.org/d3.v3.min.js", destination_root('public/javascripts/d3.js')
  inject_into_file destination_root('app/views/layouts/wall.html.erb'), " 'd3',", after: 'javascript_include_tag'

D3_HTML = <<-D3_HTML
<svg width="720" height="120">
  <circle cx="40" cy="60" r="10"></circle>
  <circle cx="80" cy="60" r="10"></circle>
  <circle cx="120" cy="60" r="10"></circle>
</svg>
D3_HTML
  inject_into_file destination_root('app/views/wall/index.html.erb'), D3_HTML, after: "%>\n"

D3_JS = <<-D3_JS
// Simple D3 example
var d3_color = d3.scale.category20();
var circle = d3.selectAll("circle");
circle.style("fill", "#cc0000");
circle.attr("r", 30);
D3_JS
  prepend_to_file destination_root('public/javascripts/wall.js'), D3_JS

D3_JS_CHANGE = <<-D3_JS_CHANGE
  circle.style("fill", d3_color(Math.floor((Math.random() * 20) + 1)));
D3_JS_CHANGE
  inject_into_file destination_root('public/javascripts/wall.js'), D3_JS_CHANGE, after: "function(message) {\n"
end

