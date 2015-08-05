

// True pixel widths and heights of walls
int[] _width = {
    5760, 6816, 2880, 3840
};
int[] _height = {
    2304, 2240, 2400, 1518
};

// True feet widths and heights of walls
float[] _widthFt = {
    20, 21.3, 12, 25.3
};
float[] _heightFt = {
    8, 7, 10, 10.0
};

// The wall names
String[] _wallNames = {
    "Art Wall", "iPearl Immersion Theater", "Commons Wall", "Visualization Wall"
};

// Grid image overlay
PImage[] _hudGridImage = new PImage[4];

int wallWidth;
int wallHeight;

void wallSetup() {
    if ((_wallType<1)||(_wallType>4)) {
        _wallType = 1;                                // default to Art Wall
    }
    wallWidth = _width[_wallType-1];                  // working wall true pixel width  
    wallHeight = _height[_wallType-1];                // working wall true pixel height
    if (_wallScale == 0) {
        if (float(wallWidth)/float(wallHeight) <= float(displayWidth)/float(displayHeight)) _wallScale = float(displayHeight)/float(wallHeight);
        if (float(wallWidth)/float(wallHeight) > float(displayWidth)/float(displayHeight)) _wallScale = float(displayWidth)/float(wallWidth);
    }
    size(int(wallWidth*_wallScale), int(wallHeight*_wallScale), P3D);
    smooth(4);
    println(_wallNames[_wallType-1]);
    println("Original width: " + wallWidth + "px");
    println("Original height: " + wallHeight + "px");
    println("Aspect ratio: " + float(width)/float(height));
    frame.setTitle("Running " + _wallNames[_wallType-1] + " emulation at " + str(width) + "px x " + str(height) + "px (scaling factor of " + _wallScale + ")");
    _hudGridImage[0] = loadImage( "images/ArtGrid.png" ); 
    _hudGridImage[1] = loadImage( "images/ImmersionGrid.png" );
    _hudGridImage[2] = loadImage( "images/CommonsGrid.png" );
    _hudGridImage[3] = loadImage( "images/VisualizationGrid.png" );
    //textMode(SHAPE);
    frameRate(60);
}

boolean _hudGrid = true, _hudText = true, _hudRuler = true;
float _hudGridTime = 0, _hudTextTime = 0, _hudRulerTime = 0;

void HUD() {
    if (keyPressed) {                                                  // To avoid using keyPressed() function to leave that function open to the user; even though 
        if (key == 'r') {                                              // realistically that function won't be used for the video walls but may be used for testing.
            if (millis() - _hudRulerTime > 200) {                      // Threshold time between key presses, without this it registered a single key stroke as multiple keystroke entries
                _hudRuler = !_hudRuler;
                _hudRulerTime = millis();
            }
        }
        if (_hudRuler && key == 't') {
            if (millis() - _hudTextTime > 200) {
                _hudText = !_hudText;
                _hudTextTime = millis();
            }
        }
        if (key == 'g') {
            if (millis() - _hudGridTime > 200) {
                _hudGrid = !_hudGrid;
                _hudGridTime = millis();
            }
        }
    }

    if (_hudGrid) {
        image(_hudGridImage[_wallType-1], 0, 0, wallWidth, wallHeight);
    }
    if (_hudRuler) {
        stroke(164);
        fill(164);
        textSize(inchToPix(2));
        for (int i=0; i<=_widthFt[_wallType-1]; i++) {
            textAlign(LEFT, TOP);
            if (i>0) {
                fill(192);
                text(i, 10+wallWidth*i/_widthFt[_wallType-1], 50);
            } else {
                fill(128);
                textAlign(LEFT, TOP);
                text("ft", 25, 25);
            }
            line(wallWidth*i/_widthFt[_wallType-1], 0, wallWidth*i/_widthFt[_wallType-1], inchToPix(4));
            line(wallWidth*(i+0.5)/_widthFt[_wallType-1], 0, wallWidth*(i+0.5)/_widthFt[_wallType-1], inchToPix(2));
        }
        for (int i=0; i<=_heightFt[_wallType-1]; i++) {
            textAlign(LEFT, TOP);
            if (i>0) {
                fill(192);
                text(i, inchToPix(2), 10+wallHeight*i/_heightFt[_wallType-1]);
            } 
            line(0, wallHeight*i/_heightFt[_wallType-1], inchToPix(4), wallHeight*i/_heightFt[_wallType-1]);
            line(0, wallHeight*(i+0.5)/_heightFt[_wallType-1], inchToPix(2), wallHeight*(i+0.5)/_heightFt[_wallType-1]);
        }
        for (int i=0; i<=_width[_wallType-1]; i+=100) {
            if (i==0) {
                fill(128);
                textAlign(RIGHT, BOTTOM);
                text("px", wallWidth - inchToPix(1), wallHeight - inchToPix(1));
            }
            if (i%100==0 && i>=100) {
                if (i%500 == 0) {
                    fill(192);
                    textAlign(LEFT, BOTTOM);
                    text(i, 10+i, wallHeight-inchToPix(2));
                    line(i, wallHeight-inchToPix(4), i, wallHeight);
                } else {
                    if (i<=wallWidth-100) line(i, wallHeight-inchToPix(2), i, wallHeight);
                }
            }
        }
        for (int i=0; i<=_height[_wallType-1]; i+=100) {
            textAlign(RIGHT, TOP);
            if (i%500==0 && i>=100 && i<=wallHeight-100) {
                fill(192);
                text(i, wallWidth-inchToPix(2), 10+i);
                line(wallWidth-inchToPix(4), i, wallWidth, i);
            } else {
                if (i<=wallHeight-100) line(wallWidth-inchToPix(2), i, wallWidth, i);
            }
        }
        stroke(0);
        line(0, mouseY/_wallScale, inchToPix(4), mouseY/_wallScale);
        line(mouseX/_wallScale, 0, mouseX/_wallScale, inchToPix(4));
        line(wallWidth-inchToPix(4), mouseY/_wallScale, wallWidth, mouseY/_wallScale);
        line(mouseX/_wallScale, wallHeight-inchToPix(4), mouseX/_wallScale, wallHeight);
    }
    if (_hudRuler && _hudText) {
        textSize(inchToPix(3));
        textAlign(LEFT, TOP);
        fill(128);
        strokeWeight(1/_wallScale);
        text("(" + nf((_widthFt[_wallType-1]*mouseX/width), 2, 2) + ", "+ nf((_heightFt[_wallType-1]*mouseY/height), 2, 2) +") ft", inchToPix(2.75) + mouseX/_wallScale, mouseY/_wallScale + inchToPix(0.0) );
        text("("+(_width[_wallType-1]*mouseX/width)+", "+(_height[_wallType-1]*mouseY/height)+") px", inchToPix(2.75) + mouseX/_wallScale, mouseY/_wallScale + inchToPix(4.5));
    }
    textAlign(LEFT, TOP);
    textSize(inchToPix(2));
    text(round(frameRate) + " FPS", wallWidth - inchToPix(15), wallHeight - inchToPix(23));
    textAlign(LEFT, BASELINE);
}

int inchToPix(float inch) {
    int pixel = round(inch * wallWidth / (12 * _widthFt[_wallType-1]));
    return pixel;
}

float pixToInch(float pix) {
    float inch = pix * (12 * _widthFt[_wallType-1]) / wallWidth;
    return inch;
}

void _debug(){
    
    frame.setTitle("Running " + _wallNames[_wallType-1] + " emulation at " + str(width) + "px x " + str(height) + "px (scaling factor of " + _wallScale + ")                    " + frameRate + " FPS");
}


