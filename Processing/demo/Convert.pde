final int accel_lower = 20;
final int accel_upper = -20;
final int speed_lower = 20;
final int speed_upper = -20;
final int gyro_lower = 1000;
final int gyro_upper = -1000;

void convert() {
   if(stringDt != null) {
     stringDt = trim(stringDt);
     dt = float(stringDt);
     currentTime += dt;
     realdt = millis() - lastTime;
     lastTime = millis();
     if (first) {
       first = false;
       resetTime = millis();
     }
   }
  /* Convert the accelerometer x-axis */
  if (stringAccX != null) {
    stringAccX = trim(stringAccX); // Trim off any whitespace
    AX = float(stringAccX)*9.8;
    if (AX == -0.0)
      AX = 0.0;
    accX[accX.length - 1] = map(AX, accel_lower, accel_upper, 0, rect_h); // Convert to a float and map to the screen height, then save in buffer
  }

  /* Convert the accelerometer y-axis */
  if (stringAccY != null) {
    stringAccY = trim(stringAccY); // Trim off any whitespace
    AY = float(stringAccY)*9.8;
    if (AY == -0.0)
      AY = 0.0;
    accY[accY.length - 1] = map(AY, accel_lower, accel_upper, 0, rect_h); // Convert to a float and map to the screen height, then save in buffer
  }

  /* Convert accelerometer z-axis */
  if (stringAccZ != null) {
    stringAccZ = trim(stringAccZ); // Trim off any whitespace
    AZ = float(stringAccZ)*9.8;
    if (AZ == -0.0)
      AZ = 0.0;
    accZ[accZ.length - 1] = map(AZ, accel_lower, accel_upper, height/4 , height/4 + rect_h); // Convert to a float and map to the screen height, then save in buffer
  }
  
  /* Gyro */
  int gyrocount = 0;
  for (int i=0;i<3;i++) {
    if (stringGyro[i] != null) {
      stringGyro[i] = trim(stringGyro[i]);
      gyro[i] = float(stringGyro[i]);
      gyro[i] *= 131.0;
      gyrocount++; 
    }
  }
  if (gyrocount == 3) {
    gyroX[gyroX.length - 1] = map(gyro[0], gyro_lower, gyro_upper, 0 , rect_h);
    gyroY[gyroY.length - 1] = map(gyro[1], gyro_lower, gyro_upper, 0 , rect_h);
    gyroZ[gyroZ.length - 1] = map(gyro[2], gyro_lower, gyro_upper, height/4 , height/4 + rect_h);
    gyroTotal = sqrt(gyro[0]*gyro[0] + gyro[1] * gyro[1] + gyro[2]*gyro[2]);
    if (maxG < gyroTotal)
      maxG = gyroTotal;
    gyroT[gyroT.length - 1] = map(gyroTotal, gyro_lower, gyro_upper, height/4 , height/4 + rect_h);
  }
  
  /* q */
  int quatcount = 0;
  for (int i=0;i<4;i++) {
    if (stringq[i] != null) {
      stringq[i] = trim(stringq[i]);
      q[i] = float(stringq[i]);
      quatcount ++;
    }
  }
  
  if (quatcount == 4)
    quat.set(q[0],q[1],q[2],q[3]);
  
  ACCEL = sqrt(AX*AX+AY*AY+AZ*AZ);
  acc[acc.length - 1] = map(ACCEL, accel_lower, accel_upper, height/4, height/4 + rect_h);
  
  VX = VX + AX*dt;
  vX[vX.length - 1] = map(VX, speed_lower, speed_upper, height/2, height/2  + rect_h); 
  VY = VY + AY*dt;
  vY[vY.length - 1] = map(VY, speed_lower, speed_upper, height/2 , height/2 + rect_h); 
  VZ = VZ + AZ*dt;
  vZ[vZ.length - 1] = map(VZ, speed_lower, speed_upper, height/4*3, height/4*3 + rect_h); 
 
  V = sqrt(VX*VX+VY*VY+VZ*VZ);
  v[v.length - 1] = map(V, speed_lower, speed_upper, height/4*3,height/4*3 + rect_h);
  
  if (V > maxV)
    maxV = V;
}

void updateData() {
  // Put all data one array back
  for (int i = 1; i<accX.length;i++)
    accX[i-1] = accX[i];
  
  // Put all data one array back
  for (int i = 1; i<accY.length;i++)
    accY[i-1] = accY[i];
    
  // Put all data one array back
  for (int i = 1; i<accZ.length;i++)
    accZ[i-1] = accZ[i];
    
  // Put all data one array back
  for (int i = 1; i<acc.length;i++)
    acc[i-1] = acc[i];
    
  // Put all data one array back
  for (int i = 1; i<vX.length;i++)
    vX[i-1] = vX[i];
    
  // Put all data one array back
  for (int i = 1; i<vY.length;i++)
    vY[i-1] = vY[i];
  
  // Put all data one array back
  for (int i = 1; i<vZ.length;i++)
    vZ[i-1] = vZ[i];
    
  // Put all data one array back
  for (int i = 1; i<v.length;i++)
    v[i-1] = v[i];  
    
  for (int i = 1; i<gyroX.length;i++)
    gyroX[i-1] = gyroX[i];  
    
  for (int i = 1; i<gyroY.length;i++)
    gyroY[i-1] = gyroY[i];  
    
  for (int i = 1; i<gyroZ.length;i++)
    gyroZ[i-1] = gyroZ[i];  
    
  for (int i = 1; i<gyroT.length;i++)
    gyroT[i-1] = gyroT[i];  
    
}