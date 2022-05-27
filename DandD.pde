//ドラッグアンドドロップ関係
import java.awt.datatransfer.Transferable;  
import java.awt.datatransfer.UnsupportedFlavorException;  
import java.awt.dnd.DnDConstants;  
import java.awt.dnd.DropTarget;  
import java.awt.dnd.DropTargetDragEvent;  
import java.awt.dnd.DropTargetDropEvent;  
import java.awt.dnd.DropTargetEvent;  
import java.awt.dnd.DropTargetListener;
import java.awt.datatransfer.DataFlavor;
import java.awt.Component;
import javax.swing.JPanel;
import java.io.File;  
import java.io.IOException;  
import java.util.List;  
import java.applet.Applet;

import javax.swing.*;
import java.awt.*;
DropTarget dropTarget; 
boolean warningError;//画像形式エラー
//ドラッグアンドドロップ関係

void DandD() {//ドラッグアンドドロップ
  //Start Change
  Canvas canvas =(Canvas)surface.getNative();
  JLayeredPane pane =(JLayeredPane)canvas.getParent().getParent();
  //End Change

  dropTarget = new DropTarget( 

    pane, //Change

    new DropTargetListener() {  
    public void dragEnter(DropTargetDragEvent dtde) {
    }  
    public void dragOver(DropTargetDragEvent dtde) {
    }  
    public void dropActionChanged(DropTargetDragEvent dtde) {
    }  
    public void dragExit(DropTargetEvent dte) {
    }  
    public void drop(DropTargetDropEvent dtde) {  
      dtde.acceptDrop(DnDConstants.ACTION_COPY_OR_MOVE);  
      Transferable trans = dtde.getTransferable();  
      List<File> fileNameList = null;  
      if (trans.isDataFlavorSupported(DataFlavor.javaFileListFlavor)) {  
        try {  
          fileNameList = (List<File>)  
            trans.getTransferData(DataFlavor.javaFileListFlavor);
        } 
        catch (UnsupportedFlavorException ex) {
        } 
        catch (IOException ex) {
        }
      }  
      if (fileNameList == null) return;
      HMLoading = fileNameList.size();
      loadCount=0;
      for (File f : fileNameList) {//読み込み
        loadCount++;
        String[] dummyS= split(f.getAbsolutePath(), "\\");//ファイル名の抽出
        String imageType = dummyS[dummyS.length-1].substring(dummyS[dummyS.length-1].length()-3, dummyS[dummyS.length-1].length());
        if (imageType.equals("png") || imageType.equals("jpg") || imageType.equals("gif")) {
          PImage dummy = loadImage(f.getAbsolutePath());//読み込み
          if (dummy.width > width)dummy.resize(width, 0);//大きすぎたらリサイズ
          if (dummy.height > height)dummy.resize(0, height);
          dummy.save("data/"+ dummyS[dummyS.length-1].substring(0, dummyS[dummyS.length-1].length()-4) + ".png");//pngとして保存しとく
          dummy = loadImage(dummyS[dummyS.length-1].substring(0, dummyS[dummyS.length-1].length()-4) + ".png");//dummyから拾いなおし
          String tmpName = dummyS[dummyS.length-1].substring(0, dummyS[dummyS.length-1].length()-4);//名前が被ってないか検査用
          tmpName = nameNoConf(tmpName);//名前の衝突検査
          images.add(new ImageHolder(dummy, dummyS[dummyS.length-1].substring(0, dummyS[dummyS.length-1].length()-4),tmpName, imageid));//処理前画像を追加
          imageid++;
        }else
          warningError = true;//画像形式エラー
      }
      warningError = false;
      HMLoading =0;
      positionDelay=1;
    }
  }
  );
}

ArrayList<ImageHolder> images = new ArrayList<ImageHolder>();
int imageid = 0;//現状はint_maxまで

class ImageHolder {
  String fileName;//使用している画像の名前
  PImage originImage;//データ元
  PImage proImage;//処理後画像
  int pointX, pointY;
  String name;//画像の名前
  int ID;//管理用番号
  int group;//画像グループ
  int layer;//画像レイヤー 0:エリア 1:コマ
  ArrayList<ImageNode> nodes=new ArrayList<ImageNode>();//こいつが持ってるノード


  ImageHolder(PImage data, String filename,String name, int ID) {
    this.fileName = filename;
    this.name = name;
    this.ID = ID;
    group = 0;
    this.originImage = data;
  }

  void setImage() {//ディレイの後に処理
    proImage = originImage.copy();
    proImage.resize(proImage.width/2,0);
    pointX = mouseX-proImage.width/2;
    pointY = mouseY-proImage.height/2;
  }

  boolean getNull() {//処理したかどうか
    if (proImage==null) {
      return true;
    } else
      return false;
  }

  void rePosition(int X, int Y) {//前回のXY座標が送られてくる
    pointX = pointX + mouseX-X;
    pointY = pointY + mouseY-Y;
    //this.showName();
  }

  boolean onMouse(int X, int Y) {//処理後画像にマウスが載ってるか
    if (proImage!= null) {//処理後画像かどうか
      if (pointX <= X && X <= pointX + proImage.width &&
        pointY <= Y && Y <= pointY + proImage.height) {
        this.showName();//ついでに名前表示
        return true;
      }
    }
    return false;
  }

  boolean inBox(int X, int Y, int eX, int eY) {//ドラッグ範囲内にいるか
    if (proImage!= null) {//処理後画像かどうか
      if (X <= pointX + proImage.width/2&& pointX + proImage.width/2  <= eX &&
        Y <= pointY + proImage.height/2 && pointY + proImage.height/2 <= eY ||
        eX <= pointX + proImage.width/2&& pointX + proImage.width/2  <= X &&
        eY <= pointY + proImage.height/2 && pointY + proImage.height/2 <= Y ||
        eX <= pointX + proImage.width/2&& pointX + proImage.width/2  <= X &&
        Y <= pointY + proImage.height/2 && pointY + proImage.height/2 <= eY ||
        X <= pointX + proImage.width/2&& pointX + proImage.width/2  <= eX &&
        eY <= pointY + proImage.height/2 && pointY + proImage.height/2 <= Y) {
        this.showName();//ついでに名前表示
        return true;
      }
    }
    return false;
  }

  boolean noActivate() {//処理後画像にマウスが載ってるか
    if (proImage!= null) {//処理後画像かどうか
      if ( -1 == activate.indexOf(images.indexOf(this)))
        return true;
    }
    return false;
  }

  void showImage() {//処理後ならば表示
    if (proImage != null)
      image(this.proImage, pointX, pointY);
  }

  void reScale(int x, int y ) {//画像の大きさ変更
    int imageX = x-pointX;
    int imageY = y-pointY;
    if (imageX<10)imageX = 10;
    if (imageY<10)imageY = 10;
    proImage = originImage.copy();
    if (keyPressed && keyCode == SHIFT) {//シフトが押されている
      if (imageX < imageY)
        proImage.resize(imageX, 0);
      else
        proImage.resize(0, imageY);
    } else
      proImage.resize(imageX, imageY);
    showName();
  }

  int getID() { 
    return this.ID;
  }//idを返す

  void showName() {
    textAlign(CENTER);
    fill(0);
    textSize(12);
    text(this.name, pointX+proImage.width/2, pointY+proImage.height+15);
    noFill();
    stroke(255);
    strokeWeight(3);
    rect(pointX-1, pointY-1, pointX+proImage.width+1, pointY+proImage.height+1);
    textAlign(LEFT);

    if (keyPressed && keyCode == CONTROL  || keyPressed && keyCode == SHIFT && mode==1 || nodeModes == 1) {//CTRLが押されているor消去モードならノード表示
      showNodes();
    }
  }

  void showNodes() {
    for (int i=nodes.size()-1;i>=0;i--)
      if(!nodes.get(i).showNode(midX(), midY()))
        nodes.remove(i);  
  }

  int midX() {
    return pointX+proImage.width/2;
  }//座標を返す
  int midY() {
    return pointY+proImage.height/2;
  }
  int[] getScale(){//四隅の座標を返す
    int[] i=new int[4];
    i[0]=pointX;i[1]=pointY;i[2]=pointX+proImage.width;i[3]=pointY+proImage.height;
    return i;
  }

  void addNode(int id) {//idによってノード追加
    nodes.add(new ImageNode(id));
  }
  
  void removeNode(int id) {//idによってノード削除
    for(int i=0;i<nodes.size();i++)
      if(nodes.get(i).getObjective() == id){
        nodes.remove(i);
        break;
      }
  }

  ArrayList<ImageNode> getNodes() {//ノードを返す
    return this.nodes;
  }
  
  boolean alreadyHas(int id){//設定済みノードか
    for(int i=0;i<nodes.size();i++)
      if(id == nodes.get(i).getObjective())//格納済みのノードと一致したらダメ
        return true;
    return false;
  }
  
  void setsName(String name){//名前の設定
    this.name = name;
  }
  
  String getsName(){
    return this.name;
  }
  
  void removeAllGroup(){//全グループから自信を消去
    for(Group g:imageGroups)
      g.removeMemberID(getID());
  }
}


class ImageNode {//画像間のノード
  int objective;//目標id
  int polarity;//極性　0：一方　1：双方
  int restriction;//制限　0：制限ナシ　1～：必要No
  int time;//ルートの所要時間

  ImageNode(int objective) {
    this.objective = objective;
    this.polarity = polarity;
    restriction=0;//最初は制限なし
  }

  boolean showNode(int x, int y) {//ノード表示　使われていないノードだったらfalse
    int target = searchImageFromID(objective);
    if (target != -1){
      drawArrow(x, y, images.get(target).midX(), images.get(target).midY());
      return true; 
    }
    return false;
  }

  boolean searchKilledNode(int killedImage) {//削除されたノードかどうか、そうだったらkill
    return true;
  }
  
  int getObjective(){//目標を返す
    return objective;
  }
}