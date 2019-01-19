Circle cursor;

void setup()
{
  size(400,400);
  cursor=new Circle(new PVector(mouseX,mouseY),10,color(0),color(200,100));
}

void draw()
{
  background(200);
  cursor.pos=new PVector(mouseX,mouseY);
  cursor.display();
}
