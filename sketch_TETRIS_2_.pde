int i, j, k, timeBuff, puntaje = 0, contador, a = 0;
int malla[][]= new int[12][21];  
int currentPos[] = new int[2];
Tetromino current = new Tetromino();

///////////////////////////////////////////////////////////////////

void setup() {
  size(300, 400);
  current = new Tetromino();
  currentPos[0] = 4;
  currentPos[1] = 2;
}  // Fin setup

   
  //---- ACCIONES TECLADO ----

void keyPressed(){
  if(keyCode == 37){     // Flecha izquierda
    boolean stop = false;
    for(i = 0; i < 4; i++){
      if((current.getShapeX(i)+currentPos[0]) > 0){
        if((current.getShapeX(i)+currentPos[0]) < 9 && (current.getShapeY(i)+currentPos[1]) > 0 && (current.getShapeY(i)+currentPos[1]) > 19){ 
          if(malla[(current.getShapeX(i)+currentPos[0])+1][(current.getShapeX(i)+currentPos[0])] != 0 ) stop = true; 
        }
      }
      else stop = true;   
    }
    if(!stop)  currentPos[0]--; 
  }
  
  if(keyCode == 38){     // Flecha arriba 
    current.rot();
    if((current.getMinX()+currentPos[0]) < 0)   currentPos[0]-=(current.getMinX()+currentPos[0]);     
    if((current.getMaxX()+currentPos[0]) > 9)   currentPos[0]-=(current.getMinX()+currentPos[0])-9;  
    if((current.getMinY()+currentPos[1]) < 0)   currentPos[1]-=(current.getMinY()+currentPos[0]);    
    if((current.getMaxY()+currentPos[1]) > 19)  currentPos[1]-=(current.getMaxY()+currentPos[0])-19; 
  }
  
  if(keyCode == 39){    // Flecha derecha
    boolean stop = false;
    for(i = 0; i < 4; i++){
      if((current.getShapeX(i)+currentPos[0]) < 9){
        if((current.getShapeX(i)+currentPos[0]) > 0 && (current.getShapeY(i)+currentPos[1]) > 0 && (current.getShapeY(i)+currentPos[1]) > 19){ 
          if(malla[(current.getShapeX(i)+currentPos[0])+1][(current.getShapeX(i)+currentPos[0])] != 0 ) stop = true; 
        }
      }
      else stop = true;   
    }
    if(!stop) currentPos[0]++; 
  }
 
  if(keyCode == 40){    // Flecha abajo
    currentPos[1]++;
    verificaMalla();
  }
  
} // Fin keyPressed()

  //---- ACCIONES DE MOUSE ----
void mousePressed(){
 if (mouseX > 140 && mouseX < 180 && mouseY>340 && mouseY <350) exit();
 if (mouseX > 0 && mouseY > 0) a = 1;
 } 

    //--//--//--//--//
    
void draw() {
    background(0);   
    inicio();
    if(a == 1){
      background(0);   
  // -------- CUADRICULA DE JUEGO ---------------- 
      noStroke();
      fill(150, 150, 150);
      for(i = 0; i < 10; i++){
        for(j = 0; j < 20; j++){
          if(malla[i][j] == 0) fill(100);
          else if(malla[i][j] == 1) fill(50, 150, 225);
          else if(malla[i][j] == 2) fill(0, 0, 255);
          else if(malla[i][j] == 3) fill(255, 150, 0);
          else if(malla[i][j] == 4) fill(255, 255, 0);
          else if(malla[i][j] == 5) fill(100, 255, 0);
          else if(malla[i][j] == 6) fill(0, 255, 255);
          else fill(255, 0 , 0);
          rect(i*15+40, j*15+40, 13, 13 );
        }
      }
      
      displayCurrent();
      
      timeBuff++;
      if(timeBuff > 40){
        timeBuff = 0;
        currentPos[1]++; 
      }
      
      verificaMalla();
      
      fill(255);
      text("SALIR ", 140, 350);
      text("Puntaje: " + puntaje, 25, 350);
      }
  
}; // Fin draw

/////////////////////////////////////////////////////////////////////

//------------ PANTALLA INICIO --------

void inicio(){
  background(255, 0, 0);
  fill(0, 200);
  rect(0, 0, width, height);
  fill(255);
  textFont(createFont("Curier", 30));
  text("TETRIS", 100, 200);
  textFont(createFont("Curier", 15));
  text("(Haga clic para iniciar)", 70, 230);
}


//------------ PIERDE() ---------------
void pierde(){
  fill(0, 200);
  rect(0, 0, width, height);
  fill(255);
  text("Puntaje: "+ puntaje, 25, 350);
  text("GAME OVER", 70, 200);
  noLoop();
}

//--------- VERIFICA CUADRICULA -------------------
void verificaMalla(){
  boolean stop = false;
    for(i = 0; i < 4; i++) {
      if((current.getShapeY(i)+currentPos[1]) < 19) {
        if(malla[(current.getShapeX(i)+currentPos[0])][(current.getShapeY(i)+currentPos[1])+1 ] != 0 ) stop = true;  
      } else stop = true;
    }
    if (stop){
      for(i = 0; i < 4; i++) {        
        if((current.getShapeY(i)+currentPos[1]) < 0) {
          pierde();
        }
        else malla[(current.getShapeX(i)+currentPos[0])][(current.getShapeY(i)+currentPos[1])] = current.getColor(); 
      }
      contador = 0;
      for(int y = 0; y < 20; y++){
        boolean destruye = true;
        for (int x = 0; x < 10; x++){
          if(malla[x][y] == 0) destruye = false;
        }
        if(destruye) {
          contador++;
          for(int y2 = y-1; y2 > -1; y2--){
            for(int x = 0; x < 10; x++){
              malla[x][y2+1] = malla[x][y2];  
            }
          }
        } 
      }      
      if(contador > 0){
         if(contador == 1) puntaje+=10;
         else if(contador == 2) puntaje+=20;
         else if(contador == 3) puntaje+=30;
         else puntaje+=100;   
      }
      
      current = new Tetromino();
      
      currentPos[0] = 4;
      currentPos[1] = 0;
      
      
      for(i = 0; i < 4; i++){ 
        if((current.getShapeY(i)+currentPos[1]) < 19){
          if((current.getShapeX(i)+currentPos[0]) < 9 && (current.getShapeY(i)+currentPos[1]) > 0 && (current.getShapeY(i)+currentPos[1]) > 19){ 
            if(malla[(current.getShapeX(i)+currentPos[0])][(current.getShapeY(i)+currentPos[1])+1] != 0 ) pierde();
          }
        }
      }
    }
} // Fin verificaMalla


//--------- CAMBIA COLOR Y CENTRA ----------------------
void displayCurrent(){
  fill(255);
  for (i=0; i < 4; i++){
    rect((current.getShapeX(i)+currentPos[0])*15+40, (current.getShapeY(i)+currentPos[1])*15+40, 13, 13 );
  }
} // Fin displayCurrent 

// --------  GENERA FIGURAS  ---------
class Tetromino {
  int shape[][] = new int[4][2];
  int col = 0;
  public Tetromino() {
    col = int(random(1,8));
    if(col == 1) {
      shape[1][0] = 1;
      shape[2][0] = -1;
      shape[3][0] = -2;
    }
    else if(col == 2) {
      shape[1][0] = 1;
      shape[2][0] = -1;
      shape[3][0] = -1;
      shape[3][1] = -1;
    }
    else if(col == 3) {
      shape[1][0] = 1;
      shape[2][0] = -1;
      shape[3][0] = -1;
      shape[3][1] = -1;      
    }
    else if(col == 4) {
      shape[1][0] = 1;
      shape[2][1] = 1;
      shape[3][0] = 1;
      shape[3][1] = 1;
    }
    else if(col == 5) {
      shape[1][0] = -1;
      shape[2][1] = -1;
      shape[3][0] = -1;
      shape[3][1] = -1;
    }
    else if(col == 6) {
      shape[1][0] = -1;
      shape[2][0] = -1;
      shape[3][1] = 1;
    }
    else {
      shape[1][0] = 1;
      shape[2][1] = -1;
      shape[3][0] = 1;
      shape[3][1] = -1;
    }
  }  //Fin Tetromino()
  
// ----- ROTACION DE FIGURAS -------------------
  public void rot() {
    for(i = 0; i < 4; i++) {
      int buff = shape[i][0];
      shape[i][0] = shape[i][1];
      shape[i][1] = -buff;
    }
  }
  
// ------------ VALORES DE FRONTERA ------------
  public int getShapeX(int i) {
    return shape[i][0];
  }
  
  public int getShapeY(int i) {
    return shape[i][1];
  }
  
// -------- VALROES MAX, MIN DE X -----------
  public int getMaxX() {
    i = 0;
    for (j = 0; j < 4; j++){
      if (shape[j][0] > shape[i][0])  i=j;
    }
    return shape[i][0];
  }
  public int getMinX() {
    i = 0;
    for (j = 0; j < 4; j++) {
      if(shape[j][0] < shape[i][0])  i=j;
    }
    return shape[i][0];
  } 
// --------- VALROES MAX, MIN DE Y ----------
  public int getMaxY() {
    i = 0;
    for (j = 0; j < 4; j++) {
      if (shape[j][1] > shape[i][1])  i=j;
    }
    return shape[i][1];
  }
  public int getMinY() {
    i = 0;
    for (j = 0; j < 4; j++) {
      if(shape[j][1] < shape[i][1])  i=j;
    }
    return shape[i][1];
  }

  public int getColor() {return col;}

} // FIn class Tetromino
