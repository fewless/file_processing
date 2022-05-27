boolean areaNoPiece = true;//areaとpiece trueでarea

void anytimeMouse(){
  if(0<=mouseX && mouseX <= 70 && 0<=mouseY && mouseY <=30)//groupトグル
    groupActive = !groupActive;
  
  println(mouseX + " " + mouseY );
  if(90<=mouseX && mouseX <= 200 && 0<=mouseY && mouseY <=30)//areaNoPieceトグル
    areaNoPiece = !areaNoPiece;
}

void keyAnytime(){
  if((keyCode == 'g' || keyCode == 'G') && mode != 2)//gキー押下かつ入力中でない
    groupActive = !groupActive;
    
  if((keyCode == 'f' || keyCode == 'F') && mode != 2)//gキー押下かつ入力中でない
    areaNoPiece = !areaNoPiece;
}

void nemuBarProcess(){
  if(!groupActive){//グループ選択が無効化中
    stroke(0);
    strokeWeight(3);
    line(10,5,65,20);
  }
  
  textAlign(LEFT,TOP);
  textSize(18);
  fill(0);
  if(areaNoPiece){//エリア選択とコマ選択切り替え
     text("Area", 100, 0); 
  }else{
     text("Piece", 100, 0); 
  }
  
}