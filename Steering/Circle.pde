class Circle{
  //The position of our circle
  public PVector pos;
  //The radius of our circle
  float radius;
  color stroke;
  color fill;
  
  Circle(PVector pos_,float radius_,color stroke_,color fill_)
  {
    pos=pos_;
    radius=radius_;
    stroke=stroke_;
    fill=fill_;
  }
  void display()
  {
    stroke(stroke);
    fill(fill);
    pushMatrix();
    translate(pos.x,pos.y);
    ellipse(0,0,radius*2,radius*2);
    popMatrix();
  }
  
}
