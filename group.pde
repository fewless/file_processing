//ArrayList<ImageHolder> imageGroups = new ArrayList<ImageHolder>();
ArrayList<Group> imageGroups = new ArrayList<Group>();
boolean groupKillSwitch = false;//メンバー数が１のグループを削除する
int activeGroup = -1;//選択中のグループ
boolean groupActive = true;//グループ操作が有効か

class Group {
  ArrayList<Integer> list = new ArrayList<Integer>();//idのリスト
  String gName;
  int XU=0,YU=0,XB=0,YB=0;//左上、左下...の座標
  
  Group(ArrayList<Integer> ls) {
    addMember(ls);
    gName = "default";
    println("makeGroup=="+list.size());
  }

  void addMember(ArrayList<Integer> ls) {//4activate
    for (Integer i : ls) {
      int id = images.get(i).getID();
      this.list.add(id);
    }
  }

  void removeMember(ArrayList<Integer> ls) {//4activate
    for (Integer i : ls) {
      int id = images.get(i).getID();
      this.list.remove(id);
    }
    clean();
  }

  void removeMemberID(int id) {//4id
    int num=searchFromID(id);
    if(num>=0)this.list.remove(num);//indexOutOfBounds
    clean();
  }
  
  int searchFromID(int id){//idからlist番号取得
   for (int i=list.size()-1; i >=0; i--) {
    if (list.get(i) == id){
      return i;
    }
   }
  return -1;
  }
  
  void clean(){//メンバーが1以下の人たちをお掃除
    if(list.size()<=1){
      this.list.clear();
      groupKillSwitch=true;
    }
  }
  
  int getSize(){
    return this.list.size();
  }
  
  void reGPosition(){
    for(int i=0;i<list.size();i++)
      images.get(activate.get(i)).rePosition(preX, preY);  
  }
  
  ArrayList<Integer> getList(){//メンバー取得
    return this.list; 
  }
  
  boolean onMouse(int x, int y){//マウスがグループ内にいるか
    if(XU <= x && x <= XB && YU <= y && y <= YB)
      return true;
    else
      return false;
  }
  
  boolean isMember(int ID){//IDがメンバーに含まれているか
    for(int i=0;i<list.size();i++){
      if(list.get(i) == ID)
        return true;
    }
    return false;
  }

  void showGroup() {
    if(this.list.size()>1){
    noFill();
    strokeWeight(3);
    stroke(240);
    int upperX=Integer.MAX_VALUE, upperY=Integer.MAX_VALUE, bottomX=Integer.MIN_VALUE, bottomY=Integer.MIN_VALUE;
    boolean changed = false;
    for (int i=0;i<list.size();i++) {//list.get(i)
      //例外設定　-1が帰ってきたときの
      int num= searchImageFromID(list.get(i));//画像のID
      if (num==-1) {
        removeMemberID(list.get(i));//存在しなかったらグループから削除
      } else {
        ImageHolder p = images.get(num);//-1 のarrayout
        int[] edges = new int[4];//範囲の各XY
        edges = p.getScale();
        if (upperX>edges[0]) upperX=edges[0];
        if (upperY>edges[1]) upperY=edges[1];
        if (bottomX<edges[2]) bottomX=edges[2];
        if (bottomY<edges[3]) bottomY=edges[3];
        changed = true;//変更があったよ
      }
    }
    
    if(changed){
      
      rect(upperX-1, upperY-1, bottomX+1, bottomY+1);
      rect((upperX+bottomX)/2 - 7*gName.length()/2, upperY-1 , (upperX+bottomX)/2 + 7*gName.length()/2 ,upperY - 15);
      textAlign(CENTER);
      fill(0);
      textSize(12);
      text(gName,(upperX+bottomX)/2, upperY-4);
      textAlign(LEFT);
      XU = upperX;YU = upperY;XB=bottomX;YB=bottomY;
    }
  }
  }
}



void cleanGroups(){//必要ないグループのお掃除
  for(int i=imageGroups.size()-1;i>=0;i--){
    if(imageGroups.get(i).getSize()<=1)
      imageGroups.remove(i);
  }
  groupKillSwitch = false;
}