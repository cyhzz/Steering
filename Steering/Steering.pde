//Our cursor's circle area
Circle cursor;
//Our character
Character character;
//A container for the black dots we create
ArrayList<Black> list=new ArrayList<Black>();

//Math function to clip a value in a and b
float Clip(float value,float a,float b)
{
  float res=value;
  if(res>b)
  res=b;
  if(res<a)
  res=a;
  return res;
}

void setup()
{
  //Our window is 400*400
  size(400,400);
  //Create the instance of our circle to follow our cursor
  cursor=new Circle(new PVector(mouseX,mouseY),10,color(0),color(200,100));
  //Create the instance of our character,initalize it,maxSpeed is 5,maxAcceleration is 10,slowRadius is 75, stopRadius is 40,maxAngualr acceleeration is PI/50,
  //maxRotation is PI/25, the slowRange of angle is PI/15, and the stopRange of angle is PI/30
  character= new Character(new Circle(new PVector(0,0),10,color(0),color(255)),
  5,10,75,40,PI/50,PI/25,PI/15,PI/30);
}

void draw()
{
  //Draw a gray background
  background(200);
  //Update the position of our area of cursor
  cursor.pos=new PVector(mouseX,mouseY);
  //Display the cursor
  cursor.display();
  //Update the acceleration,and angular acceleration of our character
  character.update(new PVector(mouseX,mouseY)); 
  //Update the acceleration force of our black blocks
  for(int i=0;i<list.size();i++)
  {
     list.get(i).update();
  }
  //Display the character
  character.display();
  //Display our black blocks
  for(int i=0;i<list.size();i++)
  {
    list.get(i).display();
  }
}
//If we pressed the mouse
void mousePressed()
{
  //Create an instance of black block at the position of cursor,radius is 10,the affection radius is 85,and the affection force is 400
  Black black=new Black(new PVector(mouseX,mouseY),10,85,400);
  //Add the instance to the list
  list.add(black);
}
