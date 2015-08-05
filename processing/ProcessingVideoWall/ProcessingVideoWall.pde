
//            FONT SIZES
/*
 **
 **  Processing template for NCSU Hunt Library Video Walls
 **  
 **  This template will help you set up your sketch properly
 **  to design a Processing sketch for the different walls in
 **  the Hunt Library space. Please go through this documentation
 **  if this is your first time creating Processing sketches
 **  for the video walls.
 **
 **  To start, set the value of the variable "_wallType", 
 **  depending on which wall you're aiming for.
 **    1 - Art wall (5760 px / 2304 px)
 **    2 - iPearl Immersion Theater (6816 px / 2240 px)
 **    3 - Commons wall (2880 px / 2400 px)
 **    4 - Visualization wall (3840 px / 1518 px)
 */
     int _wallType = 1;
/*
 **  This value determines the aspect ratio of your sketch 
 **  canvas, setting it correctly for the wall you select.
 **  All your sizes in the sketch (pixel values) should be
 **  based on the sizes defined above. The scaling will be
 **  handled by another variable, see below.
 **
 **  Next, set the value of variable "_wallScale" depending on
 **  how much you want to scale your sketch. A value of 1.00 is
 **  full resolution, a value of 0.50 is half resolution. This
 **  value will vary for different projects and should be 
 **  decided after testing on the wall. To fit the sketch internally
 **  on your screen, set the value to 0.
 */
     float _wallScale = 0.0;
/*
 **  The title of the sketch window once run will give you info
 **  about which wall is being emulated currently and at what size.
 **  
 **  The variable "_wallScale" will also determine the overall
 **  scaling for your sketch. So, for example, say you're 
 **  designing for the Art Wall, which has a resolution of
 **  5760 x 2304. Even if you set the value of "_wallScale" to
 **  a value which is not 1.0, you should still design for a 
 **  canvas that is 5760px x 2304px in size. The _wallScale
 **  variable will scale everything properly.
 **
 **  The scaling and positioning of objects in this sketch will
 **  be relative when designing on your personal monitor. So,
 **  if you're running this on a 1920x1080 monitor, and a ball
 **  appears at the center of the screen, this means that when
 **  the sketch is run on the wall, it will still appear at the 
 **  center of the screen, not at the coordinates (960, 540) which
 **  is the center of your screen. 
 **  
 **  For this reason, for instances where you would use the width 
 **  and height variables in a normal sketch (like centering on 
 **  the screen by using translate(width/2, height/2);), use the 
 **  variables "wallWidth" and "wallHeight" instead - 
 **  translate(wallWidth/2, wallHeight/2);
 **  
 **  For reference purposes, this template sketch includes some
 **  tools that will help you better understand the scaling and
 **  have a better idea of how things on your computer screen 
 **  would translate on to the video walls at the Hunt library.
 **  Also included is a simple example of a bouncing ball, which
 **  will give you a better idea of motion and how to compare
 **  speeds on your screen and on the video wall.
 **  These tools are explained below.
 **  
 **  1. MicroTile grid overlay. The grid overlay can be toggled
 **  by pressing the 'G' key on your keyboard. This overlay shows
 **  the positioning of the grid tiles, so that you can make use 
 **  of the grid and better position your elements. For the
 **  Visualization Wall, this also shows the location of the 
 **  inaccessible wall area.
 **  
 **  2. Ruler overlay. The ruler overlay can be toggled by pressing
 **  the 'R' key on your keyboard. This overlay places scales on 
 **  the four edges of your sketch. The measurements shown are 
 **  the actual measurement on the wall, in feet and pixels.
 **  This will help you accurately position elements since you 
 **  can see the location coordinates in pixels for the actual wall.
 **  
 **  3. Text overlay. This can be toggled with the 'T' key on your
 **  keyboard, and shows the coordinates of your mouse cursor.
 **  Only useful on your own computer screen for accurate
 **  positioning.
 **  
 **  4. inchToPix(N); 
 **  This function returns the pixel-value equivalent of its
 **  argument, which should be in inches. It accepts floating
 **  point numbers as arguments. The pixel density for the 
 **  different walls is different, so this is useful since
 **  measurements in inches are easier to make even without 
 **  access to the walls. For instance, each MicroTile is 
 **  1 foot in height. So, if you want to move an element 
 **  a tile and a half vertically, you can use 
 **  translate(0, inchToPix(18)); 
 **  1 foot is 12 inches, 1.5 feet is 18.
 **  
 **  5. pixToInch(N);
 **  Conversely, this function converts pixel values to inches.
 **  This accepts integer numbers as argument.
 **
 **  If you run into any trouble or need any assistance, feel 
 **  free to contact Payod at payod.panda@ncsu.edu.
 **
 **
 */

BouncingBall ballRandom;

void setup() {
    wallSetup();                // initializes the canvas with P3D rendering mode. Use P3D even if drawing a 2D sketch, for optimization.
    ellipse = createShape(ELLIPSE, 0, 0, random(inchToPix(12)), random(inchToPix(12)));
    ballRandom = new BouncingBall();
}

void draw() {
    background(255);
    scale(_wallScale);
    
    // Write your code below:
    //performance();
    ballRandom.display();
    ballRandom.update();
    
    // End code.
    
    title("Processing Responsive Template", "Payod Panda");
    //HUD();                                // This should be the last line in the draw() function, don't add anything to draw() after this.
}

