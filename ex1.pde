/*
hakim hassani M1 MIV 2018/2019
algorithme A
decommenter les lignes de la fonction h pour changer entre diagonale,manhattan et euclidien 
fait le mercredi 03/10
*/
PImage img;
int i,j, w, h;
float r,g,b;
Point s,curr,prec;
int size=0,m=0,click=0;
ArrayList<Point> open,closed;
ArrayList<Point> chemin=new ArrayList<Point>();
boolean found=false;
int [][]obst={
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,1,0,0,0,1,1,1,1},
        {1,0,1,0,1,0,1,0,0,0,1,0,0,0,0,1},
        {1,0,1,0,1,1,1,0,1,1,0,0,1,1,1,1},
        {1,1,1,1,1,0,1,0,1,0,1,1,1,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1},
        {1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}};
public class Point{
  public int x,y;float h=0,f=0,g=0;
  Point pere;
  public Point(int x,int y){
    this.x=x;this.y=y;
  }
  boolean equals(Point p){return this.x==p.x && this.y==p.y;}
}
void mouseClicked(){
  if(mouseButton==RIGHT){
    if(!keyPressed) obst[mouseY/32][mouseX/32]=0;
    if(keyPressed && key=='a'){obst[mouseY/32][mouseX/32]=1;}
  }
  else{
    if(click==0) {obst[mouseY/32][mouseX/32]=2;}
    if(click==1) {obst[mouseY/32][mouseX/32]=3; s=new Point(debut().x,debut().y);
     chemin.add(s);
     curr=s;}
    click++;
  }
}
Point debut(){
  for(int i=0;i<16;i++)
    for(int j=0;j<16;j++)
      if(obst[i][j]==2) return new Point(i,j);
  return new Point(0,0);
}
Point fin(){
  for(int i=0;i<16;i++)
    for(int j=0;j<16;j++)
      if(obst[i][j]==3) return new Point(i,j);
  return new Point(0,0);
}
void dessineMatrice(){
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
ArrayList<Point> getVoisinsValides(int x,int y){
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
  print("chemin="+chemin.size()+"\n");
}
void afficheChemin(Point p){
  int i=0;
  while(p.pere!=null){
    print("("+p.x+";"+p.y+") ");
    if(obst[p.x][p.y]==0)obst[p.x][p.y]=4;
    p=p.pere;i++;
  }
  print("("+p.x+";"+p.y+") ");
  if(obst[p.x][p.y]==0)obst[p.x][p.y]=2;
  print("[chemin = "+(i-1)+"]");
}
float h(Point p){
  //p.h=abs(fin().x-p.x)+abs(fin().y-p.y);
  //p.h=max(abs(p.x-fin().x),abs(p.y-fin().y));
  p.h=sqrt(pow(fin().x-p.x,2)+pow(abs(fin().y-p.y),2));
  
  return p.h;
}
float f(Point p,float cout){
  p.f=cout+h(p);
  p.g=cout;
  return p.f;
}
int minF(ArrayList<Point> l){
  int min=0;
  for(int i=0;i<l.size();i++){
    if(l.get(i).f<l.get(min).f) min=i;
  }
  return min;
}
void setup() {
  size(512, 512);
  img = loadImage("im.jpg");
  w=img.width;
  h=img.height;
  open=new ArrayList<Point>();
  s=new Point(debut().x,debut().y);
  h(s);
  f(s,0);
  //print(h(s));
  chemin.add(s);
  curr=s;
  closed=new ArrayList<Point>();
  loadPixels();
  img.loadPixels();
}
void draw(){
  if(click==2){
    if(curr.equals(fin())){print("fin\n");found=true;afficheChemin(curr);stop();}
    else{
      prec=curr;
      if(open.size()>0) {
        curr=open.get(minF(open));open.remove(minF(open));
      }
      ArrayList<Point> l = getVoisinsValides(curr.x,curr.y);
      size=l.size();
      if(size>0 && !found && !existe(curr.x,curr.y,closed) && !existe(curr.x,curr.y,closed)){
        for(int i=0;i<size;i++){
          //ajouté sans effet :/
          h(l.get(i));f(l.get(i),curr.g);
          l.get(i).pere=curr;
          open.add(l.get(i));
        }
        closed.add(curr);
        print(++m+"/");
      }
      obst[prec.x][prec.y]=0;
      if(obst[curr.x][curr.y]!=3) obst[curr.x][curr.y]=2;
    }
  }
  dessineMatrice();
  updatePixels();
  //delay(10);
}
