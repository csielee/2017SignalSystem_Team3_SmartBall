void drawGrid() {
  stroke(0);
  strokeWeight(1);
  fill(255);
  for (int i=0;i<=3;i++) {
    rect(0,(height/4)*i,rect_w,rect_h);
    rect(rect_w,(height/4)*i,rect_w, rect_h);
  }
  
  for (int i = 0; i < rect_w; i+=10) {
    stroke(200); // Grey
    line(i, 0, i,  rect_h);
    line(i, height/4, i, height/4 + rect_h);
    line(i, height/2, i, height/2 + rect_h);
    line(i, height/4*3, i, height/4*3 + rect_h);
    line(i + width/2, 0, i + width/2,  rect_h);
    line(i + width/2, height/4, i + width/2, height/4 + rect_h);
    line(i + width/2, height/2, i + width/2, height/2 + rect_h);
    line(i + width/2, height/4*3, i + width/2, height/4*3 + rect_h);
  }
  for (int i = 0;i < rect_h; i+=10) {
    stroke(200);
    line(0,i,rect_w,i);
    line(width/2,i,width/2+rect_w,i);
    line(0,height/4 + i,rect_w,height/4 + i);
    line(width/2,height/4 + i,width/2+rect_w,height/4 + i);
    line(0,height/2 + i,rect_w,height/2 + i);
    line(width/2,height/2 + i,width/2+rect_w,height/2 + i);
    line(0,height/4*3 + i,rect_w,height/4*3 + i);
    line(width/2,height/4*3 + i,width/2+rect_w,height/4*3 + i);
  }
  
  stroke(0); // Black
  for (int i = 1; i <= 3; i++) {
    if (i==2)
      continue;
    line(0, rect_h/4*i, width, rect_h/4*i);
    line(0, height/4+rect_h/4*i, width, height/4 + rect_h/4*i);
    line(0, height/2+rect_h/4*i, width, height/2 + rect_h/4*i);
    line(0, height/4*3+rect_h/4*i, width, height/4*3 + rect_h/4*i);
  }
}


void drawAxis() {
  noFill();
  strokeWeight(2.5);
  stroke(0, 0, 0); // Black
  // Redraw everything
  beginShape();
  vertex(0, accX[0]);
  for (int i = 1; i < accX.length; i++) {
    vertex(i, accX[i]);
  }
  endShape();
    
  noFill();
  stroke(255, 0, 0); // red
  // Redraw everything
  beginShape();
  vertex(rect_w, accY[0]);
  for (int i = 1; i < accY.length; i++) {
    vertex(i+rect_w, accY[i]);
  }
  endShape();

  noFill();
  stroke(34, 0, 136); // Blue
  // Redraw everything
  beginShape();
  vertex(0, accZ[0]);
  for (int i = 1; i < accZ.length; i++) {
    vertex(i, accZ[i]);
  }
  endShape();

  noFill();
  stroke(255,255, 0); // Yellow
  // Redraw everything
  beginShape();
  vertex(rect_w, acc[0]);
  for (int i = 1; i < acc.length; i++) {
    vertex(i+(rect_w), acc[i]);
  }
  endShape();
 
  // velocity   
  noFill();
  stroke(0, 0, 0); // Black
  // Redraw everything
  beginShape();
  vertex(0, vX[0]);
  for (int i = 1; i < vX.length; i++) {
    vertex(i, vX[i]);
  }
  endShape();

  noFill();
  stroke(255, 0, 0); // red
  // Redraw everything
  beginShape();
  vertex(rect_w, vY[0]);
  for (int i = 1; i < vY.length; i++) {
    vertex(i+rect_w, vY[i]);
  }
  endShape();

  noFill();
  stroke(34, 0, 136); // Blue
  // Redraw everything
  beginShape();
  vertex(0, vZ[0]);
  for (int i = 1; i < vZ.length; i++) {
    vertex(i, vZ[i]);
  }
  endShape();
  
  //V 
  noFill();
  stroke(255,255, 0); // Yellow
  // Redraw everything
  beginShape();
  vertex(rect_w, v[0]);
  for (int i = 1; i < v.length; i++) {
    vertex(i+(rect_w), v[i]);
  }
  endShape();
  
  
  textSize(25);
  fill(255);
  text("accel X : "+nf(AX,1,3) + "m/s^2",0,height/4);
  text("accel Y : "+nf(AY,1,3) + "m/s^2",width/2,height/4);

  text("accel Z : "+nf(AZ,1,3) + "m/s^2",0,height/2);
  text("total accel : " + nf(ACCEL,1,3) + "m/s^2",width/2, height/2);
  
  text("velocity X : "+nf(VX,1,3) + "m/s",0,height/4*3);
  text("velocity Y : "+nf(VY,1,3) + "m/s",width/2,height/4*3);
  
  text("velocity Z : "+nf(VZ,1,3) + "m/s",0,height);
  fill(0);
  text("total velocity : "+nf(V,1,3) + "m/s",width/2,height-25);
}