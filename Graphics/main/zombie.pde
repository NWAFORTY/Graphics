class Zombie {
  PImage spriteSheet;
  PImage[][] zombieFrames;
  
  float x, y, w, h;
  float dx, dy;
  float speed;
  int direction;
  
  boolean isLeft, isRight, isUp;
  boolean grounded;
  float g;
  
  int health;
  
  int totalRows = 5; // 5 animation states
  int[] framesPerRow = {5, 7, 9, 9, 11}; // Number of frames in each row
  int frameWidth, frameHeight;
  
  int frameIndex = 0;
  int frameDelay = 5; // Adjust for animation speed
  int counter = 0;
  
  int currentRow = 0; // Default animation row (idle)

  Zombie(float xpos, float ypos) {
    x = xpos;
    y = ypos;
    w = 70;
    h = 70;
    
    spriteSheet = loadImage("zombie.png");
    frameWidth = spriteSheet.width / 11; 
    frameHeight = spriteSheet.height / totalRows;
    
    zombieFrames = new PImage[totalRows][];
    
    // Extract frames from sprite sheet
    for (int row = 0; row < totalRows; row++) {
      zombieFrames[row] = new PImage[framesPerRow[row]];
      for (int col = 0; col < framesPerRow[row]; col++) {
        zombieFrames[row][col] = spriteSheet.get(col * frameWidth, row * frameHeight, frameWidth, frameHeight);
      }
    }
    
    direction = 1;
    dx = 8;
    speed = 0;
    
    grounded = false;
    g = 0.6;
    
    health = 100;
  }

  void display() {
    if (health <= 0) return; // Don't display if dead

    pushMatrix();
    translate(x, y);
    scale(direction, 1);
    
    // Ensure frameIndex is within bounds for the current row
    frameIndex = frameIndex % framesPerRow[currentRow];
    
    image(zombieFrames[currentRow][frameIndex], -w / 2, -h / 2, w, h);
    popMatrix();
  }

  void update() {
    if (health <= 0) {
      return; // Stop updating if zombie is dead
    }

    x += speed;

    // Set animation based on movement
    if (isRight) {
      speed = dx;
      direction = 1;
      currentRow = 2; // Walking animation
    } else if (isLeft) {
      speed = -dx;
      direction = -1;
      currentRow = 2; // Walking animation
    } else {
      currentRow = 0; // Idle animation
    }

    if (isUp && grounded) {
      dy = -10;
      grounded = false;
      currentRow = 4; // Jumping animation
    }

    if (!grounded) {
      dy += g;
    }

    y += dy;
    
    // Kill zombie if it falls off screen
    if (y > height) { 
      health = 0; // Set health to 0 when falling off screen
    }

    speed *= 0.8;

    // Handle animation timing
    counter++;
    if (counter >= frameDelay) {
      frameIndex = (frameIndex + 1) % framesPerRow[currentRow]; 
      counter = 0;
    }
  }

  void groundCheck(float newY) {
    dy = 0;
    grounded = true;
    y = newY - h / 2;
  }
  
  void takeDamage(int damage) {
    health -= damage;
    if (health < 0) {
      health = 0; // Prevent health from going below 0
    }
  }

  boolean setMove(char k, boolean b) {
    switch (k) {
      case 'a': return isLeft = b;
      case 'd': return isRight = b;
      case 'w': return isUp = b;
      default: return b;
    }
  }
}
