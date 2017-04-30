void drawSphere() {
  pushMatrix();
  //center
  translate(width/2,height/2);
  fill(255);
  stroke(255,255,0);
  strokeWeight(3);
  sphereDetail(12);
  
  
  //rotate
  float[] tmp = quat.toAxisAngle(); 
  
  /*rotateX(tmp[1]);
  rotateY(tmp[2]);
  rotateZ(tmp[3]);
  rotate(tmp[0]);*/
  rotate(tmp[0],tmp[2],-tmp[3],tmp[1]);
  
  sphere(width/4);
  
  popMatrix();
  
  textSize(25);
  fill(255);
  String tmpstr = nf(q[0]) + "\n" + nf(q[1]/sqrt(1-q[0]*q[0])) + "\n" + nf(q[2]/sqrt(1-q[0]*q[0])) + "\n" + nf(q[3]/sqrt(1-q[0]*q[0]));
  text(tmpstr,0,50);
}