# Hunt Library Video Wall Guide
## Instructions and tips for creating Processing sketches for video walls
___

Select the templates for your version of Processing (2.x or 3.x)
---
  - There are some code breaking changes between Processing 2.x and Processing 3.x (see [Changes in 3.0](https://github.com/processing/processing/wiki/Changes-in-3.0) for more information). Make sure to use the templates that correspond with your version of Processing:
    - For Processing 2.x use the files in the folder **Processing2VideoWall**
    - For Processing 3.x use the files in the folder **Processing3VideoWall**

General guidelines:
---
- Make sure the **aspect ratio** is correct for the wall you’re designing for from the get go. The actual size of the sketch will depend on how complex your sketch is, and how taxing it is on the computer running it. The final resolution should be decided upon after testing on the walls, keeping it as close to full resolution as possible without sacrificing too much performance.
- Typically, the video walls are a few thousand pixels wide, and usually around 20 feet wide. The number of pixels per unit length, which is usually measured by the **PPI count, varies for the different walls**. Also, the PPI count for the walls is much lower than the PPI count of a typical computer display. This means that if there is any motion in your sketch, you need to keep in mind that if something is moving a few millimeters every second on your display, it might move at a speed of several inches every second on the video walls.
- Keeping the above in mind, movements might have to be exaggerated when designing for the Art Wall or the Commons Wall, because these are mounted in a way that the viewing distance is large. Subtle movements would probably not be noticeable on the Art Wall and Commons Wall - they are better suited to the Immersion Theater and the Visualization wall because of the viewer’s close proximity to the walls.

Design guidelines:
---
- For color choices, keep in mind that **dark backgrounds work the best** with walls using the MicroTile technology. With lighter colors, the bezel is more visible. While it is perfectly okay to use colors with a high brightness value, try to use darker colors for bigger areas like the background.
- The MicroTile display units which the walls are comprised of have a **very wide color gamut** (115% sRGB). This means that the colors that you would typically see on your computer display will be different from what you would see on the video walls. The best way to check how your sketch looks on the wall is to schedule a test-run with us.

Performance guidelines:
---
- Typically, **PNGs perform better than SVGs** for graphic elements. If you have many copies of the same graphic element in your sketch, then use PNGs. A good example for this kind of implementation would be leaves on a tree. If you have a single graphic for a leaf which you’re making copies of to create the tree, PNGs will perform much better than SVGs.
- That being said, also keep in mind that the **PNGs might have a problem displaying properly in P3D** rendering mode. In P3D, you might need to change the z-depth of the PNG images in order for the transparency to display properly. If the PNG overlaps with an element created within Processing and is present on the same z-depth, the transparency might not be rendered perfectly. This problem does not seem to be present in the other rendering modes (P2D and PDF).
- A note about **type quality and textMode()**. The default text mode for rendering type in Processing is MODEL, in which case the text is drawn as a texture. A much better way of rendering text is changing the text mode to SHAPE, which draws the text as vector geometry. However, this comes at the cost of a substantial performance loss. Keep this in mind when drawing text - if the type is in focus and is important, then use the SHAPE text mode by invoking textMode(SHAPE); however change it back to MODEL once the important text has been rendered. This is probably similar to the performance difference between rendering a PNG image vs rendering an SVG element, see comment above.
- Keep the **smooth() level to either 2 or 4** for most applications. If you notice a framerate drop (during testing on the walls) then decrease it by a step. The way smooth(N) works is rendering the image at N times the size specified in the size() function in setup(), and then downsampling it to the correct size. This is also called anti-aliasing.

Submission guidelines:
---
- Once you're happy with your sketch from running it on your personal computer with the template, and you're ready to test it on the wall, send us a copy of your source code.
- Typically, the source code is saved in the Processing sketchbook folder. For Windows users, the default location is "...\Documents\Processing\", for Mac users the default location is "~/Documents/Processing/".
- Set up a meeting with us so that we can test your code on the walls with you, and discuss / suggest anything if you need input.
- After finalizing the code after testing on the walls, you can again submit the code to us so that we can display it on the wall.
