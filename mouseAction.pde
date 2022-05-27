int preX, preY;//直前のマウス座標
int Dx = -1, Dy = -1;//ドラッグ座標
//ImageHolder activate;//指定されている画像クラス
ArrayList<Integer> activate = new ArrayList<Integer>();//選択中の画像
ArrayList<ImageHolder> dummyHolder = new ArrayList<ImageHolder>();//ImageHolderの一時退避所
ImageHolder onMouseImage;//マウスが乗ってる画像
boolean imageMove = false;//画像が動いている
boolean leftmenuActive = false;
boolean imageRescale = false;
boolean drag = false;
boolean dragHas = false;//ドラッグで画像をとらえたか


void mousePressed() {

  switch(mode) {
  case 0:
    mousePress1();
    break;
  case 1:
    mousePress2();
    break;
  case 2:
    break;
  }
  
  //always mouse process
  anytimeMouse();
}


void mouseReleased() {
  if (activate!= null && !dragHas && !leftmenuActive && !imageRescale && mode==0) {//画像移動中なら停止判定
    if(!(keyPressed && keyCode == SHIFT))activate.clear();//shift中は連続選択
    imageMove = false;
    activeGroup = -1;//移動中のグループ初期化
  }
  if (dragHas && imageMove) {
    dragClear();
  }
  
  drag = false;//引っ張り判定削除
  Dx = -1;
  Dy = -1;
}