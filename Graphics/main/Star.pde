class Star {
  float x, y;
  float radius = 15;
  PImage sprite;

  Star() {
    sprite = loadImage("star.png");
    spawnOnPlatform();  
  }

  void display() {
    imageMode(CENTER);
    image(sprite, x, y, radius * 2, radius * 2);
  }

  boolean checkCollision(Zombie zombie) {
    float distX = abs(zombie.x - x);
    float distY = abs(zombie.y - y);
    
    if (distX < zombie.w / 2 && distY < zombie.h / 2) {
      return true;
    }
    return false;
  }

  void spawnOnPlatform() {
    int platformIndex = (int) random(0, platforms.length); // Pick a random platform
    x = platforms[platformIndex].x;  // Center star on platform
    y = platforms[platformIndex].y - 20; // Spawn slightly above the platform (20 pixels above)
  }
}
