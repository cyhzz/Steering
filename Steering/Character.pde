class Character{
  //Our character contain a circle to indicate the position
  Circle circle;
  //Move Variables
  //The normalized vector the character should go to
  PVector direction;
  //The maxSpeed character can achieve
  float maxSpeed;
  //The max acceleration character can achieve
  float maxAcc;
  //In case other characters want to have different slowRadius,I put it in 
  //character rather than our target
  float slowRadius;
  float stopRadius;
  //Rotation Variables
  //The max rotation speed
  float maxAngularAcc;
  //The max target rotation
  float maxRotation;
  //The range of slow down the rotation
  float roSlowRadius;
  //The range of stop the rotation
  float roStopRadius;
  
  //Temporary variables for moving
  //The target moving speed we are aiming for
  float targetSpeed;
  //Current velocity
  PVector currentVelocity;
  //The target velocity we are aiming for
  PVector targetVelocity;
  //Current acceleartion
  PVector currentAcc;
  //Temporary variables for rotation
  //The current angle of our character
  float angle;
  //The angle between us and our target
  float rotation;
  //The size of the rotation
  float rotationSize;
  //The targetRotation we want to get
  float targetRotation;
  //The angular acceleration
  float angularAcc;
  //The current angular acceleration
  float currentRotationSpeed;
  //Constructor  
  Character(Circle agent,float maxSpeed,float maxAcc,float slowRadius,float stopRadius,
  float maxAngularAcc,float maxRotation,float roSlowRadius, float roStopRadius)
  {
    circle=agent;
    this.maxSpeed=maxSpeed;
    this.maxAcc=maxAcc;
    this.slowRadius=slowRadius;
    this.stopRadius=stopRadius;
    currentVelocity=new PVector(0,0);
    targetVelocity=new PVector(0,0);
    currentAcc=new PVector(0,0);
    this.maxAngularAcc=maxAngularAcc;
    this.maxRotation=maxRotation;
    this.roSlowRadius=roSlowRadius;
    this.roStopRadius=roStopRadius;
    angle=0;
    rotation=0;
    rotationSize=0;
    targetRotation=0;
    angularAcc=0;
    currentRotationSpeed=0;

  }
  //Chase a target
  void chase(PVector target_)
  {
    //Copy the value of target into a new PVector
    PVector target=new PVector(target_.x,target_.y);
    //Calculate the origin directioin
    PVector rawDirection=target.sub(circle.pos);
    //Get the distance
    float distance=rawDirection.mag();
    direction=rawDirection.normalize();
    //If the distance is in our stop range
    if(distance<stopRadius){
      //We should have a speed of 0
      targetSpeed=0;
     // currentVelocity=new PVector(0,0);
    }
    //If the distance is in our slow radius
    else if(distance>slowRadius)
    {
      //We should go at our max speed
      targetSpeed=maxSpeed;
    }
    //If the distance is between the slow radius and stop radius
    else{
     //Lerp the target speed
      targetSpeed=maxSpeed*distance/slowRadius;
    }
    //Set our target velocity
    targetVelocity=direction;
    targetVelocity=targetVelocity.mult(targetSpeed);
    //acceleratioin calculation
    currentAcc=targetVelocity.sub(currentVelocity);
    currentAcc=currentAcc.div(5);
    //Clip it in the range
    ClipAcc();
  }
  //Clip our acceleration
  void ClipAcc()
  {
    if(currentAcc.mag()>maxAcc)
    {
     // println(currentAcc);
      currentAcc.normalize();
      currentAcc=currentAcc.mult(maxAcc);
    }
  }
  //Get our angle in a range of 0~TWO_PI
/*  float mapToRange(float angle)
  {
    float result=0;
    if(angle>PI)
    {
     result=angle-TWO_PI;
    }
    else if(angle<-PI)
    {
      result=angle+TWO_PI;
    }
    else{
      result=angle;
    }
    return result;
  }
  */
  //Our rotation function
  void rotateTo(PVector target_)
  {
    //Get the target of our rotation
      PVector target=new PVector(target_.x,target_.y);
      //Get the rotation between us and our target
      rotation=(target.sub(circle.pos)).heading();
     //Make the angle in a range of 0~TWO_PI
     // rotation=mapToRange(rotation);
      //Get the origin angle we should rotate
      float rawRotate=rotation-angle;
      //If our rotation is above PI
      if(rawRotate>PI)
      {
        //Let them in a range of 0~TWO_PI
        rotationSize=abs(rawRotate-TWO_PI);
        rawRotate=rawRotate-TWO_PI;  
      }
      //If our rotation is below -PI
      else if(rawRotate<-PI){
         //Let them in a range of 0~TWO_PI
        rotationSize=abs(TWO_PI+rawRotate);
        rawRotate=TWO_PI+rawRotate;
      }
      else{
        rotationSize=abs(rotation-angle);
      }
      //If the rotation we should take is in our stop range
      if(rotationSize<roStopRadius)
      {
        //Then we shouldn't rotate
        targetRotation=0;
      }
      //If the rotation is above the slow range
      else if(rotationSize>roSlowRadius)
      {
        //Rotate at a max rotating speed
        targetRotation=maxRotation;
      }
      //If the rotation is in range of stop and slow range
      else{
        //Lerp the target rotation
        targetRotation=maxRotation*rotationSize/roSlowRadius;
      }
      //In case we have a 0 in denominator
      if(rotationSize==0)
      {
        rotationSize=1;
      }
      //Apply direction to our target rotation
      targetRotation*=rawRotate/rotationSize;
      //Calculate the target angular acceleration
      angularAcc=targetRotation-currentRotationSpeed;
      angularAcc/=2;
      //Get the absoluate value of the anular acceleration
      float absAngularAcc=abs(angularAcc);
      //Clip the value
      if(absAngularAcc>maxAngularAcc)
      {
        angularAcc/=absAngularAcc;
        angularAcc*=maxAngularAcc;
      }
  }
  //Call every frame
  void update(PVector followTarget ){
    chase(followTarget);
    rotateTo(followTarget);
  }
  void display()
  {
    //Update the position by the velocity
    circle.pos.x+=currentVelocity.x;
    circle.pos.y+=currentVelocity.y;
    //Update the current velocity by the acceleration
    currentVelocity=currentVelocity.add(currentAcc);
   //Update the angle by the rotation speed
    angle+=currentRotationSpeed;
    //Update the rotation speed by the angular acceleration
    currentRotationSpeed+=angularAcc;
    //Display the circle
    circle.display();
    //Use a line to indicate the direction of our character
    stroke(0);
    line(circle.pos.x,circle.pos.y,
    circle.pos.x+cos(angle)*circle.radius,
    circle.pos.y+sin(angle)*circle.radius);
    //stroke(0,100,22);
    // line(circle.pos.x,circle.pos.y,cos(rotation)*100+circle.pos.x,sin(rotation)*100+circle.pos.y);
    //noFill();
    // stroke(255,0,255);
    // ellipse(circle.pos.x,circle.pos.y,slowRadius*2,slowRadius*2);
    // stroke(255,0,0);
    // ellipse(circle.pos.x,circle.pos.y,stopRadius*2,stopRadius*2);
  }
}
