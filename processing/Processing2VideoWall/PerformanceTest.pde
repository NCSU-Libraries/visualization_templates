
int level = 1, levelMax = 2;
float initialFR;
float[] eightFR = new float[levelMax], sixFR = new float[levelMax], fiveFR = new float[levelMax];
boolean[] eightSet = new boolean[levelMax], sixSet = new boolean[levelMax], fiveSet = new boolean[levelMax];
PShape ellipse;

void performance(){
    randomSeed(0);
    
    fill(0,8);
    noStroke();
    
    switch(level){
        case 0:
            for(int i = 0; i<=frameCount; i++){
                ellipse(random(wallWidth), random(wallHeight), inchToPix(random(3, 36)), inchToPix(random(3, 36)));
            }
            break;
        case 1:
            for(int i=0; i<frameCount-fiveFR[0]; i++){
                pushMatrix();
                {
                    translate(random(wallWidth), random(wallHeight));
                    shape(ellipse);
                }
                popMatrix();
            }
            break;
    }
    
    if(frameCount == 60){
        initialFR = frameRate;
    }
    switch(_wallType){
        case 1:
            textSize(inchToPix(5));
            break;
        case 2:
            textSize(inchToPix(5));
            break;
        case 3:
            textSize(inchToPix(3));
            break;
        case 4:
            textSize(inchToPix(8.1));
            break;
    }
    fill(255,0,0);
    text("Initial frame rate: " + initialFR, inchToPix(16), inchToPix(18));
    text("Currrent frame rate: " + frameRate + ", no. of ellipses = " + frameCount, inchToPix(16), inchToPix(30));
    
    if(1.0*frameRate/initialFR > 0.8){  
        eightSet[level] = false;
        sixSet[level] = false;
        fiveSet[level] = false;            
    }
    if(1.0*frameRate/initialFR <= 0.8){  
        if(!eightSet[level]){
            eightSet[level] = true;
            eightFR[level]= frameCount;
            println("0.8 = " + eightFR[level]);
        }      
        text("Number of ellipses to get frame rate to 0.8 times initial: " + eightFR[level], inchToPix(16), inchToPix(42));
    }
    if(1.0*frameRate/initialFR <= 0.6){  
        if(!sixSet[level]){
            sixSet[level] = true;
            sixFR[level]= frameCount;
            println("0.6 = " + sixFR[level]);
        }      
        text("Number of ellipses to get frame rate to 0.6 times initial: " + sixFR[level], inchToPix(16), inchToPix(54));
    }
    if(1.0*frameRate/initialFR <= 0.5){  
        if(!fiveSet[level]){
            fiveSet[level] = true;
            fiveFR[level]= frameCount;
            println("0.5 = " + fiveFR[level]);
            level++;
            level = level%levelMax;
            println(level);
        }      
        text("Number of ellipses to get frame rate to 0.5 times initial: " + fiveFR[level], inchToPix(16), inchToPix(66));
    }
    strokeWeight(1);
}
