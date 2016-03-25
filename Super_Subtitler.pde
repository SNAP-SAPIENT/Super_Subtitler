import muthesius.net.*; //<>//

//import codeanticode.syphon.*;
import processing.opengl.*;

import org.webbitserver.*;


PGraphics canvas;
//SyphonServer server;
float factor;
WebSocketP5 socket;
PFont font;
Spout spout;
boolean speechOn;
String speechString;
int currentTime;
int wait = 100;
int renderCount = 0;


void setup()
{
  // DISPLAY SETUP
  size(640, 480, P3D);
  canvas = createGraphics(640, 480, P3D);
  textureMode(NORMAL);
  textSize(48);
  frameRate(30);
  // SYPHON SETUP - OSX Only
  //server = new SyphonServer(this, "Speech Input");
  // SPOUT SETUP - Windows Only
  spout = new Spout();
  spout.initSender("Super-Subtitler", width, height);
  factor = 1;
  // WEBSOCKET SETUP
  socket = new WebSocketP5(this, 8080);
  // LOAD FONT
  //font = loadFont("Serif.bold-48.vlw");
  //textFont(font, 48);
  
  //INSANTIATE TEXT BOOLEAN
  speechOn = false;
  //CREATE EMPTY STRING
  speechString = "";
  
  //START TIME
  currentTime = millis();
}


// RENDER AND SEND TO SYPHON
void draw()
{
  canvas.beginDraw();
  //canvas.background(127, 127, 127);
  //canvas.background(127, 127*factor, 127*factor);
  //canvas.lights();
  //canvas.translate(width/2, height/2);
  //canvas.rotateX(frameCount * 0.01);
  //canvas.rotateY(frameCount * 0.01);  
  //canvas.box(150);
  //text("testing here", 100, 100);
  canvas.endDraw();
  image(canvas, 0, 0);
  // AN ISSUE EXISTS WITH OPENGL AND WRITING TO OPENGL ON THIS LINE
  //server.sendImage(canvas);
  
  //DRAW TEXT WHEN WEBSOCKET GETS DATA BACK an
  if(speechOn && (millis() - currentTime >= wait)) {
   text(speechString, 100, 100, 640, 480);
   currentTime = millis();
   canvas.background(127, 127, 127);
  }
  
  //convertCanvasToTexture(canvas);
  spout.sendTexture();
}

//void convertCanvasToTexture(canvas) {
    
//}

void exit() {
  //spout.closeSender();
  super.exit();
}

void stop() {
 socket.stop();
}

void websocketOnMessage(WebSocketConnection con, String msg) {
//println(msg);
//if (msg.contains("hello")) println("yay");
//text(msg, 100, 100);

  if (renderCount > 1) {  
    speechOn = false;
    speechString = msg;
    
    speechOn = true;
  } else {
    speechOn = true;
    speechString = msg;
  }
}

void websocketOnOpen(WebSocketConnection con) {
println("a client joined");
}

void websocketOnClose(WebSocketConnection con) {
println("a client exited");
}