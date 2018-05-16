# Visualization Studio Web Presentation Template
Responsive web presentation template for the NCSU Libraries [Visualization Studio](http://www.lib.ncsu.edu/spaces/visualization-studio).

## General presentation hierarchical flow:
scene >
sub-scene >
wall position (wall-[1-4]-[left,center,right]), screen width (screen-width-[1-12]) >
item width (item-width-[1-12])

### Moving through slides
* Scene: A scene is similar to one slide of a typical slide deck. A scene can contain multiple sub-scenes or media items on one or more walls. When progressing to a new scene, all items in the previous scene are removed from view.
* Sub-scene: A sub-scene is similar to an item in a slide of a typical slide deck that appears without transitioning to a new slide (e.g., using an animation in PowerPoint to make a hidden media item visible). Multiple sub-scenes can be added to a scene sequentially.
* Navigation: Depending on device, you can move forward through scenes using left-click/swipe-right/right-arrow, you can move backward through scenes using swipe-left/left-arrow

### Placing content on slides
* Walls: Place a sub-scene or media item on a specific wall (i.e., wall-[1-4]) and position (i.e., left, right, center). For example, to place a media item on the left screen of the second wall use the css class: wall-2-left. Use the included floor plan for wall placement.
* Screen width: set the width of a sub-scene or media item to span from one to twelve screens (i.e., screen-width-[1-12]). For example, to display a media item over three screens use the css class: screen-width-3
* Item width: Set the width of one specific media item (e.g., div, img, video, etc.) as a fraction of the parent container from one to twelve (i.e., item-width-[1-12]). For example, to display an image over half of the width of left screen of wall-1 use the following html/css:
```html
<div class="wall-1-left screen-width-1">
  <img class="item-width-6" src="http://placekitten.com/1024/768" alt="Kitten" />
</div>
```

## Special set up for the Visualization Studio
In order to display a presentation in the Visualization Studio without any background content showing you must hide the tab menu and the address bar from Chrome and run an AutoHotKey script available on the Visualization Studio computer desktop. This is done as follows:
1. Create a shortcut on the desktop with the following location path and flags to run Chrome as an app (i.e., removing the tab menu and address bar):
```
"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --args --app=<URL OR FOLDER OF YOUR PRESENTATION>
```

2. Start the AutoHotKey (AHK) script by double-clicking the AHK icon on the desktop. You can tell if it is running by looking in the icon-menu of the Windows menu bar (bottom-right of first screen) and ensuring there is a green square with an H in the icon list.

3. Launch the shortcut you just created.

4. Run the AHK script by holding down the left-Windows button and left-clicking in the Chrome browser window.

5. The browser will resize and display across all screens and two black bars will be overlaid the top and bottom of the screen to obscure the browser window frame.
