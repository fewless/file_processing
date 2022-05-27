void leftDraw(int numOfNemu, int leftWindowHeight) { //<>//
  leftMenu.beginDraw();
  leftMenu.textAlign(CENTER);
  leftMenu.rect(0, 0, leftMenu.width-2, leftMenu.height-2);
  int widthAj= 4;//文字の高さ調整
  int heightAj= -3;//文字の高さ調整
  for (int i = 0; i<numOfNemu; i++) {
    leftMenu.fill(255);
    leftMenu.rect(0, leftWindowHeight*i, 100-2, leftWindowHeight*(1+i));//100*30ごと項目
    leftMenu.fill(0);
    switch(i) {
    case 0:
      leftMenu.text("rename", leftMenu.width/2 +widthAj, leftWindowHeight*(i+1) +heightAj);
      break;
    case 1:
      leftMenu.text("remove edge", leftMenu.width/2 +widthAj, leftWindowHeight*(i+1) +heightAj);
      break;
    case 2:
      leftMenu.text("rescale", leftMenu.width/2 +widthAj, leftWindowHeight*(i+1) +heightAj);
      break;
    case 3:
      leftMenu.text("edge", leftMenu.width/2 +widthAj, leftWindowHeight*(i+1) +heightAj);
      break;
    case 4:
      leftMenu.text("delete", leftMenu.width/2 +widthAj, leftWindowHeight*(i+1) +heightAj);
      break;
    }
  }
  leftMenu.endDraw();
}

void leftDraw2(int numOfNemu, int leftWindowHeight) {//複数選択時の右クリック
  leftMenu2.beginDraw();
  leftMenu2.textAlign(CENTER);
  leftMenu2.rect(0, 0, leftMenu2.width-2, leftMenu2.height-2);

  for (int i = 0; i<numOfNemu; i++) {
    leftMenu2.fill(255);
    leftMenu2.rect(0, leftWindowHeight*i, 100-2, leftWindowHeight*(1+i));//100*30ごと項目
    leftMenu2.fill(0);
    switch(i) {
    case 0:
      leftMenu2.text("make group", leftMenu2.width/2, leftWindowHeight*(i+1));
      break;
    case 1:
      leftMenu2.text("regroup", leftMenu2.width/2, leftWindowHeight*(i+1));
      break;
    case 2:
      leftMenu2.text("edge", leftMenu2.width/2, leftWindowHeight*(i+1));
      break;
    case 3:
      leftMenu2.text("delete", leftMenu2.width/2, leftWindowHeight*(i+1));
      break;
    }
  }
  leftMenu2.endDraw();
}

void leftDraw3(int numOfNemu, int leftWindowHeight) {//グループ選択時の右クリック
  leftMenu3.beginDraw();
  leftMenu3.textAlign(CENTER);
  leftMenu3.rect(0, 0, leftMenu3.width-2, leftMenu3.height-2);

  for (int i = 0; i<numOfNemu; i++) {
    leftMenu3.fill(255);
    leftMenu3.rect(0, leftWindowHeight*i, 100-2, leftWindowHeight*(1+i));//100*30ごと項目
    leftMenu3.fill(0);
    switch(i) {
    case 0:
      leftMenu3.text("rename", leftMenu3.width/2, leftWindowHeight*(i+1));
      break;
    case 1:
      leftMenu3.text("break", leftMenu3.width/2, leftWindowHeight*(i+1));
      break;
    case 2:
      leftMenu3.text("edge delete", leftMenu3.width/2, leftWindowHeight*(i+1));
      break;
    case 3:
      leftMenu3.text("delete", leftMenu3.width/2, leftWindowHeight*(i+1));
      break;
    }
  }
  leftMenu3.endDraw();
}


int HMLoading = 0;
int loadCount=1;
void barDraw() {
  loadingBar.beginDraw();
  loadingBar.textAlign(CENTER);
  loadingBar.fill(250, 240);
  loadingBar.textAlign(CENTER);
  loadingBar.rect(0, 0, loadingBar.width-2, loadingBar.height-2);
  loadingBar.fill(10);
  loadingBar.textSize(25);
  loadingBar.text("image loading", loadingBar.width/2, loadingBar.height/4);
  loadingBar.fill(255);
  loadingBar.endDraw();
}

void warningDraw() {
  warning.beginDraw();
  warning.textAlign(CENTER);
  warning.fill(250, 240);
  warning.textAlign(CENTER);
  warning.rect(0, 0, warning.width-2, warning.height-2);
  warning.fill(10);
  warning.textSize(25);
  warning.text("!!warning!!", warning.width/2, warning.height/4+10);
  warning.text("you can use only PNG, JPG, GIF", warning.width/2, warning.height/4+35);
  warning.fill(255);
  warning.endDraw();
}

void crossDraw() {
  cross.beginDraw();
  cross.pushMatrix();
  cross.rectMode(CORNERS);
  cross.noStroke();
  cross.fill(255);
  cross.translate(25, 25);
  cross.rotate(PI/4);
  cross.rect(-25, -5, 25, 5);
  cross.rotate(PI/2);
  cross.rect(-25, -5, 25, 5);
  cross.popMatrix();
  cross.endDraw();
}

void statusDraw() {
  statusBar.beginDraw();
  statusBar.fill(240);
  statusBar.rect(-1, -1, width+1, statusBar.height);
  statusBar.textSize(18);
  statusBar.fill(0);
  statusBar.textAlign(LEFT,TOP);
  statusBar.text("Group", 10, 0);
  statusBar.text("Field", 170, 0);
  statusBar.line(220,0,220,30);
  statusBar.strokeWeight(2);
  statusBar.line(160,0,160,30);
  statusBar.endDraw();
}

void loading() {
  imageMode(CENTER);
  textAlign(CENTER);
  rectMode(CENTER);
  image(loadingBar, width/2, height/2);
  if (warningError)
    image(warning, width/2, height*3/4);
  fill(10);
  textSize(25);
  text(loadCount+"/"+HMLoading, width/2, height*6/11+20);
  fill(255);
  noStroke();
  pushMatrix();
  translate(width/2, height*6/11-35);

  rotate(PI/4*int((frameCount%40)/5));
  for (int i=0; i<8; i++) {
    fill(55, 35*i);
    rotate(PI/4);
    rect(0, 10, 5, 15);
  }


  textSize(12);
  popMatrix();
  rectMode(CORNERS);
  textAlign(CENTER);
  imageMode(CORNER);
}