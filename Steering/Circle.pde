class Circle{
  public PVector pos;
  color stroke;
  color fill;
  float radius;
  
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
