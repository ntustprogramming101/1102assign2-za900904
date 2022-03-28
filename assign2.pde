
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
final int LIFE0 = 5;
final int LIFE1 = 6;
final int LIFE2 = 7;
final int LIFE3 = 8;
final int ORIGINAL = 9;
final int STAY = 10;
final int GO_DOWN = 11;
final int GO_LEFT = 12;
final int GO_RIGHT = 13;



PImage sky;
PImage soil;
PImage groundhog;
PImage groundhogDown;
PImage groundhogLeft;
PImage groundhogRight;
PImage life;
PImage soldier;
PImage robot;
PImage title;
PImage restartNormal;
PImage restartHovered;
PImage startHovered;
PImage startNormal;
PImage cabbage;
PImage gameover;



int piece =80;
int robotX =floor(random(160,561));
int robotY = piece*2+floor(random(4))*piece;
int soldierX;
int soldierY = piece*2+floor(random(4))*piece;
int laserSpeedX = robotX +25;
int laserX;
int laserY = robotY + 37;
int restartNormalWidth = 144;
int restartNormalHeight = 60;
int groundhogX = 320;
int groundhogY = 80;
float walkY = 0;
float walkX = 0;
int cabbageX = floor(random(8))*piece;
int cabbageY = piece*2+floor(random(4))*piece;
int life3X = -80;
int life2X = 70;
int life1X = 10;
int lifeAmount = ORIGINAL;
int walk = STAY;
int frame = 0;

boolean life1;
boolean life2;
boolean life3;
/*boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;
*/
int state = GAME_START;


void setup() {
  size(640, 480, P2D);
  // Enter Your Setup Code Here
  
  frameRate(60);
  title = loadImage("img/title.jpg");
  sky = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  groundhog = loadImage("img/groundhog.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  life = loadImage("img/life.png");
  soldier = loadImage("img/soldier.png");
  robot = loadImage("img/robot.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  cabbage = loadImage("img/cabbage.png");
  gameover = loadImage("img/gameover.jpg");
  startHovered = loadImage("img/startHovered.png");
  startNormal = loadImage("img/startNormal.png");
}

void draw() {
  // Switch Game State
  switch(state){
    
  //game start
    case GAME_START:
      //mouse normal
      image(title,0,0);
      image(startNormal,248,360);
      if(mouseX >248 && 
         mouseX< 248 + restartNormalWidth && 
         mouseY > 360 && 
         mouseY < 360 + restartNormalHeight){
          image(startHovered,248,360);
      } 
      
      //mouse pressed
      if(mouseX >248 && 
         mouseX< 248 + restartNormalWidth && 
         mouseY > 360 && 
         mouseY < 360 + restartNormalHeight&&
         mousePressed){
         state = GAME_RUN;
         }
    break;


    // Game Run
    case GAME_RUN:
      
      //background
        image(sky,0,0); 
        image(soil,0,piece*2); //sky
        
        noStroke();
        fill(124,204,25);
        rect(0,145,640,15); //grass
        
        fill(255,255,0);
        ellipse(590,50,130,130);
        fill(253,184,19);
        ellipse(590,50,120,120); //sun
      
        if(cabbageX == (groundhogX + walkX) && cabbageY == (groundhogY + walkY)){
             cabbageX = -80;
             cabbageY = -80;
  }
        image(cabbage,cabbageX,cabbageY); //cabbage
        
        //life
        
        switch(lifeAmount){
         
         case ORIGINAL:
           image(cabbage,cabbageX,cabbageY);
           life3X = -80;
           life2X = 70;
           life1X = 10;
           image(life,life3X,10);
           image(life,life2X,10);
           image(life,life1X,10);
          
           if(cabbageX == -80){
           cabbageX = -90;
           lifeAmount = LIFE3;
           }
          
          if(life3X == -80 &&
             soldierX-80 < groundhogX + walkX &&
             soldierX+120 > 80+groundhogX + walkX&&
             soldierY == groundhogY + walkY){
          life2X = -80;
          walkX = 0;
          walkY = 0;
          lifeAmount = LIFE1;
             }

        break; //life original (2 life)
        
        case LIFE3:
          life3X = 130;
          image(life,life3X,10);
          image(life,life2X,10);
          image(life,life1X,10);
  
          if(soldierX-80 < groundhogX + walkX &&
             soldierX+120 > 80+groundhogX + walkX&&
             soldierY == groundhogY + walkY){
          walkX = 0;
          walkY = 0;
          life3X = -80;
          lifeAmount = LIFE2;
          }

        break; // 3 life to 2 life
         
        case LIFE2:
           life3X = -80;
           life2X = 70;
           life1X = 10;
           image(life,life3X,10);
           image(life,life2X,10);
           image(life,life1X,10);
          
          if(cabbageX == -80){
          cabbageX = -90;
          lifeAmount = LIFE3; //2 life to 3 life
          }
          
          if(life3X == -80 &&
             soldierX-80 < groundhogX + walkX &&
             soldierX+120 > 80+groundhogX + walkX&&
             soldierY == groundhogY + walkY){
          life2X = -80;
          walkX = 0;
          walkY = 0;
          lifeAmount = LIFE1; // 2 life to 1 life
          }
          break; 
          
        case LIFE1:
          image(life,life3X,10);
          image(life,life2X,10);
          image(life,life1X,10);
          if(life2X == -80 &&
             soldierX-70 < groundhogX + walkX &&
             soldierX+120 > 80+groundhogX + walkX&&
             soldierY == groundhogY + walkY){
          life1X = -80; 
          lifeAmount = LIFE0; // 1 life to 0 life
          }
          
          if(cabbageX == -80){
            cabbageX = -90;
          lifeAmount = LIFE2; // 1 life to 2 life
          }
        break;
         
        case LIFE0:
          state = GAME_OVER; // game over
        break;
       }
        

        soldierX =soldierX +2;
        if(soldierX >width){
          soldierX=-piece;
        }
        image(soldier,soldierX,soldierY); //soldier
        

        if(frame<=15){

        frame = frame +1;
          switch(walk){
            case GO_DOWN:
            walkY= walkY + round(80/15);
            break;
            case GO_LEFT:
            walkX = walkX - round(80/15);
            break;
            case GO_RIGHT:
            walkX = walkX + round(80/15);
            break;
          }
         }
         else{
          walk=STAY;
          }
          
        
        switch(walk){
          
        case STAY:
        image(groundhog,groundhogX + walkX,groundhogY + walkY); //groundhog
        break;
        
        case GO_DOWN:
        image(groundhogDown,groundhogX + walkX,groundhogY + walkY);
        break;
        
        case GO_RIGHT:
        image(groundhogRight,groundhogX + walkX,groundhogY + walkY);
        break;
        
        case GO_LEFT:
        image(groundhogLeft,groundhogX + walkX,groundhogY + walkY);
        break;
        }

        if(groundhogY + walkY > 400){
          walkY = 320;
        }
        if(groundhogY + walkY < 80){
          walkY = 0;
        }
        if(groundhogX + walkX > 560){
          walkX = 240;
        }
        if(groundhogX + walkX < 0){
          walkX = -320;
        }
        

      
    break;
  
        
    // Game Lose
    
    case GAME_OVER:
    image(gameover,0,0);
    image(restartNormal,248,360);
    if(mouseX >248 && 
       mouseX< 248 + restartNormalWidth && 
       mouseY > 360 && 
       mouseY < 360 + restartNormalHeight){
     image(restartHovered,248,360); //restart mouse
    }
    
    if(mouseX >248 && 
       mouseX< 248 + restartNormalWidth && 
       mouseY > 360 && 
       mouseY < 360 + restartNormalHeight&&
       mousePressed){
       state = GAME_RUN;  
       lifeAmount = ORIGINAL;
       walkX = 0;
       walkY = 0;
       cabbageX = floor(random(8))*piece;
       cabbageY = piece*2+floor(random(4))*piece; //mouse pressed & restart
     } 
    break;
  }
}

void keyPressed(){
  
  if(walk == STAY){
    frame = 0;
  switch(keyCode){
    
    case DOWN:
    walk = GO_DOWN;
    
    break;
    
    
    case LEFT:
    walk = GO_LEFT;
    break;
    
    case RIGHT:
    walk =GO_RIGHT;
    break;
    
    
  }
  }
}
