Zombie zombie;
Platform platforms[];
Health healthBar;
ArrayList<Ball> balls;
Star star;
HealthPowerUp healthPack;

int lastBallTime = 0;
float ballSpawnInterval = 1000;

// Score system
int score = 0;
int highScore = 0;
boolean gameOver = false;

// Game state control
boolean gameStarted = false;  

void setup() {
  size(600, 600);
  imageMode(CENTER);
  rectMode(CENTER);
  frameRate(60);
  
  zombie = new Zombie(width / 2, 0);
  healthBar = new Health();
  healthBar.setHealth(100);
  
  balls = new ArrayList<Ball>();

  platforms = new Platform[9];
  platforms[0] = new Platform(100, 300, 100);
  platforms[1] = new Platform(500, 300, 100);
  platforms[2] = new Platform(300, 400, 100);
  platforms[3] = new Platform(100, 100, 100);
  platforms[4] = new Platform(500, 100, 100);
  platforms[5] = new Platform(300, 200, 100);
  platforms[6] = new Platform(100, 500, 100);
  platforms[7] = new Platform(500, 500, 100);
  platforms[8] = new Platform(300, 600, 100);

  star = new Star();
  star.spawnOnPlatform();

  healthPack = new HealthPowerUp();
}

void draw() {
  background(50);

  // Show the main menu if the game hasn't started
  if (!gameStarted) {
    drawMainMenu();
    return;
  }

  // If the game is over, show the Game Over screen
  if (gameOver) {
    drawGameOverScreen();
    return;
  }

  rectMode(CENTER);

  if (zombie.health <= 0) {
    gameOver = true;
  }

  zombie.update();
  zombie.display();
  
  displayPlatforms();
  checkPlatformCollision();
  
  // Update and display all falling balls
  for (int i = balls.size() - 1; i >= 0; i--) {
    Ball b = balls.get(i);
    b.update();
    b.display();

    if (b.checkCollision(zombie)) {
      zombie.takeDamage(20);
      balls.remove(i);
    }

    if (b.y > height) {
      balls.remove(i);
    }
  }

  // Display and check star collection
  star.display();
  if (star.checkCollision(zombie)) {
    score++;
    star.spawnOnPlatform();
  }

  // Display the health pack and check for collision
  healthPack.update();
  healthPack.display();
  if (healthPack.checkCollision(zombie)) {
    zombie.health = min(zombie.health + 20, 100);
    healthPack.reset();
  }

  // Display health bar
  healthBar.update(zombie.x, zombie.y);
  healthBar.setHealth(zombie.health);
  healthBar.display();

  // Check if it's time to spawn a new ball
  int currentTime = millis();
  if (currentTime - lastBallTime > ballSpawnInterval) {
    spawnBall();
    lastBallTime = currentTime;
  }
}

// Function to display the Main Menu
void drawMainMenu() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(32);
  text("Zombie Survival", width / 2, height / 3);

  textSize(24);
  text("Press ENTER to Start", width / 2, height / 2);
}

// Function to display the Game Over screen
void drawGameOverScreen() {
  fill(255, 0, 0);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Game Over!", width / 2, height / 2 - 30);

  fill(255);
  textSize(24);
  text("Score: " + score, width / 2, height / 2);
  
  if (score > highScore) {
    highScore = score;
  }
  
  text("High Score: " + highScore, width / 2, height / 2 + 30);
  text("Press 'R' to Restart", width / 2, height / 2 + 60);
}

void spawnBall() {
  Ball newBall = new Ball(random(50, width - 50), 0);
  balls.add(newBall);
}

boolean objectIntersect(Zombie r1, Platform r2) {
  float distX = abs(r1.x - r2.x);
  float distY = abs(r1.y - r2.y);
  
  float combHalfW = r1.w / 2 + r2.w / 2;
  float combHalfH = r1.h / 2 + r2.h / 2;
  
  return (distX < combHalfW) && (distY < combHalfH);
}

void displayPlatforms() {
  for (Platform p : platforms) {
    p.display();
  } 
}

void checkPlatformCollision() {
  boolean onPlatform = false;

  for (int i = 0; i < platforms.length; i++) {
    if (objectIntersect(zombie, platforms[i])) {
      zombie.groundCheck(platforms[i].y);
      onPlatform = true;
      break;
    }
  }

  if (!onPlatform) {
    zombie.grounded = false;
  }
}

void keyPressed() {
  if (!gameStarted && key == ENTER) {
    gameStarted = true;
    return;
  }

  if (gameOver && key == 'r') {
    resetGame();
  } else {
    zombie.setMove(key, true);
  }
}

void keyReleased() {
  zombie.setMove(key, false);
}

void resetGame() {
  score = 0;
  zombie.health = 100;
  zombie.x = width / 2;
  zombie.y = 0;
  balls.clear();
  gameOver = false;
}
