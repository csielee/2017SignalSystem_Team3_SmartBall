import processing.serial.*;
import toxi.geom.*;

Serial serial;

String stringAccX, stringAccY,stringAccZ;
String stringDt;


int rect_w = 500;
int rect_h = 150;

float dt;
float VX = 0.0,VY = 0.0,VZ = 0.0;
float AX,AY,AZ;
float ACCEL,V;
float currentTime;
float realdt;
int lastTime,resetTime = 0;

String stringYaw,stringPitch,stringRoll;
float yaw,pitch,roll;

String[] stringq = new String[4];
float[] q = new float[4];
Quaternion quat = new Quaternion(1, 0, 0, 0);

String[] stringGyro = new String[3];
float[] gyro = new float[3];
float gyroTotal = 0.0;

float[] accX = new float[rect_w];
float[] accY = new float[rect_w];
float[] accZ = new float[rect_w];
float[] acc = new float[rect_w];
float[] vX = new float[rect_w];
float[] vY = new float[rect_w];
float[] vZ = new float[rect_w];
float[] v = new float[rect_w];

float[] gyroX = new float[rect_w];
float[] gyroY = new float[rect_w];
float[] gyroZ = new float[rect_w];
float[] gyroT = new float[rect_w];

boolean drawValues  = false;
boolean first = true;

int showMode = 0;
final int ModeNumber = 3;

void setup() {
  size(1000, 700,P3D);
  frameRate(100);
  
  println(Serial.list()); // Use this to print connected serial devices
  if (Serial.list().length == 0) 
    exit();
  serial = new Serial(this, Serial.list()[0], 115200); // Set this to your serial port obtained using the line above
  serial.bufferUntil('\n'); // Buffer until line feed

  for (int i = 0; i < accX.length; i++) { // center all variables
    accX[i] = rect_h/2;
    gyroX[i] = rect_h/2;
    accY[i] = rect_h/2;
    gyroY[i] = rect_h/2;
    accZ[i] = height/4 + rect_h/2;
    gyroZ[i] = height/4 + rect_h/2;
    acc[i] = height/4 + rect_h/2;
    gyroT[i] = height/4 + rect_h/2;
    vX[i] = height/2 + rect_h/2;
    vY[i] = height/2 + rect_h/2;
    vZ[i] = (height/4)*3 + rect_h/2;
    v[i] = (height/4)*3 + rect_h/2;
  }
  
  currentTime = 0.0;
  lastTime = millis();

  //drawGraph(); // Draw graph at startup

}

void draw() {
  background(128);
  if (drawValues) {
    convert();
    drawValues = false;
  }
  
  switch(showMode) {
    case 0: // show accel velocity
      drawGrid();
      drawAxis();
      break;
    case 1: 
      drawSphere();
      break;
    case 2:
      drawGrid();
      drawGyro();
      break;
    default:
      break;
  }
  drawtext();
  updateData();
}

void serialEvent (Serial serial) {
  // Get the ASCII strings:
  
  stringDt = serial.readStringUntil('\t');
  stringAccX = serial.readStringUntil('\t');
  stringAccY = serial.readStringUntil('\t');
  stringAccZ = serial.readStringUntil('\t');
  stringGyro[0] = serial.readStringUntil('\t');
  stringGyro[1] = serial.readStringUntil('\t');
  stringGyro[2] = serial.readStringUntil('\t');
  stringq[0] = serial.readStringUntil('\t');
  stringq[1] = serial.readStringUntil('\t');
  stringq[2] = serial.readStringUntil('\t');
  stringq[3] = serial.readStringUntil('\n');
  
  serial.clear(); // Clear buffer
  drawValues = true; // Draw the graph

  println(stringq[0] + "\t" + stringq[1] + "\t" + stringq[2] + "\t" + stringq[3]);

}

void mouseClicked() {
  print("reset Velocity\n");
  VX = 0.0;
  VY = 0.0;
  VZ = 0.0;
  V = 0.0;
  
  for (int i = 0; i < vX.length; i++) { // center all variables
    vX[i] = height/2 + rect_h/2;
    vY[i] = height/2 + rect_h/2;
    vZ[i] = (height/4)*3 + rect_h/2;
    v[i] = (height/4)*3 + rect_h/2;
  }
  currentTime = 0.0;
  resetTime = millis();
}

void keyPressed() {
  if (keyCode == RIGHT) {
    showMode = (showMode+1)%ModeNumber;
  }
  if (keyCode == LEFT) {
    if (showMode == 0)
      showMode = ModeNumber - 1;
    else
      showMode = (showMode-1)%ModeNumber;
  }
}

void drawtext() {
  textSize(25);
  fill(255);
  text("time:"+nf(currentTime,1,2) + "s " + "real dt:"+nf(realdt/1000,1,2) + "s " + "real time:"+nf(((float)(millis() - resetTime))/1000,1,2) + "s",width/2,height);
}