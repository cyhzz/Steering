class Black extends Circle{
  //The radius of our pulling away effect
  public float affectRadius;
  //The strength of our pulling away effect
  public float pullStrength;
  //Constructor
  public Black(PVector pos_,float radius_,float affectRadius,float pullStrength)
  {
    //Create the circle
    super(pos_,radius_,color(0),color(0));
    //Initialize values
    this.affectRadius=affectRadius;
    this.pullStrength=pullStrength;
  }
  //Call every frame
   void update()
   {
     //The target of our effection is the character
     PVector target=new PVector(character.circle.pos.x,character.circle.pos.y);
     //The origin direction we can get
     PVector raw=target.sub(pos);
     //If the character is colliding with us
     if(raw.mag()<radius+character.circle.radius)
     {
       //Bounce it away
       character.currentVelocity=character.currentVelocity.mult(-1);
     }
     //If the character is in the range of our effect
     if(raw.mag()<affectRadius)
     {
       //Calculate the current acceleration
       PVector after=new PVector(character.currentAcc.x,character.currentAcc.y);
       //Normalize the raw direction
       PVector constant=new PVector(raw.x,raw.y);
       constant.normalize();
       //Get the final pulling acceleration
       PVector dir=constant.div(raw.mag()*raw.mag()).mult(pullStrength);
       //If after we apply our force the acceleration is still in the range
       if(after.add(dir).mag()<character.maxAcc)
       {
         //Then apply it
         character.currentAcc.add(dir);
       }
     }
   }
   //Call every frame
   void display()
   {
     super.display();
     //noFill();
    // ellipse(pos.x,pos.y,affectRadius*2,affectRadius*2);
   }
   
}
