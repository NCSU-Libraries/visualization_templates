# Teaching and Visualization Lab *web* Templates

**Overview:** The Teaching and Visualization Lab provides the largest format visual experience with a 270 degree viewing angle, excellent for delivering high-impact presentations or large-format visualizations.

**Technical Details**

* Wrap-around Mode: 16384W x 1200H pixels, 10 blended HD projectors
  * South Wall: 4608W x 1200H pixels, 3 blended HD projectors
  * Southwest Corner: 1920W x 1200H pixels, 1 HD projector
  * West Wall: 4608W x 1062H pixels, 3 blended HD projectors
  * Northwest Corner: 1920W x 1200H pixels, 1 HD projector
  * North Wall: 3328W x 1200H pixels, 2 blended HD projectors

## Template overview

This HTML/CSS template is intended for applications using multiple content sources (it was originally developed to facilitate simultaneous display of multiple video sources).
It provides the ability to target content to one of the 5 projection surfaces/walls (described above), with the option to further divide the surface according to the number of projectors used to display content on that wall. Each targeted area is represented in the HTML file as a \<div\> element having the CSS class 'tvl-zone'. The 'id' attribute on this div identifies the specific zone represented, and the corresponding CSS rules set the dimensions. Zones are assigned to each wall as follows:

**South wall**
* zone-1
* zone-2
* zone-3

**Southwest wall**
* zone-4

**West wall**
* zone-5
* zone-6
* zone-7

**Northwest wall**
* zone-8

**North wall**
* zone-9
* zone-10

For example, the 3 zones on the South wall can be defined as follows:

```
<div id="zone-1" class="tvl-zone"></div>
<div id="zone-2" class="tvl-zone"></div>
<div id="zone-3" class="tvl-zone"></div>
```

These can be combined to create a larger container that spans multiple smaller ones. For example, to span zone-1 and zone-2:

```
<div id="zone-1-2" class="tvl-zone">&nbsp;</div>
```

Or all 3 to combine all 3:

```
<div id="zone-1-2-3" class="tvl-zone">&nbsp;</div>
```

Each `tvl-zone` element in the template includes a data-position attribute. These are included to facilitate audio panning via HTML audio and video APIs when necessary. Values range from -1 (far left) to 1 (far right), with 0 being the center.

## Previewing content on a smaller display

To view a scaled-down version of the content on any display, include the 2 Javascript files (see the comments in the template for implementation).
