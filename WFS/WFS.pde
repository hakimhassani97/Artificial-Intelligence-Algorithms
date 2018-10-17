/*
hakim hassani M1 MIV 2018/2019
WFS ALgorithm
you can select the start point and the destination point with the mouse
made for educational purpose and sorry for my dirty code x)
created on October 3rd,2018
*/
int ii=1,jj=6;
PImage img;
int tour;
int i,j, w, h;
int precx=1,precy=6;
float r,g,b;
ArrayList<Point> open,closed;
ArrayList<Point> chemin=new ArrayList<Point>();
boolean found=false;
int cur=0,size=0;
boolean inc=true;
int [][]obst={
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,2,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1},
        {1,1,0,0,1,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,1,0,0,1,1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,3,0,0,0,0,0,0,1,0,0,1},
        {1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1},
        {1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}};
public class Point{
  public int x,y;
  public Point(int x,int y){
    this.x=x;this.y=y;
  }
  int getX(){return this.x;}
}
ArrayList<Point> getVoisins(int x,int y){
  ArrayList<Point> v=new ArrayList<Point>();
  if(x==0){
    if(y==0){
      v.add(new Point(x,y+1));
      v.add(new Point(x+1,y));
    }else{
      if(y<15){
        v.add(new Point(x,y+1));
        v.add(new Point(x+1,y));
        v.add(new Point(x,y-1));
      }else{
        if(y==15){
          v.add(new Point(x+1,y));
          v.add(new Point(x,y-1));
        }
      }
    }
  }else{
    if(x<15){
      if(y==0){
        v.add(new Point(x,y+1));
        v.add(new Point(x+1,y));
        v.add(new Point(x-1,y));
      }else{
        if(y<15){
          v.add(new Point(x,y+1));
          v.add(new Point(x+1,y));
          v.add(new Point(x,y-1));
          v.add(new Point(x-1,y));
        }else{
          if(y==15){
            v.add(new Point(x+1,y));
            v.add(new Point(x,y-1));
            v.add(new Point(x-1,y));
          }
        }
      }
    }else{
      if(x==15){
        v.add(new Point(x,y-1));
        v.add(new Point(x-1,y));
      }
    }
  }
  return v;
}
ArrayList<Point> getVoisinsValide(int x,int y){
  ArrayList<Point> a=new ArrayList<Point>(); 
  a=getVoisins(x,y);
  int size=a.size();
  for(int i=0;i<size;i++){
    if(a.get(i).x<16 && a.get(i).x>=0 && a.get(i).y<16 && a.get(i).y>=0 && obst[a.get(i).x][a.get(i).y]==1) {a.remove(i);size--;i--;}
  }
  return a;
}
boolean existe(int x,int y,ArrayList<Point> a){
  if(a.size()>0)
    for(int i=0;i<a.size();i++){
      if(a.get(i).x==x && a.get(i).y==y) return true;
    }
  return false;
}
void afficheChemin(ArrayList<Point> chemin){
  for(int i=0;i<chemin.size();i++){obst[chemin.get(i).x][chemin.get(i).y]=4;};
}
void setup() {
  size(512, 512);
  img = loadImage("im.jpg");
  w=img.width;
  h=img.height;
  open=new ArrayList<Point>();
  closed=new ArrayList<Point>();
  for(int i=0;i<16;i++){
    for(int j=0;j<16;j++){
      
    }
  }
  tour=0;
  loadPixels();
  img.loadPixels();
}
//append();
//shorten();
void draw() {
i=0;
for (int x = 0; x < w; x++ ) {
    for (int y = 0; y < h; y++ ) {
     int loc = x + y*w;
      int stepx=w/16;
      int stepy=h/16;
      i= y/stepy; j=x/stepx;
      int val=obst[i][j];
      switch (val)
      {
        case 0: r= 0; g=0; b=0; break;
        case 1: r= 0; g=0; b=255; break;
        case 2: r= 255; g=0; b=0; break;
        case 3: r= 0; g=255; b=0; break;
        case 4: r= 255; g=255; b=0; break;
        case 5: r= 255; g=150; b=0; break;
      }
      color c = color(r, g, b);
      pixels[loc]=c;
    }
  }
  updatePixels();
  //delay(1);
  ///
  Point s=new Point(ii,jj);
  if(s.x<16 && s.x>=0 && s.y<16 && s.y>=0 && obst[s.x][s.y]==3){print("arrivée"+ii+";"+jj);found=true;exit();}
  else{
    int taille=getVoisinsValide(ii,jj).size();
    if(taille==0){found=false;print("echec");}
    else{
      open.add(s);
      if(open.size()>0 && !found){
        Point n=new Point(open.get(0).x,open.get(0).y);
        open.remove(0);
        
        
        closed.add(n);
        obst[n.x][n.y]=5;
        ArrayList<Point> l=getVoisinsValide(n.x,n.y);
        if(l.size()>0){
          //open.addAll(getVoisinsValide(n.x,n.y));
          for(int i=0;i<l.size();i++){
              if(!existe(l.get(i).x,l.get(i).y,open) && !existe(l.get(i).x,l.get(i).y,closed)) 
                {open.add(l.get(i));chemin.add(n);}
          }
          for(int i=0;i<open.size();i++){
            if(open.get(0).x<15 && open.get(0).x>0 && open.get(0).y<15 && open.get(0).y>0 && obst[open.get(0).x][open.get(0).y]!=1 && obst[open.get(0).x][open.get(0).y]==3) 
              {found=true;afficheChemin(chemin);}
          }
          //print(open.get(0).x+";"+open.get(0).y+"/");
          if(open.get(0).x<15 && open.get(0).x>0 && open.get(0).y<15 && open.get(0).y>0 && obst[open.get(0).x][open.get(0).y]!=1)
            obst[open.get(0).x][open.get(0).y]=2;
            
        }
      }
    }
  }
}
