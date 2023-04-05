// Class for animating a sequence of GIFs

class Animation {
  PImage[] images;
  PVector size;
  int imageCount;
  int frame;
  int rate;

  Animation(String imagePrefix, int count, int rate, PVector size) {
    imageCount = count;
    images = new PImage[imageCount];
    this.size = size;
    
    this.rate = rate;
    frame = 0;

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into three digits
      String filename = imagePrefix + nf(i, 3) + ".png";
      images[i] = loadImage(filename);
    }
  }

  void display(float xpos, float ypos) {
    // Displays animated sprite
    if (frameCount % rate == 0) {
      frame = (frame+1) % imageCount;
    }
    imageMode(CENTER);
    image(images[frame], xpos, ypos, size.x, size.y);
  }

  int getWidth() {
    // Returns width of sprite
    return images[0].width;
  }
}
