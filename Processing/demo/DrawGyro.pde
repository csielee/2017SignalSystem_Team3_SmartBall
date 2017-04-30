void drawGyro() {
  
  noFill();
  strokeWeight(2.5);
  stroke(0, 0, 0); // Black
  // Redraw everything
  beginShape();
  vertex(0, gyroX[0]);
  for (int i = 1; i < gyroX.length; i++) {
    vertex(i, gyroX[i]);
  }
  endShape();
    
  noFill();
  stroke(255, 0, 0); // red
  // Redraw everything
  beginShape();
  vertex(rect_w, gyroY[0]);
  for (int i = 1; i < gyroY.length; i++) {
    vertex(i+rect_w, gyroY[i]);
  }
  endShape();

  noFill();
  stroke(34, 0, 136); // Blue
  // Redraw everything
  beginShape();
  vertex(0, gyroZ[0]);
  for (int i = 1; i < gyroZ.length; i++) {
    vertex(i, gyroZ[i]);
  }
  endShape();

  noFill();
  stroke(255,255, 0); // Yellow
  // Redraw everything
  beginShape();
  vertex(rect_w, gyroT[0]);
  for (int i = 1; i < gyroT.length; i++) {
    vertex(i+(rect_w), gyroT[i]);
  }
  endShape();
 
  
  textSize(25);
  fill(255);
  text("GYRO X : "+nf(gyro[0],3,2) + " degree/s",0,height/4);
  text("GYRO Y : "+nf(gyro[1],3,2) + " degree/s",width/2,height/4);

  text("GYRO Z : "+nf(gyro[2],3,3) + " degree/s",0,height/2);
  text("total GYRO : " + nf(gyroTotal,3,2) + " degree/s",width/2, height/2);
}