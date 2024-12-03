class Button {
  // Class that manages custom text boxes
  PVector pos;
  PVector size;
  String text;
  int fontSize;
  boolean onWhiteBackground = false;

  Button(PVector pos, PVector size, String text) {
    this.pos = pos;
    this.size = size;
    this.text = text;

    fontSize = 32;
  }

  void display() {
    // Draws textbox
    push();
    translate(pos.x, pos.y);
    rectMode(CENTER);
    textAlign(CENTER);
    textSize(fontSize);
    
    // Mouse hover highlights
    if (mouseOver()) {
      fill(255, 0, 0);
    } else {
      if (!onWhiteBackground) {
        fill(255);
      }
      else {
        fill(0);
      }
    }
    
    text(text, 0, 10);
    pop();
  }

  boolean mouseOver() {
    // checks if mouse is over textbox
    return ((mouseX >= pos.x - size.x/2) &&
      (mouseX <= pos.x + size.x/2) &&
      (mouseY >= pos.y - size.y/2) &&
      (mouseY <= pos.y + size.y/2));
  }
  
  boolean clickedOn() {
    // checks if textbox has been clicked
    return (mouseOver() && mousePressed);
  }
}
