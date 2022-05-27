void textsMode() {
  images.get(activate.get(0)).showName();//アクティブ画像の名前表示
  fill(220);
  rect(10, height-100, 250, height-60);
  fill(0);
  textSize(20);
  text("push ENTER to confirm", 15, height-75);
  if (confCount>0) {
    confCount++;
    if(confCount>60)//一定時間で消去
      confCount=0;
    fill(220);
    rect(10, height-150, 400, height-110);
    fill(0);
    textSize(20);
    text("!you already use this name or empty!", 15, height-125);
    
  }
  textSize(12);
}

int confCount=0;//名前衝突してたときの表示カウント

void keyPress3() {
  switch(keyCode) {
  case ENTER://エンターで戻る
    if (nameConfChk2(images.get(activate.get(0)).getsName()) || images.get(activate.get(0)).getsName().length()<1)//既存の名前と衝突or名前空白
      confCount=1;
    else {
      mode=0;
      confCount=0;
      activate.clear();
    }
    break;
  case BACKSPACE:
    String tmps = images.get(activate.get(0)).getsName();
    if (tmps.length()>0)//1文字以上なら文字消去
      images.get(activate.get(0)).setsName(tmps.substring(0, tmps.length()-1));//文字設定
    break;
  default:
    char tmp = key;
    images.get(activate.get(0)).setsName(images.get(activate.get(0)).getsName() + tmp);//文字設定
    break;
  }
}