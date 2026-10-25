class HealthPowerUp {
  float x, y, radius;
  PImage sprite;  
  int lastCollectedTime = 0;  
  boolean isActive = true;  // Flag to determine if the power-up is active
  
  HealthPowerUp() {
    sprite = loadImage("healthpack.png"); 
    spawnOnRandomPlatform(); // Initially spawn on a platform
  }

  void update() {
    // If the power-up is not active, check if 10 seconds have passed to respawn
    if (!isActive && millis() - lastCollectedTime > 10000) {
      isActive = true;  // Respawn the health power-up
      spawnOnRandomPlatform(); 
    }
  }

  void display() {
    
    if (isActive) {
      imageMode(CENTER);
      image(sprite, x, y, radius * 2, radius * 2); 
    }
  }

  // Check if the zombie has picked up the power-up
  boolean checkCollision(Zombie zombie) {
    if (isActive) {
      float distX = abs(zombie.x - x);
      float distY = abs(zombie.y - y);
    
      // Check if within the hitbox range
      if (distX < zombie.w / 2 && distY < zombie.h / 2) {
        return true;
      }
    }
    return false;
  }

  // Spawn the health power-up on top of a random platform
  void spawnOnRandomPlatform() {
    int platformIndex = (int) random(0, platforms.length);  // Choose a random platform
    x = platforms[platformIndex].x;  // Position the health power-up on the chosen platform
    y = platforms[platformIndex].y - 20;  // Adjust for the top of the platform (20 units above)
    radius = 15; 
    isActive = true;  
  }

  // Reset the power-up's state when it is collected
  void reset() {
    isActive = false;
    lastCollectedTime = millis();  // Store the time it was collected
  }
}
