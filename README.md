# Hunt Video Wall HTML Templates

There are four large video walls built into the public spaces around the Hunt Library. These displays make Hunt a storytelling building, integrating architecture and digital media to facilitate exciting new forms of communication. We curate a program of content for the video walls that is focused on demonstrating NC State's impact.

These HTML templates are part of a Producer's Toolkit to help you design large-scale web content for these displays. See the NCSU Libraries [video walls webpage](http://www.lib.ncsu.edu/videowalls) for more information.

You are encouraged to contact us before you begin production work. All content submissions are subject to the editorial review of NCSU Libraries. Email group-videowalls@ncsu.edu with any questions. 

## Web development tips

While web delivery is an attractive option for some content, inferring how the layout will be rendered on a large display is not straightforward for the layperson. Since you probably don’t have a desktop with enough pixels to simulate our video walls, it is especially important to test your prototypes at Hunt with Libraries staff.

When programming for different size canvases it is import to represent pixels and pixel calculations as a percentage of the canvas and not fixed pixels. For example, a 50 pixel circle looks fine on a 1920 x 1080 display but when displayed on the walls it may look like a dust particle. Representing the circle at .026 x canvas width would give you a 50 pixel circle on the 1920 canvas and 156 pixel circle on a 6000 x 1200 canvas.

Chrome's Mobile Emulation mode can also be useful for designing web pages for the MicroTiles walls. The Emulation tools must be enabled in the DevTools Settings. Once the Emulation tools are enabled, select Emulation>Screen and set the resolution dimensions to the size of the video wall for which you are designing. See Google's documentation for this feature at https://developer.chrome.com/devtools/docs/mobile-emulation

Other tips
* Web pages are displayed on the video walls using the latest stable version of Chrome. 
* Build a dedicated template or CSS for displaying on “large-devices.” Your HTML will probably need to be structured differently, with the CSS sizing things differently for large displays.
* Use responsive HTML practices.
* Use relative sizes. Percentages and relative positioning are better than absolute and fixed positioning to have responsive design.
* Validate your HTML using the W3C Validator Service. Valid HTML will behave more predictably.
* Test test test.