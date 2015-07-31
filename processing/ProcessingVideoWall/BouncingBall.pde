
class BouncingBall{
    PVector location, velocity, acceleration, gravity, force; 
    float mass, diameter;
    color ballColor;
    //PShape ball;
    
    BouncingBall(float m, float dia, float sx, float sy, float vx, float vy, color c){
        gravity = new PVector(0,inchToPix(386.4));
        location = new PVector(sx, sy);
        velocity = new PVector(vx, vy);
        acceleration = new PVector(0,0);
        ballColor = c;
        //ball = createShape(0, 0, rad, rad);
        diameter = dia;
        mass = m;
    }
    
    BouncingBall(){
        gravity = new PVector(0,inchToPix(386.4));
        location = new PVector(wallWidth/2, wallHeight/2);
        velocity = new PVector(inchToPix(80),inchToPix(-36));
        acceleration = new PVector(0,0);
        ballColor = color(204,0,0);
        //ball = createShape(0, 0, inchToPix(5), inchToPix(5));
        diameter = inchToPix(5);
        mass = 10;
    }
    
    void update(){
        if((location.x > wallWidth-diameter/2) || (location.x < diameter/2)){
            location.x = min(location.x, wallWidth-diameter/2);
            location.x = max(location.x, diameter/2);
            velocity.y *= 0.8;
            velocity.x *= -0.8;
        }
        if((location.y > wallHeight-diameter/2) || (location.y < diameter/2)){
            location.y = min(location.y, wallHeight-diameter/2);
            location.y = max(location.y, diameter/2);
            velocity.x *= 0.8;
            velocity.y *= -0.8;
        }
        /*location.x = location.x % wallWidth;
        location.y = location.y % wallHeight;
        if (location.x < 0) {
            location.x = wallWidth;
        }
        if (location.y < 0) {
            location.y = wallHeight;
        }*/
        location.add(PVector.div(velocity, frameRate));
        velocity.add(PVector.div(acceleration, (frameRate*frameRate)));
        velocity.add(PVector.div(gravity, (frameRate*frameRate)));
    }
    
    void display(){
        textSize(inchToPix(3));
        textAlign(CENTER, BOTTOM);
        fill(ballColor);
        noStroke();
        ellipse(location.x, location.y, diameter, diameter);
        text("The ball is now moving at " + nf(round(velocity.mag()), 6) + " pixels per second, or " + nf(pixToInch(velocity.mag()), 4, 2) + " inches per second", wallWidth/2, wallHeight/2);
        textAlign(LEFT, BASELINE);
    }
}
