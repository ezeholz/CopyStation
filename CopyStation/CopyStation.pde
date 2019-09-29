/*

640 x 480 imagenes capturadas

menos frames posibles
buscar forma de gif/boomerang

*/

import processing.video.*;
import gifAnimation.*;

boolean mirror = true;
int camaraSelected = 0;

PImage image;
PImage marca;

int img = 1;
int est = (hour() * 10000) + (minute() * 100) + second();

Log log;
int cant;

GifMaker gif;

Capture video;

void setup() {
  size(640,480);
  video = new Capture(this, 640, 480, AvalCam()[camaraSelected], 30);
  video.start();
  background(0);
  
  log= new Log("/Base/","Base (1).jpg",false, false);
  cant = log.id;
  
  marca = loadImage("Puerta.png", "png");
  
  gif = new GifMaker(this, "Estaciones/Estación " + est + "/#Gif.gif");
  gif.setRepeat(0);

}

void cam() {
  video.read();
  tint(255);
  if(mirror) {
    scale(-1,1);
    image(video, -width, 0);
    scale(-1,1);
  } else {
    image(video, 0, 0);
  }
  image(marca, width - 200, height - 80, 200, 80);
}

void draw() { 
  if (video.available()) {
    cam();
  }
  if (img < cant) {
    tint(255,126);
    image(image, 0, 0, width, height);
  }
}

void keyPressed() {
  if(key == ' ') {
    if(img != cant-1) {
      cam();
      save("Estaciones/Estación " + est + "/Imagen " + img + ".jpg");
      gif.setDelay(100);
      gif.addFrame();
      img++;
      image = loadImage("/Base/Base (" + img + ").jpg");
    } else {
      cam();
      gif.finish();
      est = (hour() * 10000) + (minute() * 100) + second();
      img = 1;
      gif = new GifMaker(this, "Estaciones/Estación " + est + "/#Gif.gif");
      gif.setRepeat(0);
      print("Secuencia terminada, iniciando nueva.");
      image = loadImage("/Base/Base (" + img + ").jpg");
    }
  } else if (key == ENTER) {
    cam();
    gif.finish();
    est = (hour() * 10000) + (minute() * 100) + second();
    img = 1;
    gif = new GifMaker(this, "Estaciones/Estación " + est + "/#Gif.gif");
    gif.setRepeat(0);
    image = loadImage("/Base/Base (" + img + ").jpg");
  }
}

String[] AvalCam() {
  StringList listName = new StringList();
  for (int i = 0; i < Capture.list().length; i++) {
    if(i==0){
      listName.append(split(split(Capture.list()[i],',')[0],'=')[1]);
    } else {
      if(!listName.hasValue(split(split(Capture.list()[i],',')[0],'=')[1])) {
        listName.append(split(split(Capture.list()[i],',')[0],'=')[1]);
      }
    }
  }
  println("Available Cameras: ");
  println(listName);
  return listName.array();
}