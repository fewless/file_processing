void dragClear() {
  imageMove = false;
  dragHas=false;
  activate.clear();
};//ドラッグ系のクリアー

void activeClear() {
  for (int i=activate.size()-1; 0<=i; i--)
    dummyHolder.add(images.get(activate.get(i)));
  for (ImageHolder i : dummyHolder)
    images.remove(images.indexOf(i));
  dummyHolder.clear();
  activate.clear();
}//アクティブ画像のクリアー

void drawArrow(int ax,int ay,int bx, int by){//矢印描写　始点→終点
  PVector v = new PVector(bx-ax,by-ay);
  stroke(0);
  strokeWeight(2);
  line(ax,ay,bx,by);
  pushMatrix();
  fill(255);
  translate(bx,by);
  rotate(atan2(v.y,v.x)-PI/2);
  quad(0,0,-15,-15,0,-10,15,-15);
  popMatrix();
}

int searchImageFromID(int id){//idから画像番号取得
   for (int i=images.size()-1; i >=0; i--) {
    if (images.get(i).getID() == id){
      return i;
    }
   }
  return -1;
}

boolean nameConfChk(String name){//名前の衝突検知　新規
   for (int i=images.size()-1; i >=0; i--) {
    if (images.get(i).getsName().equals(name)){
      return true;
    }
   }
  return false;
}

boolean nameConfChk2(String name){//名前の衝突検知　既存変更用
   int count =0;
   for (int i=images.size()-1; i >=0; i--) {
    if (images.get(i).getsName().equals(name)){
      count++;
      if(count>1)//自ら以外に一致したらダメ
        return true;
    }
   }
  return false;
}

String nameNoConf(String name){//被らない名前に改名
  int No=0;
  if(nameConfChk(name))
        No = nameNoConfNo(name,1);
  if(No==0)
    return name;
  else
    return name+No;
}

int nameNoConfNo(String name, int No){//被らないようにする付属番号決定
  int nextNo = 0;
  if(nameConfChk(name + No))
      nextNo = nameNoConfNo(name,No+1);
  return max(No,nextNo);
}