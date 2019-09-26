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
  if(true) {
    String[] cameras = Capture.list();
    try {video = new Capture(this, width, height, cameras[camaraSelected]);} catch(Exception e) {video = new Capture(this, width, height);}
  }
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
  if(mirror) {scale(-1,1);}
  image(video, -width, 0);
  if(mirror) {scale(-1,1);}
  image(marca, width - 200, height - 80, 200, 80);
}

void draw() { 
  if (video.available()) {
    cam();
  } 
  if (img < cant) {
    image = loadImage("/Base/Base (" + img + ").jpg");
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
    } else {
      cam();
      gif.finish();
      est = (hour() * 10000) + (minute() * 100) + second();
      img = 1;
      gif = new GifMaker(this, "Estaciones/Estación " + est + "/#Gif.gif");
      gif.setRepeat(0);
      print("Secuencia terminada, iniciando nueva.");
    }
  } else if (key == ENTER) {
    cam();
    gif.finish();
    est = (hour() * 10000) + (minute() * 100) + second();
    img = 1;
    gif = new GifMaker(this, "Estaciones/Estación " + est + "/#Gif.gif");
    gif.setRepeat(0);
  }
}