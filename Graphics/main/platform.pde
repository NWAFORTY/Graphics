class Platform {
  float x, y, w, h;
  PImage platformImage;

  Platform(float xpos, float ypos, int sizeW) {
    x = xpos;
    y = ypos;
    w = sizeW;
    h = 40;

    platformImage = loadImage("platform.png");
  }

  void display() {
    image(platformImage, x, y, w, h);
  }
}
