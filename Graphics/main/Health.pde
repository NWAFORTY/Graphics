class Health {
  float x, y, w, h;
  int health;
  color green, yellow, red;

  Health() {  
    h = 10;
    health = 100; 
    green = color(100, 150, 100);
    yellow = color(150, 150, 100);
    red = color(150, 100, 100);
  }

  void display() {
    // Set the width based on health (max 100)
    w = health;

    // Determine health bar color
    if (health > 60) {
      fill(green);
    } else if (health > 30) {
      fill(yellow);
    } else {
      fill(red);
    }

    noStroke();
    rectMode(CORNER);
    rect(x, y, w / 2, h); 
  }

  void update(float zombieX, float zombieY) {
    // Center the health bar above the zombie
    x = zombieX - (w / 2);
    y = zombieY - 70; // Position the health bar above the zombie
  }

  void setHealth(int healthAmount) {
    health = constrain(healthAmount, 0, 100); // Keep health between 0-100
  }
}
