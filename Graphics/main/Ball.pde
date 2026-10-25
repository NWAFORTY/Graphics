class Ball {
  float x, y, radius;
  float dy; // Vertical speed

  Ball(float xpos, float ypos) {
    x = xpos;
    y = ypos;
    radius = 15;
    dy = 5; 
  }

  void update() {
    y += dy; // Move the ball down
  }

  void display() {
    fill(200, 50, 50); // Red color
    ellipse(x, y, radius * 2, radius * 2); // Draw the ball as a circle
  }

  // Check collision with the zombie
  boolean checkCollision(Zombie zombie) {
    float distX = abs(zombie.x - x);
    float distY = abs(zombie.y - y);

    // Check if the ball collides with the zombie
    if (distX < zombie.w / 2 && distY < zombie.h / 2) {
      return true;
    }
    return false;
  }
}
