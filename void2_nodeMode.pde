void nodeMode() {
  for (int k = 0; k<activate.size(); k++)//アクティブ中の名前表示
    images.get(activate.get(k)).showName();

  for (int i=images.size()-1; i >=0; i--) {//画像マウス乗ってる
    if (images.get(i).onMouse(mouseX, mouseY)) {//マウス乗ってる画像にノードを渡せるなら一旦表示
      for (int k = 0; k<activate.size(); k++) {
        switch(nodeModes) {
        case 0://通常
          if (activate.get(k) != i) {
            drawArrow(images.get(activate.get(k)).midX(), 
              images.get(activate.get(k)).midY(), 
              images.get(i).midX(), 
              images.get(i).midY());
          }
          break;
        case 1://削除モード
          if (images.get(activate.get(k)).alreadyHas(i)) {
            drawArrow(images.get(activate.get(k)).midX(), 
              images.get(activate.get(k)).midY(), 
              images.get(i).midX(), 
              images.get(i).midY());

            imageMode(CENTER);
            tint(0);
            image(cross, (images.get(activate.get(k)).midX()+images.get(i).midX())/2, (
              images.get(activate.get(k)).midY()+images.get(i).midY())/2);
            tint(255);
            image(cross, (images.get(activate.get(k)).midX()+images.get(i).midX())/2, (
              images.get(activate.get(k)).midY()+images.get(i).midY())/2, 48, 48);
            imageMode(CORNER);
          }
        }
      }
      break;
    }
  }
}

int nodeModes = 0;//0:add 1:remove

void mousePress2() {

  switch(nodeModes) {
  case 0://追加
    for (int i=images.size()-1; i >=0; i--) {//画像マウス乗ってる
      if (images.get(i).onMouse(mouseX, mouseY)) {//
        for (int k = 0; k<activate.size(); k++) {
          if (activate.get(k) != i)//相手が自分じゃない
            if (!images.get(activate.get(k)).alreadyHas(images.get(i).getID()))//ノードが存在していない
              images.get(activate.get(k)).addNode(images.get(i).getID());//id取得して追加
        }
        break;
      }
    }
    if (!(keyPressed && keyCode == SHIFT))mode =0;
    break;

  case 1://削除
    for (int i=images.size()-1; i >=0; i--) {//画像マウス乗ってる
      if (images.get(i).onMouse(mouseX, mouseY)) {//
        for (int k = 0; k<activate.size(); k++) {
          if (activate.get(k) != i)//相手が自分じゃない
            if (images.get(activate.get(k)).alreadyHas(images.get(i).getID())) {//ノードが存在していない
              images.get(activate.get(k)).removeNode(images.get(i).getID());//id取得して追加
            }
        }
        break;
      }
    }
    if (!(keyPressed && keyCode == SHIFT)){
      mode =0;
      nodeModes =1;
    }
    break;
  }
}