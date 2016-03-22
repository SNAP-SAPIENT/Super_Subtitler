import muthesius.net.*; //<>//

//import codeanticode.syphon.*;
import processing.opengl.*;

import org.webbitserver.*;


PGraphics canvas;
//SyphonServer server;
float factor;
WebSocketP5 socket;
PFont font;
//Spout spout;
boolean speechOn;
String speechString;


void setup()
{
  // DISPLAY SETUP
  size(640, 480, P3D);
  canvas = createGraphics(640, 480, P3D);
  textureMode(NORMAL);
  textMode(SHAPE);
  textSize(48);
  frameRate(30);
  // SYPHON SETUP - OSX Only
  //server = new SyphonServer(this, "Speech Input");
  // SPOUT SETUP - Windows Only
  //spout = new Spout();
  //spout.initSender("Super-Subtitler", width, height);
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
}


// RENDER AND SEND TO SYPHON
void draw()
{
  canvas.beginDraw();
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
  
  //DRAW TEXT WHEN WEBSOCKET GETS DATA BACK
  //if(speechOn) {
  //  text(speechString, 100, 100);
  //} else {
  //  //IF NO STRING, CREATE COLORED BACKGROUND
  //  canvas.background(127, 127, 127);
  //}
  
  //convertCanvasToTexture(canvas);
  //spout.sendTexture();
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

// SEND ORDER TO MILLUMIN
//void mouseMoved()
//{
//  OscMessage myOscMessage = new OscMessage("/millumin/layer/opacity/0");
//  myOscMessage.add(100*mouseX/width);
//  oscP5.send(myOscMessage, myBroadcastLocation);
//}

void websocketOnMessage(WebSocketConnection con, String msg) {
println(msg);
//if (msg.contains("hello")) println("yay");
//text(msg, 100, 100);

  speechOn = true;
  speechString = msg;
  
  //if (speechString == speechString) {
  //  speechOn = false;
  //}
}

void websocketOnOpen(WebSocketConnection con) {
println("a client joined");
}

void websocketOnClose(WebSocketConnection con) {
println("a client exited");
}


// RECEIVE ORDER FROM MILLUMIN
//void oscEvent(OscMessage theOscMessage)
//{
//  if ( theOscMessage.addrPattern().equals("/millumin/layer/scale/0") )
//  {
//    factor = theOscMessage.get(0).floatValue()/100;
//  }
//}