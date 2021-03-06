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
  background(0, 0, 0);
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
  canvas.endDraw();
  image(canvas, 0, 0);
  // AN ISSUE EXISTS WITH OPENGL AND WRITING TO OPENGL ON THIS LINE
  //server.sendImage(canvas);
  
  //DRAW TEXT WHEN WEBSOCKET GETS DATA BACK
  if(speechOn && (millis() - currentTime >= wait)) {
   text(speechString, 100, 50, 480, 480);
   currentTime = millis();
   canvas.background(0, 0, 0);
  }
  //SEND TEXTURE TO SPOUT
  spout.sendTexture();
}

void exit() {
  spout.closeSender();
  super.exit();
}

void stop() {
 socket.stop();
}

void websocketOnMessage(WebSocketConnection con, String msg) {
//println(msg);

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