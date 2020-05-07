/*
  developer: Milan Rai
  git-hub:
  date: 07-05-2020
*/

int[][] mapBlock = {
 {0, 0, 0},
 {0, 0, 0},
 {0, 0, 0}
};
int player = 1;
boolean gameCompleted = false;
String winner = "none";

void setup(){
  size(300, 300);
  background(255);
  frameRate(100);
  smooth(4);
}

void draw(){
  drawGrids();
  ticktac();
  if(gameCompleted){
    textSize(20);
    stroke(#FF0000);
    fill(#FF0000);
    text(winner, 70, 150);
    noStroke();
    noFill();
  }
}


// function to draw the grids
void drawGrids( ){
  for(int i=1;i<=2;i++){
    stroke(0);
    strokeWeight(1);
    line(0, 100*i, 300, 100*i);
    noStroke();
  }
   for(int i=1;i<=2;i++){
    stroke(0);
    strokeWeight(1);
    line(100*i, 0, 100*i, 300);
    noStroke();
  }
}


void ticktac(){
  //search each block and draw cross and circle at correct block
  for(int y=0; y<3;y++){
    for(int x=0; x<3; x++){
      if(mapBlock[x][y] == 2)drawCircle(x, y);
      else if(mapBlock[x][y] == 1)drawCross(x, y);
    }
  }
}

// draw circle function
void drawCircle(int x, int y){
  stroke(0);
  strokeWeight(1);
  ellipseMode(CENTER);
  fill(255);
  ellipse((100*x)+50, (100*y)+50, 70, 70);
  noFill();
  noStroke();
}

//draw cross funtion
void drawCross(int x, int y){
  stroke(0);
  strokeWeight(.8);
  line((100*x)+20, (100*y)+20,(100*x+100-20), (100*y+100-20));
  line(100*x+20, 100*y+100-20, 100*x+100-20, 100*y+20);
  noStroke();
}

// this funtion scans and searches through the entire Block of array to search similaity
// across the vertiacal cross and horozontal cross
int gameResult(int x, int y){
  //checks if player 1 has scored
  if((mapBlock[0][y]==1)&&(mapBlock[1][y]==1)&&(mapBlock[2][y]==1)) return 1;
  else if((mapBlock[x][0]==1)&&(mapBlock[x][1]==1)&&(mapBlock[x][2]==1)) return 1;
  else if((mapBlock[0][0]==1)&&(mapBlock[1][1]==1)&&(mapBlock[2][2]==1)) return 1;
  else if((mapBlock[0][2]==1)&&(mapBlock[1][1]==1)&&(mapBlock[2][0]==1)) return 1;
  //checks if player  2 has scored
  if((mapBlock[0][y]==2)&&(mapBlock[1][y]==2)&&(mapBlock[2][y]==2)) return 2;
  else if((mapBlock[x][0]==2)&&(mapBlock[x][1]==2)&&(mapBlock[x][2]==2)) return 2;
  else if((mapBlock[0][0]==2)&&(mapBlock[1][1]==2)&&(mapBlock[2][2]==2)) return 2;
  else if((mapBlock[0][2]==2)&&(mapBlock[1][1]==2)&&(mapBlock[2][0]==2)) return 2;
  
  return 0;
}

// mouse click handle fucntion
void mouseClicked(){
  float xCor= mouseX;
  float yCor= mouseY;
  
  // map and scan through the entire grid to find the clicked grid
  if(player == 1){
    for(int y=0; y<3; y++){
      for(int x=0; x<3; x++){
        if((100*x<xCor)&&(xCor<100*(x+1))&&(100*y<yCor)&&(yCor<100*(y+1))&&(mouseButton == LEFT)){
          if((mapBlock[x][y] == 0)&&(!gameCompleted)){
            mapBlock[x][y]=1;
            if((gameResult(x, y)==1)){
              winner = "Winner is player 1\n";
              gameCompleted = true;
              ticktac();
            }
            player= 2;
            break;
          }else{
            print("invalid click!\n");
          }
        }
      }
    }
  }
  else if(player == 2){
    for(int y=0; y<3; y++){
      for(int x=0; x<3; x++){
        if((100*x<xCor)&&(xCor<100*(x+1))&&(100*y<yCor)&&(yCor<100*(y+1))&&(mouseButton == LEFT)){
          if((mapBlock[x][y] == 0)&&(!gameCompleted)){
            mapBlock[x][y]=2;
            if(gameResult(x, y)==2){
              winner = "Winner is player 2\n";
              gameCompleted = true;
              ticktac();
            }
            player= 1;
            break;
          }else{
            print("invalid click!\n");
          }
        }
      }
    }
  } 

}
