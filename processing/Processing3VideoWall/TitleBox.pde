
float _titleStartTime, _titleCurrentTime;
float _titleOpacity;                 // _titleOpacity controls if the title will be displayed or not. Opacity controlled by time.
boolean _titleFadeIn = false, _titleFadeOut = false;

void title(String title, String auth) {
    float fadeTime = 5000, interval = 300000;                    // default fade-out time is 5 seconds, and interval between title box displays is 5 minutes = 300,000 milliseconds.
    defineOpacity(fadeTime, interval);
    displayTitle(title, auth);
}
void title(String title, String auth, float fadeTime) {
    float interval = 300000;                                     // default interval = 5 minutes
    defineOpacity(fadeTime * 1000, interval);
    displayTitle(title, auth);
}
void title(String title, String auth, float fadeTime, float interval) { 
    defineOpacity(fadeTime * 1000, interval * 1000);            // convert from milliseconds to seconds
    displayTitle(title, auth);
}

void defineOpacity(float fadeTime, float interval){

    if (frameCount==1) {            // when first frame is drawn. Important because fade time should start from here rather than from the initiation time
        _titleStartTime = millis();
        _titleOpacity = 255;
    }
    
    _titleCurrentTime = millis() - _titleStartTime;

    if (floor((_titleCurrentTime + 1000)/1000) % ((interval + 1000)/1000) == 0) {            // this fades in the title _titleOpacity every "interval" number of milli seconds. +1000 on both _titleCurrentTime and interval to compensate for stuck loop
        _titleStartTime = millis();
        _titleCurrentTime = millis() - _titleStartTime;
        _titleFadeIn = true;
    }

    if (_titleCurrentTime >= fadeTime) {                // this fades out the _titleOpacity
        _titleFadeOut = true;        
    }
    
    if(_titleFadeIn){
        _titleOpacity += 0.05 * _titleCurrentTime;
        if (_titleOpacity >= 255) {
            _titleOpacity = 255;
            _titleFadeIn = false;
        }
    }
    
    if (_titleFadeOut){
        _titleOpacity -= 0.005 * (_titleCurrentTime - fadeTime);
        if (_titleOpacity <= 0) {
            _titleOpacity = 0;
            _titleFadeOut = false;
        }
    }
        
    //println(_titleCurrentTime + " and " + _titleOpacity );        // debug - to check values in console
    
    
}

void displayTitle(String title, String auth){

   /**********************************************************************************
    ***           THIS IS WHERE YOU CAN DESIGN YOUR OWN TITLE TEXT BOX             ***
    **********************************************************************************/
    
    color bgcolor = color(204, 0, 0, _titleOpacity);
    color textcolor = color(255, _titleOpacity);
    textSize(inchToPix(4));
    textAlign(LEFT, BASELINE);
    textMode(SHAPE);                       // for better quality text - title is important!
    if (_titleOpacity > 0) {
        switch(_wallType) {                // check which wall you've chosen
        case 1:                            // art wall
            fill(bgcolor);
            noStroke();
            rect(0, inchToPix(72), wallWidth, inchToPix(12));
            fill(textcolor);
            text(title, inchToPix(18), inchToPix(77.5));
            textSize(inchToPix(3));
            text(auth, inchToPix(18), inchToPix(81.5));
            break;
        case 2:                            // immersion theater
            fill(bgcolor);
            noStroke();
            rect(0, inchToPix(60), wallWidth, inchToPix(12));
            fill(textcolor);
            text(title, inchToPix(18), inchToPix(65.5));
            textSize(inchToPix(3));
            text(auth, inchToPix(18), inchToPix(69.5));  
            break;      
        case 3:                            // commons wall
            fill(bgcolor);
            noStroke();
            rect(0, inchToPix(96), wallWidth, inchToPix(12));
            fill(textcolor);
            text(title, inchToPix(18), inchToPix(101.5));
            textSize(inchToPix(3));
            text(auth, inchToPix(18), inchToPix(105.5));
            break;
        case 4:                            // visualization wall
            fill(bgcolor);
            noStroke();
            rect(inchToPix(48), inchToPix(0), inchToPix(33), wallHeight);
            fill(textcolor);
            textSize(inchToPix(4.5));
            textLeading(inchToPix(5.4));
            text(title, inchToPix(51), inchToPix(17.5), inchToPix(27), inchToPix(60));
            textSize(inchToPix(3));
            text(auth, inchToPix(51), inchToPix(38.5), inchToPix(27), inchToPix(60));
            break;
        }
    }
    textMode(MODEL);            // back to default for better performance
}
