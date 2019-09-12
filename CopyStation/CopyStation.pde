import processing.video.*;
import gifAnimation.*;

PGraphics pos;
boolean next = false;

PImage image;
PImage marca;

int img = 0;
int est = (hour() * 10000) + (minute() * 100) + second();

Log log;
int cant;

GifMaker gif;
Gif gifs;

Capture video;

void setup() {
  size(640,480);
  video = new Capture(this, width, height);
  video.start();
  background(0);
  
  log= new Log("/Posiciones/","Base.jpg",false, false);
  cant = log.id;
  
  marca = loadImage("Puerta.png", "png");
  
  gif = new GifMaker(this, "Estaciones/Estación " + est + "/#Gif.gif");
  gif.setRepeat(0);

  
}

void cam() {
  video.read();
  tint(255);
  image(video, 0, 0, width, height);
  image(marca, width - 200, height - 80, 200, 80);
}

void draw() { 
  if (video.available()) {
    cam();
  } 
  if (img < cant) {
    image = loadImage("Estaciones/Base " + est + "/Base " + img + ".jpg");
    tint(255,126);
    image(image, 0, 0, width, height);
  }
}

void keyPressed() {
  if(key == ' ') {
    cam();
    save("Estaciones/Estación " + est + "/Imagen " + img + ".jpg");
    gif.setDelay(100);
    gif.addFrame();
    img++;
    
  } else if (key == ENTER) {
    cam();
    gif.finish();
    est = (hour() * 10000) + (minute() * 100) + second();
    img = 0;
    gif = new GifMaker(this, "Estaciones/Estación " + est + "/#Gif.gif");
    gif.setRepeat(0);
  }
}