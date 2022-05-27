//ノードにグラデーション採用して。PGで作って伸ばす


PGraphics leftMenu;//右クリックの画像
PGraphics leftMenu2;//右クリックの画像 範囲選択
PGraphics leftMenu3;//右クリックの画像　グループ選択
PGraphics loadingBar;//画像読み込みのバー
PGraphics warning;//画像形式エラー
PGraphics cross;//ばってん
PGraphics statusBar;//上に表示するステータス欄

void settings() {
  size(1200, 800);
}

int numOfMenu = 5;//メニューの項目数
int leftWindowHeight = 15;//メニューの縦幅
int menuWidth = 100;//
int mode=0;//0:通常　1:ノード系
void setup() { 
  // 文字指定
  PFont font = createFont("Meiryo", 50);
  textFont(font);
  frameRate(60);
  textSize(12);
  textAlign(LEFT, TOP);
  rectMode(CORNERS);

  leftMenu = createGraphics(menuWidth, numOfMenu*leftWindowHeight);//右メニューの横と項目数
  leftDraw(numOfMenu, leftWindowHeight);//メニュー数・一つの縦幅
  
  leftMenu2 = createGraphics(menuWidth, 4*leftWindowHeight);//ドラッグ時の右メニュー
  leftDraw2(4, leftWindowHeight);
  
  leftMenu3 = createGraphics(menuWidth, 4*leftWindowHeight);//グループの右メニュー
  leftDraw3(4, leftWindowHeight);
  
  loadingBar = createGraphics(width/4,height/5);//右メニューの横と項目数
  barDraw();
  warning = createGraphics(width/3,height/12);//右メニューの横と項目数
  warningDraw();
  cross = createGraphics(50,50);//右メニューの横と項目数
  crossDraw();
  statusBar = createGraphics(width,30);
  statusDraw();

  DandD();//ドラッグアンドドロップ
  
}

int positionDelay=0;//なぜか2フレーム遅れて座標更新なのでカウント用
void draw() {
  background(200);
  if (positionDelay>=1) {//画像の読み込み
    if (positionDelay>=3) {
      for (int i=0;i<images.size();i++)//ディレイ後に正式に追加
        if (images.get(i).getNull())//処理前なら
          images.get(i).setImage();//初期設定
      positionDelay=0;
    } else
      positionDelay++;
  }
  
  
  for(int i=0;i<imageGroups.size();i++)
    imageGroups.get(i).showGroup();

  for (int i=0;i<images.size();i++){//画像表
    images.get(i).showImage();
    if(keyPressed && keyCode == ALT){//ALTが押されているなら全ノード表示
      for(ImageHolder n:images)
        n.showNodes();
    }
    
  }

  if (imageRescale)
    images.get(activate.get(0)).reScale(mouseX, mouseY);//リスケール起動中判定

  switch(mode){//処理開始
    case 0:
      normalVoid();//通常状態
      break;
    case 1:
      nodeMode();
      break;
    case 2:
      textsMode();
      break;
  }
  
  if(groupKillSwitch)cleanGroups();//グループのお掃除
  
  image(statusBar,0,0);
  nemuBarProcess();
}

void keyPressed() {//セーブ作る
  switch(mode) {
  case 0:
    break;
  case 1:
    break;
  case 2:
    keyPress3();
    break;
  }
  
  keyAnytime();
}