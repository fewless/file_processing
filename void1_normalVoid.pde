
void normalVoid(){//通常状態
  if (drag) {//範囲選択
    if (Dx == -1) {
      Dx = mouseX;
      Dy = mouseY;
    }
    noFill();
    stroke(255);
    rect(Dx, Dy, mouseX, mouseY);
    for (ImageHolder i : images)
      if (i.inBox(mouseX, mouseY, Dx, Dy)) {
        if (i.noActivate()) {
          activate.add(images.indexOf(i));
          dragHas = true;//ドラッグ選択
        }
      }
  }

  for (int i=images.size()-1 ;i >=0;i--) {//画像マウス乗ってる
    if (images.get(i).onMouse(mouseX, mouseY)) {//
      //onMouseImage = i;
      break;
    }
  }

  if (activate != null) {//いずれかの画像
    for (int i = 0; i<activate.size(); i++) {
      //println(activate.size()+" "+images.size()+ "  " + frameCount);
      images.get(activate.get(i)).showName();//名前と枠表示//indexout index10 size7 image == 7 why...?
      if (imageMove) {
        images.get(activate.get(i)).rePosition(preX, preY);
      } 
      if (leftmenuActive) 
        if(dragHas)image(leftMenu2, preX, preY);//右クリック時・ドラッグ中は別のメニュ
        else image(leftMenu, preX, preY);
    }

    if (imageMove) {//画像位置の更新
      preX = mouseX;
      preY = mouseY;
    }
  }
  
  if(HMLoading>0)loading();//画像ロード中はロード画面
}


void mousePress1(){
  boolean imageClicked=false;//画像がクリックされたか
    imageRescale = false;//初期化

    if (leftmenuActive && activate != null) {//右クリ中
      if (preX<mouseX && mouseX<menuWidth+preX && preY<mouseY && mouseY<preY + numOfMenu*leftWindowHeight) {//左クリックメニュー)
        int menuCount=-1;//何項目か
        for (int i=0; i<numOfMenu; i++)
          if (preX<mouseX && preY + leftWindowHeight*i<mouseY &&
            mouseX<preX+menuWidth && mouseY<preY+leftWindowHeight + leftWindowHeight*i)//それぞれの項目にあることを判定
            menuCount = i;
        if (dragHas) {//ドラッグ状態のメニュー
          switch(menuCount) {
          case -1:
            break;
          case 0:
            if(activate.size()>1)imageGroups.add(new Group(activate));//２つ以上選択中ならグループ化
            break;
          case 1://regroup 一旦すべてのグループから出して再グループ
            for(int i=0;i<activate.size();i++)
              images.get(activate.get(i)).removeAllGroup();
            if(activate.size()>1)imageGroups.add(new Group(activate));
            break;
          case 2:
            mode = 1;
            break;
          case 3:
            activeClear();
            break;
          }
        } else {
          switch(menuCount) {//単品
          case -1:
            break;
          case 0:
            mode = 2;//textsMode
            break;
          case 1:
            nodeModes=1;//remove
            mode = 1;//nodeMode
            //images.get(activate.get(0)).removeAllGroup();//全グループから消去
            break;
          case 2:
            imageRescale = true;
            break;
          case 3:
            nodeModes=0;//add
            mode = 1;//nodeMode
            break;
          case 4:
            activeClear();
            break;
          }
        }
      }
      leftmenuActive = false;
    } else if (!drag) {//ドラッグ状態でない
      for (int i=images.size()-1; i >=0; i--) {//後で逆順にしろ 画像選択判定
        if (images.get(i).onMouse(mouseX, mouseY)) {//マウス乗ってたらその子だけ動かす
          if (images.get(i).noActivate() && dragHas)activate.clear();
          if (images.get(i).noActivate()) activate.add(images.indexOf(images.get(i)));//既にアクティブ画像でなければ追加
          switch(mouseButton) {
          case LEFT:    
            preX = mouseX;
            preY = mouseY;
            imageMove = true;
            imageClicked=true;
            break;
          case RIGHT:
            leftmenuActive = true;
            imageClicked=true;
            break;
          }
          break;
        }
      }
      if(activate.size()==0 && activeGroup == -1 && groupActive){//画像が非アクティブで選択中でない
        for(int i=0;i<imageGroups.size();i++){
          if(imageGroups.get(i).onMouse(mouseX,mouseY)){
            activate.clear();
            for(int k=0;k<imageGroups.get(i).getList().size();k++){//グループメンバーを追加
              //if(images.get(k).noActivate())
              activate.add(images.indexOf(images.get(searchImageFromID(imageGroups.get(i).getList().get(k)))));
            }
            preX = mouseX;
            preY = mouseY;
            imageMove = true;
            imageClicked = true;
            activeGroup = i;//アクティブにする
            if(activate.size()>1)break;
          }
        }
      }
      
      if (!imageClicked) {
        activate.clear();//マウスが画像に重なって無ければ初期化
        dragHas = false;
        if (mouseButton == LEFT)drag=true;//引っ張り判定
      }
    }

    preX = mouseX;//処理終わりにマウス座標更新
    preY = mouseY;
}