## Web development tips for our large screens

While web delivery is an attractive option for some video wall content, inferring how the layout will be rendered on a large display is not straightforward for the layperson. Since you probably don’t have a desktop with enough pixels to simulate our video walls, it is especially important to test your prototypes at the Hunt Library with NCSU Libraries staff.

When programming for different size canvases it is important to represent pixels and pixel calculations as a percentage of the canvas and not fixed pixels. For example, a 50 pixel circle looks fine on a 1920 x 1080 display but when displayed on the walls it may look like a dust particle. Representing the circle at .026 x canvas width would give you a 50 pixel circle on the 1920 canvas and 156 pixel circle on a 6000 x 1200 canvas.

Chrome's Device Mode & Mobile Emulation can also be useful for designing web pages for the visualization spaces, so you can change the resolution dimensions to the size of the video wall for which you are designing. See Google's documentation for this feature at https://developer.chrome.com/devtools/docs/device-mode

Other tips
* Web pages are displayed on the video walls using the latest stable version of Chrome.
* Your web page or app will be refreshed each time our scheduler loads it.
* Build a dedicated template or CSS for displaying on “large-devices.” Your HTML will probably need to be structured differently, with the CSS sizing things differently for large displays.
* Use responsive HTML practices.
* Use relative sizes. Percentages and relative positioning are better than absolute and fixed positioning to have responsive design.
* Validate your HTML using the W3C Validator Service. Valid HTML will behave more predictably.
* Test test test.